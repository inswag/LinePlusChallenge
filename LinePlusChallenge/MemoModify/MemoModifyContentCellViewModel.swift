//
//  MemoModifyContentCellViewModel.swift
//  LinePlusChallenge
//
//  Created by Insu Park on 2020/02/23.
//  Copyright © 2020 INSWAG. All rights reserved.
//

import UIKit

class MemoModifyContentCellViewModel {
    
    // MARK:- Properties
    
    let contents: String?
    
    // MARK:- Initializer

    init(contents: MemoData) {
        self.contents = contents.contents
    }
    
}
