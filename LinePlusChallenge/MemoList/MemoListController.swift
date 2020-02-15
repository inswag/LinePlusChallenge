//
//  MemoListController.swift
//  LinePlusChallenge
//
//  Created by Insu Park on 2020/02/13.
//  Copyright © 2020 INSWAG. All rights reserved.
//

import UIKit

class MemoListController: ViewController {
    
    // MARK:- Properties
    
    let navigator: Navigator
    
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
    
    init(navigator: Navigator) {
        self.navigator = navigator
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
        return 10
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MemoListCell.self),
                                                 for: indexPath)
        cell.backgroundColor = .red
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
        self.navigationController?.pushViewController(navigator.get(segue: .memoDetail), animated: true)
    }
    
}



