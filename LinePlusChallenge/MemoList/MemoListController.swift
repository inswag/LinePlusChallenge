//
//  MemoListController.swift
//  LinePlusChallenge
//
//  Created by Insu Park on 2020/02/13.
//  Copyright © 2020 INSWAG. All rights reserved.
//

import CoreData
import UIKit

class MemoListController: ViewController {
    
    // MARK:- Properties
    
    let viewModel: MemoListControllerViewModel
    let navigator: Navigator
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let memoDAO = MemoDAO()
    
    
    // MARK:- UI Properties
    
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: UIScreen.main.bounds,
                             style: UITableView.Style.plain)
        tv.allowsSelection = true
        tv.backgroundColor = .white
        tv.separatorStyle = .none
        tv.dataSource = self
        tv.delegate = self
        tv.register(MemoListCell.self,
                    forCellReuseIdentifier: String(describing: MemoListCell.self))
        return tv
    }()
    
    let memoTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Memories.."
        label.textAlignment = .center
        label.textColor = UIColor.black
        return label
    }()
    
    
    lazy var newMemoButton = UIBarButtonItem(title: "New",
                                             style: .plain,
                                             target: self,
                                             action: #selector(actionNewMemo))
    
    @objc func actionNewMemo() {
        self.navigationController?.pushViewController(navigator.get(segue: .memoAdd), animated: true)
    }
    
    // MARK:- Initialize
    
    init(navigator: Navigator,
         viewModel: MemoListControllerViewModel) {
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
        viewModel.fetchMemoList {
            self.tableView.reloadData()
        }
    }
    
    
    // MARK:- Methods
    
    override func setupUIComponents() {
        self.navigationItem.rightBarButtonItem = newMemoButton
        self.navigationItem.titleView = memoTitleLabel
        
        [tableView].forEach {
            self.view.addSubview($0)
        }
        
    }
    
    override func setupUILayout() {
        tableView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    
}

// MARK:- Table View Data Source

extension MemoListController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return viewModel.memoList.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MemoListCell.self),
                                                 for: indexPath) as! MemoListCell
        cell.viewModel = MemoListCellViewModel(content: viewModel.memoList[indexPath.row])
        return cell
    }
    
}

// MARK:- Table View Delegate

extension MemoListController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 124
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(navigator.get(segue: .memoDetail),
                                                      animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.delete(indexPath: indexPath) {
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    
    
    
    
}



