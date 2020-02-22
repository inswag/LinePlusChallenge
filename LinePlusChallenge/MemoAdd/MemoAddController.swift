//
//  MemoAddController.swift
//  LinePlusChallenge
//
//  Created by Insu Park on 2020/02/14.
//  Copyright © 2020 INSWAG. All rights reserved.
//

import CoreData
import Foundation
import UIKit
import YPImagePicker // Multiple Section for photos

class MemoAddController: ViewController {
    
    // MARK:- Properties
    
    let navigator: Navigator
    let viewModel: MemoAddControllerViewModel
    
    let notiCenter = NotificationCenter.default
    
    var memoTitle: String = ""
    var memoContents: String = ""
    
    // MARK:- UI Properties
    
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: UIScreen.main.bounds,
                             style: UITableView.Style.plain)
        tv.allowsSelection = false
        tv.backgroundColor = .white
        tv.separatorStyle = .none
        tv.dataSource = self
        tv.delegate = self
        tv.register(MemoAddPhotoCell.self,
                    forCellReuseIdentifier: String(describing: MemoAddPhotoCell.self))
        tv.register(MemoAddTitleCell.self,
                    forCellReuseIdentifier: String(describing: MemoAddTitleCell.self))
        tv.register(MemoAddContentCell.self,
                    forCellReuseIdentifier: String(describing: MemoAddContentCell.self))
        return tv
    }()
    
    let memoTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Writing.."
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
        
        viewModel.insertMemo(title: self.memoTitle,
                             contents: self.memoContents)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK:- Initialize
    
    init(navigator: Navigator, viewModel: MemoAddControllerViewModel) {
        self.navigator = navigator
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        receivePost()
        // Do any additional setup after loading the view.
        
    }
    
    // MARK:- Methods
    
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
    
    override func setupImplementation() {
//        imagePicker.delegate = self
    }
    
    // MARK: Notification Methods
    
    fileprivate func receivePost() {
        notiCenter.addObserver(self,
                               selector: #selector(actionChoice),
                               name: NSNotification.Name(rawValue: "addPhotos"),
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
    

    
    // MARK:- Deinitialize
    
    deinit {
        notiCenter.removeObserver(self, name: NSNotification.Name("addPhotos"), object: nil)
    }
    
    
}

// MARK:- Methods : Alert Handler Methods

extension MemoAddController {
    
    fileprivate func actionPhotoLibrary(alert: UIAlertAction!) {
        var config = YPImagePickerConfiguration()
        config.library.maxNumberOfItems = 5
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
        let picker = YPImagePicker(configuration: config)
        
        picker.didFinishPicking { [unowned picker] items, cancelled in
            for item in items {
                switch item {
                case .photo(let photo):
                    print(photo)
                case .video(let video):
                    print(video)
                }
            }
            picker.dismiss(animated: true, completion: nil)
        }
        
        present(picker, animated: true, completion: nil)
        
    }
    
    fileprivate func actionCamera(alert: UIAlertAction!) {
        let picker = YPImagePicker()
        picker.didFinishPicking { [unowned picker] items, _ in
            if let photo = items.singlePhoto {
                print(photo.fromCamera) // Image source (camera or library)
                print(photo.image) // Final image selected by the user
                print(photo.originalImage) // original image selected by the user, unfiltered
            }
            picker.dismiss(animated: true, completion: nil)
        }
        present(picker, animated: true, completion: nil)
    }
    
    fileprivate func actionURL(alert: UIAlertAction!) {
        print("actionURL")
    }
    
}

// MARK:- Table View Data Source

extension MemoAddController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch MemoAddControllerViewModel.CellType(rawValue: indexPath.row) {
        case .photo:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MemoAddPhotoCell.self),
                                                     for: indexPath) as! MemoAddPhotoCell
            return cell
        case .title:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MemoAddTitleCell.self),
                                                     for: indexPath) as! MemoAddTitleCell
            cell.delegate = self
            return cell
        case .content:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MemoAddContentCell.self),
                                                     for: indexPath) as! MemoAddContentCell
            cell.delegate = self
            return cell
        default :
            return UITableViewCell()
        }
    }
    
}

// MARK:- Table View Delegate

extension MemoAddController: UITableViewDelegate {
    
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

extension MemoAddController: TextFieldDelegate, TextViewDelegate {
    
    func sendDataFromTF(text: String) {
        self.memoTitle = text
    }
    
    func sendDataFromTV(text: String) {
        self.memoContents = text
    }
    
}

