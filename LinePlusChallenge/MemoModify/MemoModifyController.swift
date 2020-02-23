//
//  MemoModifyController.swift
//  LinePlusChallenge
//
//  Created by Insu Park on 2020/02/17.
//  Copyright © 2020 INSWAG. All rights reserved.
//

import UIKit
import Kingfisher    // https://github.com/onevcat/Kingfisher
import YPImagePicker // https://github.com/Yummypets/YPImagePicker

class MemoModifyController: ViewController {
    
    // MARK:- Properties
    
    let navigator: Navigator
    let viewModel: MemoModifyControllerViewModel
    
    let notiCenter = NotificationCenter.default
    
    var memoTitle: String = ""
    var memoContents: String = ""
    var images: [UIImage] = []
    
    // MARK:- YPImagePicker Properties
    
    let libraryPicker: YPImagePicker = {
        var config = YPImagePickerConfiguration()
        config.library.maxNumberOfItems = 10
        config.isScrollToChangeModesEnabled = true
        config.onlySquareImagesFromCamera = true
        config.usesFrontCamera = false
        config.startOnScreen = YPPickerScreen.photo
        config.screens = [.library]
        config.showsCrop = .none
        config.targetImageSize = YPImageSize.original
        config.overlayView = UIView()
        config.hidesStatusBar = true
        config.hidesBottomBar = false
        config.preferredStatusBarStyle = UIStatusBarStyle.default
        let imagePicker = YPImagePicker(configuration: config)
        return imagePicker
    }()
    
    // MARK:- UI Properties
    
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: UIScreen.main.bounds,
                             style: UITableView.Style.plain)
        tv.allowsSelection = false
        tv.backgroundColor = .white
        tv.separatorStyle = .none
        tv.dataSource = self
        tv.delegate = self
        tv.register(MemoModifyPhotoCell.self,
                    forCellReuseIdentifier: String(describing: MemoModifyPhotoCell.self))
        tv.register(MemoModifyTitleCell.self,
                    forCellReuseIdentifier: String(describing: MemoModifyTitleCell.self))
        tv.register(MemoModifyContentCell.self,
                    forCellReuseIdentifier: String(describing: MemoModifyContentCell.self))
        return tv
    }()
    
    let memoTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Editing.."
        label.textAlignment = .center
        label.textColor = UIColor.black
        return label
    }()
    
    lazy var completeButton = UIBarButtonItem(title: "Save",
                                              style: .plain,
                                              target: self,
                                              action: #selector(actionSave))
    
    @objc func actionSave() {
        // 제목이 입력되지 않은 경우에 대한 alert 처리가 필요.
        guard self.memoTitle.isEmpty == false else {
            let alert = UIAlertController(title: nil,
                                          message: "제목을 입력해주세요",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK",
                                          style: .default,
                                          handler: nil))
            self.present(alert, animated: true)
            return
        }
        
        viewModel.editMemo(objectID: (viewModel.memo?.objectID)!,
                           title: self.memoTitle,
                           contents: self.memoContents,
                           images: self.images) {
            print("Success")
        }
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK:- Initialize & Deinitialize
    
    init(navigator: Navigator, viewModel: MemoModifyControllerViewModel) {
        self.navigator = navigator
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        notiCenter.removeObserver(self,
                                  name: NSNotification.Name("addPhotos"),
                                  object: nil)
        notiCenter.removeObserver(self,
                                  name: NSNotification.Name("deletePhotos"),
                                  object: nil)
    }
    
    // MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        receivePost()
        fetchMemoSingle()
    }
    
    // MARK:- UI Methods
    
    override func setupUIComponents() {
        self.navigationItem.rightBarButtonItem = completeButton
        self.navigationItem.titleView = memoTitleLabel
        
        self.view.backgroundColor = .white
        
        [tableView].forEach {
            self.view.addSubview($0)
        }
    }
    
    override func setupUILayout() {
        tableView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK:- Methods
    
    func fetchMemoSingle() {
        viewModel.fetchSingle {
            self.tableView.reloadData()
            self.sync() // 뷰 모델에서 데이터를 가져와 각 셀에 데이터를 뿌려줬지만, 실질적으로 Insert 하려는 이 뷰컨의 프로퍼티들은 nil 상태임. 그래서 싱크를 같게 맞춰줌.
            self.notiCenter.post(name: NSNotification.Name(rawValue: "requestFetch"), object: nil)
            print("Finish reload")
        }
    }
    
    func sync() {
        self.memoTitle = viewModel.memo?.title ?? "제목 없음"
        self.memoContents = viewModel.memo?.contents ?? "내용 없음"
        self.images = viewModel.memo?.images ?? [UIImage(named: "memeIcon")!]
    }
    
    // MARK:- Noti Center Observers Methods
    
    fileprivate func receivePost() {
        notiCenter.addObserver(self,
                               selector: #selector(actionChoice),
                               name: NSNotification.Name(rawValue: "addPhotos"),
                               object: nil)
        notiCenter.addObserver(self,
                               selector: #selector(actionDelete),
                               name: NSNotification.Name(rawValue: "deletePhotos"),
                               object: nil)
    }
    
    @objc func actionChoice() {
        let alert = UIAlertController(title: nil,
                                      message: "어디서 사진을 가져올까요?",
                                      preferredStyle: .actionSheet)
        let actionPhotoLibrary = UIAlertAction(title: "포토 라이브러리",
                                               style: .default,
                                               handler: actionPhotoLibrary(alert:))
        let actionCamera = UIAlertAction(title: "카메라로 촬영",
                                         style: .default,
                                         handler: actionCamera(alert:))
        let actionURL = UIAlertAction(title: "외부 URL로 가져오기",
                                      style: .default,
                                      handler: actionURL(alert:))
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        
        alert.addAction(actionPhotoLibrary)
        alert.addAction(actionCamera)
        alert.addAction(actionURL)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func actionDelete(_ notification: NSNotification) {
        // 1. 삭제할 이미지 번호 수신
        guard let number = notification.userInfo?["number"] as? Int else { return }
        // 2. 이미지 배열에서 해당 번호의 이미지 삭제
        self.images.remove(at: number)
        // 3. 이미지 배열을 담당하는 테이블 뷰 첫 번째 Idx 지정
        let indexPath = NSIndexPath(row: 0, section: 0)
        // 4. idx 를 통한 부분 reload
        self.tableView.reloadRows(at: [(indexPath as IndexPath)],
                                  with: .none)
        // 5. Reload 가 완료되었음을 알림
        notiCenter.post(name: NSNotification.Name("requestDelete"),
                        object: nil)
    }
    
}

// MARK:- Alert Methods

extension MemoModifyController {
    
    fileprivate func actionPhotoLibrary(alert: UIAlertAction!) {
        present(libraryPicker, animated: true, completion: nil)
        
        libraryPicker.didFinishPicking { [unowned libraryPicker] items, cancelled in
            
            for item in items {
                switch item {
                case .photo(let photo):
                    self.images.append(photo.image)
                case .video(let video):
                    print(video)
                }
            }
            
            self.tableView.reloadData()
            self.notiCenter.post(name: NSNotification.Name("requestReload"),
                                 object: nil)
            libraryPicker.dismiss(animated: true, completion: nil)
        }
        
        
    }
    
    fileprivate func actionCamera(alert: UIAlertAction!) {
        var config = YPImagePickerConfiguration()
        config.screens = [.photo]
        let picker = YPImagePicker(configuration: config)
        
        present(picker, animated: true, completion: nil)
        
        picker.didFinishPicking { [unowned picker] items, _ in
            if let photo = items.singlePhoto {
                self.images.append(photo.image)
            }
            
            self.tableView.reloadData()
            self.notiCenter.post(name: NSNotification.Name("requestReload"),
                                 object: nil)
            
            picker.dismiss(animated: true)
        }
        
    }
    
    fileprivate func actionURL(alert: UIAlertAction!) {
        let alert = UIAlertController(title: "외부 URL로 가져오기", message: "아래에 주소를 넣어주세요", preferredStyle: .alert)
        alert.addTextField { $0.placeholder = "URL" }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default) { (_) in
                                        
                                        if let string = alert.textFields?[0].text {
                                            if !string.isEmpty {
                                                self.handleSuccess(string: string)
                                            } else {
                                                self.handleStringError()
                                            }
                                        }
        })
        
        present(alert, animated: true)
        
    }
    
    fileprivate func handleStringError() {
        let alert = UIAlertController(title: nil, message: "빈 값이 입력되었습니다", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    fileprivate func handleUrlError() {
        let alert = UIAlertController(title: nil, message: "유효하지 않은 주소가 입력되었습니다", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    fileprivate func handleSuccess(string: String) {
        guard let url = URL(string: string) else { return }
        let resource = ImageResource(downloadURL: url)
        
        KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: nil) { (result) in
            switch result {
            case .success(let value):
                self.images.append(value.image)
                self.tableView.reloadData()
                self.notiCenter.post(name: NSNotification.Name("requestReload"),
                                     object: nil)
            case .failure(let error):
                print(error.localizedDescription)
                self.handleUrlError()
            }
        }
    }
    
}

// MARK:- Table View Data Source

extension MemoModifyController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let memo = viewModel.memo else { return UITableViewCell() }
        
        switch MemoModifyControllerViewModel.CellType(rawValue: indexPath.row) {
        case .photo:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MemoModifyPhotoCell.self),
                                                     for: indexPath) as! MemoModifyPhotoCell
            let images = self.images
            cell.viewModel = MemoAddPhotoCellViewModel(images: images)
            return cell
        case .title:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MemoModifyTitleCell.self),
                                                     for: indexPath) as! MemoModifyTitleCell
            cell.delegate = self
            cell.viewModel = MemoModifyTitleCellViewModel(contents: memo)
            return cell
        case .content:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MemoModifyContentCell.self),
                                                     for: indexPath) as! MemoModifyContentCell
            cell.delegate = self
            cell.viewModel = MemoModifyContentCellViewModel(contents: memo)
            return cell
        default :
            return UITableViewCell()
        }
    }
    
}

// MARK:- Table View Delegate

extension MemoModifyController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0, 1:
            return 72
        default:
            return 500
        }
    }
    
}

// MARK:- TextField & TextView Delegate
// MemoAddController want receive text values from tableView.

extension MemoModifyController: MemoModifyTitleCellDelegate, MemoModifyContentCellDelegate {
    
    func sendDataFromTF(text: String) {
        self.memoTitle = text
    }
    
    func sendDataFromTV(text: String) {
        self.memoContents = text
    }
    
}
