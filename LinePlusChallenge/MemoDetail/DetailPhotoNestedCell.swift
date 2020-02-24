//
//  DetailPhotoNestedCell.swift
//  LinePlusChallenge
//
//  Created by Insu Park on 2020/02/19.
//  Copyright © 2020 INSWAG. All rights reserved.
//

import UIKit

class DetailPhotoNestedCell: CollectionViewCell {
    
    var viewModel: DetailPhotoNestedCellViewModel! {
        didSet {
            imageView.image = viewModel.photo
        }
    }
    
    let imageView: UIImageView = {
       let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.image = UIImage(named: "memoIcon")
        imgView.clipsToBounds = true
        imgView.backgroundColor = .white
        return imgView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUIComponents()
    }
    
    override func setupUIComponents() {
        self.contentView.addSubview(imageView)
        self.imageView.snp.makeConstraints { (m) in
            m.top.equalToSuperview()
            m.leading.equalToSuperview()
            m.trailing.equalToSuperview()
            m.bottom.equalToSuperview()
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
