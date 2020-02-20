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
    
    struct UI {
        static let imageRadius: CGFloat = 14
        static let imageTopMargin: CGFloat = 16                 // +
        static let imageLeadingMargin: CGFloat = 16
        static let imageWidthHeight: CGFloat = 90               // +

        static let stackViewSpacing: CGFloat = 8
        static let stackViewTopMargin: CGFloat = 8
        static let stackViewLeadingMargin: CGFloat = 16
        static let stackViewTrailingMargin: CGFloat = -16
        static let stackViewBottomMargin: CGFloat = -8          // +
        
        static let borderViewLeadingMargin: CGFloat = 16
        static let borderViewTrailingMargin: CGFloat = -16
        static let borderviewHeight: CGFloat = 2                // +
    }
    
    // MARK:- Properties
    
    var viewModel: MemoListCellViewModel! {
      didSet {
        titleLabel.text = viewModel.title
        contentsLabel.text = viewModel.contents
      }
    }
    
    
    // MARK:- UI Properties
    
    let photoImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .lightGray
        iv.layer.cornerRadius = UI.imageRadius
        iv.clipsToBounds = true
        return iv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.textColor = .black
        return label
    }()
    
    let contentsLabel: UILabel = {
        let label = UILabel()
        label.text = "Content\nContent"
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.titleLabel,
                                                       self.contentsLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = UI.stackViewSpacing
        return stackView
    }()
    
    let borderView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    // MARK:- Initialize
    
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: .default,
                   reuseIdentifier: String(describing: MemoListController.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Methods
    
    override func setupUIComponents() {
        [photoImageView, stackView, borderView].forEach {
            self.contentView.addSubview($0)
        }
    }
    
    override func setupUILayout() {
        photoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(UI.imageTopMargin)
            $0.leading.equalToSuperview().offset(UI.imageLeadingMargin)
            $0.width.equalTo(UI.imageWidthHeight)
            $0.height.equalTo(UI.imageWidthHeight)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(photoImageView.snp.top).offset(UI.stackViewTopMargin)
            $0.leading.equalTo(photoImageView.snp.trailing).offset(UI.stackViewLeadingMargin)
            $0.trailing.equalToSuperview().offset(UI.stackViewTrailingMargin)
            $0.bottom.equalTo(photoImageView.snp.bottom).offset(UI.stackViewBottomMargin)
        }
        

        borderView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(UI.borderViewLeadingMargin)
            $0.trailing.equalToSuperview().offset(UI.borderViewTrailingMargin)
            $0.height.equalTo(UI.borderviewHeight)
        }
        
    }
    
}

