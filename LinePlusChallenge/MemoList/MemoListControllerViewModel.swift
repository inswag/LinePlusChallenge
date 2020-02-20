//
//  MemoListControllerViewModel.swift
//  LinePlusChallenge
//
//  Created by Insu Park on 2020/02/18.
//  Copyright © 2020 INSWAG. All rights reserved.
//

import CoreData
import UIKit

final class MemoListControllerViewModel {
    
    // MARK:- Cell Type
    
    enum CellType: Int {
        case memoList
    }
    
    // MARK:- Properties
    
    var memoList: [MemoData] = []
    lazy var memoDAO = MemoDAO()
    
    // MARK:- Table View Data Source
    
    func numberOfRowsInSection() -> Int {
        return memoList.count
    }
    
    // MARK:- Core Data Methods
    
    func fetchMemoList(completion: @escaping () -> ()) {
        self.memoList = memoDAO.fetch()
        completion()
    }
    
    func delete(indexPath: IndexPath, completion: @escaping () -> ()) {
        let data = self.memoList[indexPath.row]
        if memoDAO.delete(data.objectID!) {
            self.memoList.remove(at: indexPath.row)
            completion()
        }
    }
    
}
