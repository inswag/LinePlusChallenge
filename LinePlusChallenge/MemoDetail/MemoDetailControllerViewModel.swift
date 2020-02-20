//
//  MemoDetailControllerViewModel.swift
//  LinePlusChallenge
//
//  Created by Insu Park on 2020/02/19.
//  Copyright © 2020 INSWAG. All rights reserved.
//

import UIKit

class MemoDetailControllerViewModel {
    
    // MARK:- Properties
    
    lazy var memoDAO = MemoDAO()    // Provider
    var memo: MemoData?             // Container
    
    let indexPath: IndexPath

    // MARK:- Initialize
    
    init(indexPath: IndexPath) {
        self.indexPath = indexPath
    }
    
    // MARK:- Methods
    
    func fetchSingle(completion: @escaping () -> ()) {
        self.memo = memoDAO.fetchSingle(indexPath: self.indexPath)
        completion()
    }
    
    func numberOfRowsInSection() -> Int {
        return 3
    }
    
}
