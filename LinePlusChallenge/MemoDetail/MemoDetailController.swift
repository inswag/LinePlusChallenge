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
    
    lazy var completeButton = UIBarButtonItem(title: "Edit",
                                              style: .plain,
                                              target: self,
                                              action: #selector(actionEdit))
    
    @objc func actionEdit() {
        self.navigationController?.pushViewController(MemoModifyController(), animated: true)
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
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel.fetchSingle() {
            self.tableView.reloadData()
        }
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

extension MemoDetailController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let memo = viewModel.memo else { return UITableViewCell() }
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MemoDetailPhotoCell.self), for: indexPath) as! MemoDetailPhotoCell
            cell.backgroundColor = .red
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MemoDetailTitleCell.self), for: indexPath) as! MemoDetailTitleCell
            cell.viewModel = MemoDetailTitleCellViewModel(contents: memo)
            
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MemoDetailContentCell.self), for: indexPath) as! MemoDetailContentCell
            cell.viewModel = MemoDetailContentCellViewModel(contents: memo)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    
}

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
