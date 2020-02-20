//
//  MemoAddController.swift
//  LinePlusChallenge
//
//  Created by Insu Park on 2020/02/14.
//  Copyright © 2020 INSWAG. All rights reserved.
//

import CoreData
import UIKit


class MemoAddController: ViewController {
    
    // MARK:- Properties
    
    let navigator: Navigator
    let viewModel: MemoAddControllerViewModel
    
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
        
//        self.navigationController?.popViewController(animated: true)
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

