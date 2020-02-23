//
//  MemoModifyControllerViewModel.swift
//  LinePlusChallenge
//
//  Created by Insu Park on 2020/02/23.
//  Copyright © 2020 INSWAG. All rights reserved.
//

import CoreData
import UIKit


class MemoModifyControllerViewModel {
    
    // MARK:- Cell Type
    
    enum CellType: Int {
        case photo
        case title
        case content
        case totalCount
    }
    
    // MARK:- Properties
    
    lazy var memoDAO = MemoDAO()
    var memo: MemoData?             // Container
    
    let indexPath: IndexPath
    
    // MARK:- Initializer
    
    init(indexPath: IndexPath) {
        self.indexPath = indexPath
    }
    
    // MARK:- Table View Data Source
    
    func numberOfRowsInSection() -> Int {
        return CellType.totalCount.rawValue
    }
    
    // MARK:- Core Data Methods
    
    func fetchSingle(completion: @escaping () -> ()) {
        self.memo = memoDAO.fetchSingle(indexPath: self.indexPath)
        completion()
    }
    
    func insertMemo(title: String, contents: String, images: [UIImage]) {
        let data = MemoData()
        data.title = title
        data.contents = contents
        data.regdate = Date()
        data.images = images
        self.memoDAO.insert(data)
    }
        
    
    func editMemo(objectID: NSManagedObjectID, title: String, contents: String, images: [UIImage]?, completion: @escaping ()->() ) {
        if memoDAO.edit(objectID, title: title, contents: contents, images: images) {
            completion()
        }
    }

    
}
