//
//  CollectionViewCell.swift
//  LinePlusChallenge
//
//  Created by Insu Park on 2020/02/16.
//  Copyright © 2020 INSWAG. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    // MARK:- Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUIComponents()
        setupUILayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- UI Methods

    func setupUIComponents() {
        
    }
    
    func setupUILayout() {
        
    }
    
}
