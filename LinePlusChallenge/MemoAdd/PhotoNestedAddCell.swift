//
//  PhotoNestedAddCell.swift
//  LinePlusChallenge
//
//  Created by Insu Park on 2020/02/16.
//  Copyright © 2020 INSWAG. All rights reserved.
//

import UIKit

class PhotoNestedAddCell: CollectionViewCell {
    
    // MARK:- UI Properties

    lazy var typeButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Add", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.cornerRadius = 3
        btn.clipsToBounds = true
        btn.addTarget(self, action: #selector(actionAddPhotos), for: .touchUpInside)
        return btn
    }()
    
    @objc func actionAddPhotos() {
        print("ok")
    }
    
    // MARK:- Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupUIComponents() {
        [typeButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setupUILayout() {
        typeButton.snp.makeConstraints {
            $0.width.height.equalTo(48)
            $0.leading.bottom.equalToSuperview()
        }
    }
    
}
