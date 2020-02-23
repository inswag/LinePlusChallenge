//
//  PhotoNestedImageCellViewModel.swift
//  LinePlusChallenge
//
//  Created by Insu Park on 2020/02/22.
//  Copyright © 2020 INSWAG. All rights reserved.
//

import UIKit

class PhotoNestedImageCellViewModel {
    
    // MARK:- Properties

    let image: UIImage
    
    let indexPath: Int  // for delete of cell
    
    // MARK:- Initializer
    
    init(image: UIImage, indexPath: Int) {
        self.image = image
        self.indexPath = indexPath
    }

}
