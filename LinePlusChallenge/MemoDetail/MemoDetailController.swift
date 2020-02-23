//
//  MemoDetailController.swift
//  LinePlusChallenge
//
//  Created by Insu Park on 2020/02/15.
//  Copyright © 2020 INSWAG. All rights reserved.
//

import UIKit

class MemoDetailController: ViewController {
    
    // MARK:- Properties
    
    let navigator: Navigator
    let viewModel: MemoDetailControllerViewModel
        
    // MARK:- UI Properties
    
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: UIScreen.main.bounds,
                             style: UITableView.Style.plain)
        tv.allowsSelection = false
        tv.backgroundColor = .white
        tv.separatorStyle = .none
        tv.dataSource = self
        tv.delegate = self
        tv.register(MemoDetailPhotoCell.self,
                    forCellReuseIdentifier: String(describing: MemoDetailPhotoCell.self))
        tv.register(MemoDetailTitleCell.self,
                    forCellReuseIdentifier: String(describing: MemoDetailTitleCell.self))
        tv.register(MemoDetailContentCell.self,
                    forCellReuseIdentifier: String(describing: MemoDetailContentCell.self))
        return tv
    }()
    
    let memoTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Detail"
        label.textAlignment = .center
        label.textColor = UIColor.black
        return label
    }()
    
    lazy var editButton = UIBarButtonItem(title: "Edit",
                                              style: .plain,
                                              target: self,
                                              action: #selector(actionEdit))
    
    lazy var cutButton = UIBarButtonItem(title: "Cut",
                                              style: .plain,
                                              target: self,
                                              action: #selector(actionCut))
    
    @objc func actionEdit() {
        let memoModifyVC = navigator.get(segue: .memoModify(indexPath: viewModel.indexPath))
        self.navigationController?.pushViewController(memoModifyVC, animated: true)
    }
    
    @objc func actionCut() {
        let alert = UIAlertController(title: nil,
                                      message: "메모를 삭제합니다",
                                      preferredStyle: .actionSheet)
        let cutAction = UIAlertAction(title: "삭제",
                                      style: .default,
                                      handler: actionDelete(alert:))
        let cancelAction = UIAlertAction(title: "취소",
                                         style: .default,
                                         handler: nil)
        
        alert.addAction(cutAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    fileprivate func actionDelete(alert: UIAlertAction!) {
        viewModel.delete()
        self.navigationController?.popViewController(animated: true)
        print("Delete")
    }
    
    // MARK:- Initialize
    
    init(navigator: Navigator, viewModel: MemoDetailControllerViewModel) {
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
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel.fetchSingle() {
            self.tableView.reloadData()
        }
    }
    
    
    // MARK:- Methods
    
    override func setupUIComponents() {
        self.navigationItem.rightBarButtonItems = [editButton, cutButton]
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

// MARK:- TableView Data Source

extension MemoDetailController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let memo = viewModel.memo else { return UITableViewCell() }
        
        switch MemoDetailControllerViewModel.CellType(rawValue: indexPath.row) {
        case .photo:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MemoDetailPhotoCell.self), for: indexPath) as! MemoDetailPhotoCell
            cell.backgroundColor = .orange
            cell.viewModel = MemoDetailPhotoCellViewModel(images: memo.images!)
            return cell
        case .title:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MemoDetailTitleCell.self), for: indexPath) as! MemoDetailTitleCell
            cell.viewModel = MemoDetailTitleCellViewModel(contents: memo)
            return cell
        case .content:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MemoDetailContentCell.self), for: indexPath) as! MemoDetailContentCell
            cell.viewModel = MemoDetailContentCellViewModel(contents: memo)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    
}

// MARK:- Table View Delegate

extension MemoDetailController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            let height: CGFloat = self.view.frame.width
            return height
        case 1:
            return UITableView.automaticDimension
        default:
            return 300
        }
    }
}
