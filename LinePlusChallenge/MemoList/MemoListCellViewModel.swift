//
//  MemoListCellViewModel.swift
//  LinePlusChallenge
//
//  Created by Insu Park on 2020/02/18.
//  Copyright © 2020 INSWAG. All rights reserved.
//

import UIKit

class MemoListCellViewModel {
    
    // MARK:- Properties
    
    let title: String?
    let contents: String?
    let image: UIImage?
    
    init(content: MemoData) {
        self.title = content.title
        self.contents = content.contents
        self.image = content.image
    }
    
}
