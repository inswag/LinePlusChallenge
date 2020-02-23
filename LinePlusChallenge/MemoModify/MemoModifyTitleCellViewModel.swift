//
//  MemoModifyTitleCellViewModel.swift
//  LinePlusChallenge
//
//  Created by Insu Park on 2020/02/23.
//  Copyright © 2020 INSWAG. All rights reserved.
//

import UIKit

class MemoModifyTitleCellViewModel {
    
    // MARK:- Properties
   
    let title: String?
    
     // MARK:- Initializer
    
    init(contents: MemoData) {
        self.title = contents.title
    }
    
}


