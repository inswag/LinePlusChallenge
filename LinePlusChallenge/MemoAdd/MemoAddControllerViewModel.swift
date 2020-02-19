//
//  MemoAddControllerViewModel.swift
//  LinePlusChallenge
//
//  Created by Insu Park on 2020/02/19.
//  Copyright © 2020 INSWAG. All rights reserved.
//

import UIKit

class MemoAddControllerViewModel {
    
    // MARK:- Properties
    
    lazy var memoDAO = MemoDAO()
    
    var memoList: [MemoData] = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.memolist
    }()
    
    // MARK:- Core Data Methods
    
    func insertMemo(title: String, contents: String) {
        let data = MemoData()
        data.title = title
        data.contents = contents
        data.regdate = Date()
        self.memoDAO.insert(data)
    }
        
    func numberOfRowsInSection() -> Int {
        return 3
    }
    
}
