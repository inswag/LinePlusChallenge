//
//  ImageNestedCell.swift
//  LinePlusChallenge
//
//  Created by Insu Park on 2020/02/19.
//  Copyright © 2020 INSWAG. All rights reserved.
//

import UIKit



class PhotoNestedCell: CollectionViewCell {
    
    var viewModel: PhotoNestedCellViewModel! {
        didSet {
            imageView.image = viewModel.photo
        }
    }
    
    let imageView: UIImageView = {
       let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.backgroundColor = .white
        return imgView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUIComponents()
    }
    
    func configure(content: String) {
//        let urlString = URL(string: content)
//        self.imageView.kf.setImage(with: urlString)
//        self.scrollView.contentSize
    }
    
    override func setupUIComponents() {
        self.contentView.addSubview(imageView)
        self.imageView.snp.makeConstraints { (m) in
            m.top.equalToSuperview()
            m.leading.equalToSuperview()
            m.trailing.equalToSuperview()
            m.bottom.equalToSuperview()
//            m.top.equalTo(self.scrollView.snp.top)
//            m.leading.equalTo(self.scrollView.snp.leading)
//            m.trailing.equalTo(self.scrollView.snp.trailing)
//            m.bottom.equalTo(self.scrollView.snp.bottom)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
