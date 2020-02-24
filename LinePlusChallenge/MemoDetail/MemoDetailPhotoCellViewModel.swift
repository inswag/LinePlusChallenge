//
//  MemoDetailPhotoCellViewModel.swift
//  LinePlusChallenge
//
//  Created by Insu Park on 2020/02/22.
//  Copyright © 2020 INSWAG. All rights reserved.
//

import UIKit

class MemoDetailPhotoCellViewModel {

    // MARK:- Properties
    
    var images: [UIImage]
    
    // MARK:- Initialize
    
    init(images: [UIImage]) {
        self.images = images
    }
    
    // MARK:- Collection View Data Source Methods
 
    func numberOfItemsInSection() -> Int {
        return images.count
    }
}
