//
//  PhotoNestedImageCell.swift
//  LinePlusChallenge
//
//  Created by Insu Park on 2020/02/16.
//  Copyright © 2020 INSWAG. All rights reserved.
//

import UIKit

class PhotoNestedImageCell: CollectionViewCell {
    
    // MARK:- Properties
    
    let notiCenter = NotificationCenter.default
    var viewModel: PhotoNestedImageCellViewModel! {
        didSet {
            photoImageView.image = viewModel.image
        }
    }
    
    // MARK:- UI Properties

    let photoImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .lightGray
        iv.layer.cornerRadius = 3
        iv.clipsToBounds = true
        return iv
    }()
    
    lazy var typeButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "photo_delete_icon")?.withRenderingMode(.alwaysOriginal),
                     for: .normal)
        btn.backgroundColor = .white
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.black.cgColor
        btn.layer.cornerRadius = 8
        btn.clipsToBounds = true
        btn.addTarget(self, action: #selector(actionDeletePhoto), for: .touchUpInside)
        return btn
    }()
    
    @objc func actionDeletePhoto() {
        let number: [String: Int] = ["number": viewModel.indexPath]
        notiCenter.post(name: NSNotification.Name(rawValue: "deletePhotos"),
                        object: nil,
                        userInfo: number)
    }
    
    // MARK:- Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- UI Methods
    
    override func setupUIComponents() {
        [photoImageView].forEach {
            self.addSubview($0)
        }
        
        [typeButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setupUILayout() {
        photoImageView.snp.makeConstraints {
            $0.width.height.equalTo(48)
            $0.leading.bottom.equalToSuperview()
        }
        
        typeButton.snp.makeConstraints {
            $0.width.height.equalTo(16)
            $0.top.trailing.equalToSuperview()
        }
    }
    
}
