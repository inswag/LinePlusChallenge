//
//  MemoListViewController.swift
//  LinePlusChallenge
//
//  Created by Insu Park on 2020/02/13.
//  Copyright © 2020 INSWAG. All rights reserved.
//

import UIKit

class MemoListViewController: ViewController {
    
    // MARK:- UI Properties
    
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: UIScreen.main.bounds,
                             style: UITableView.Style.grouped)
        tv.allowsSelection = false
        tv.backgroundColor = .white
        tv.separatorStyle = .none
        tv.dataSource = self
        tv.delegate = self
        tv.register(MemoListCell.self,
                    forCellReuseIdentifier: String(describing: MemoListCell.self))
        return tv
    }()
    
    // MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func setupUIComponents() {
        [tableView].forEach {
            self.view.addSubview($0)
        }
        
        tableView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
    }


}

// MARK:- Table View Dat aSource

extension MemoListViewController: UITableViewDataSource {
    
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

extension MemoListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 124
    }
    
}



