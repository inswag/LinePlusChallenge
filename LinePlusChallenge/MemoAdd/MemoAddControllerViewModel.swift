//
//  MemoAddControllerViewModel.swift
//  LinePlusChallenge
//
//  Created by Insu Park on 2020/02/19.
//  Copyright © 2020 INSWAG. All rights reserved.
//

import UIKit

class MemoAddControllerViewModel {
    
    // MARK:- Cell Type
    
    enum CellType: Int {
        case photo
        case title
        case content
        case totalCount
    }
    
    // MARK:- Properties
    
    lazy var memoDAO = MemoDAO()
    
    // MARK:- Table View Data Source
    
    func numberOfRowsInSection() -> Int {
        return CellType.totalCount.rawValue
    }
    
    // MARK:- Core Data Methods
    
    func insertMemo(title: String, contents: String, images: [UIImage]) {
        let data = MemoData()
        data.title = title
        data.contents = contents
        data.regdate = Date()
        data.images = images
        self.memoDAO.insert(data)
    }
    
}
