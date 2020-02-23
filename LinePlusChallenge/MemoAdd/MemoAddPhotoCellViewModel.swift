//
//  MemoAddPhotoCellViewModel.swift
//  LinePlusChallenge
//
//  Created by Insu Park on 2020/02/21.
//  Copyright © 2020 INSWAG. All rights reserved.
//

import UIKit

class MemoAddPhotoCellViewModel {
    
    // MARK:- Properties
    
    let images: [UIImage]
    
    // MARK:- Collection View Cell Type
    
    enum CellType {
        case add
        case photos
    }
    
    // MARK:- Initialize
    
    init(images: [UIImage]) {
        self.images = images
    }
    
    // MARK:- Methods
    
    func numberOfItemsInSection() -> Int {
        return images.count + 1
    }
    
}
