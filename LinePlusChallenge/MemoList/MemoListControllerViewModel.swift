//
//  MemoListControllerViewModel.swift
//  LinePlusChallenge
//
//  Created by Insu Park on 2020/02/18.
//  Copyright © 2020 INSWAG. All rights reserved.
//

import CoreData
import UIKit

class MemoListControllerViewModel {
    
    // MARK:- Properties
    
    lazy var memoDAO = MemoDAO()
    
    var memoList: [MemoData] = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.memolist
    }()
    
    // MARK:- Core Data Methods
    
    func fetchMemoList(completion: @escaping () -> ()) {
        self.memoList = memoDAO.fetch()
        completion()
    }
    
    func delete(indexPath: IndexPath, completion: @escaping () -> ()) {
        let data = self.memoList[indexPath.row]
        if memoDAO.delete(data.objectID!) {
            memoList.remove(at: indexPath.row)
            completion()
        }
    }
    
}
