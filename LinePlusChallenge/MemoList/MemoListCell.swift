//
//  MemoListCell.swift
//  LinePlusChallenge
//
//  Created by Insu Park on 2020/02/14.
//  Copyright © 2020 INSWAG. All rights reserved.
//

import UIKit

class MemoListCell: TableViewCell {
    
    // MARK:- Constant
    
    
    
    // MARK:- UI Properties
    
    let photoImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .lightGray
        iv.layer.cornerRadius = 3
        iv.clipsToBounds = true
        return iv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        return label
    }()
    
    let contentLabel: UILabel = {
        let label = UILabel()
        label.text = "Content\nContent"
        label.numberOfLines = 2
        return label
    }()
    
    let borderView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    //    let stackView = UIStackView(arrangedSubviews: [self.titleLabel, self.contentLabel])
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.titleLabel,
                                                       self.contentLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 8
        return stackView
    }()
    
    // MARK:- Initialize
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: String(describing: MemoListViewController.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Methods
    
    internal override func setupUIComponents() {
        
        [photoImageView, stackView, borderView].forEach {
            self.contentView.addSubview($0)
        }
    }
    
    internal override func setupUILayout() {
        
        photoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.width.equalTo(90)
            $0.height.equalTo(90)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(photoImageView.snp.top).offset(8)
            $0.leading.equalTo(photoImageView.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalTo(photoImageView.snp.bottom).offset(-8)
        }
        
        borderView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(2)
        }
        
    }
    
}

