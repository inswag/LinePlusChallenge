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
    
    var app = Application.shared
    
    lazy var memoDAO = MemoDAO()
    
    // MARK:- Core Data Methods
    
    func fetchMemoList(completion: @escaping () -> ()) {
        app.memolist = memoDAO.fetch()
        completion()
    }
    
    func delete(indexPath: IndexPath, completion: @escaping () -> ()) {
        let data = app.memolist[indexPath.row]
        if memoDAO.delete(data.objectID!) {
            app.memolist.remove(at: indexPath.row)
            completion()
        }
    }
    
}
