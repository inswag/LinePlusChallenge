//
//  MemoAddContentCell.swift
//  LinePlusChallenge
//
//  Created by Insu Park on 2020/02/15.
//  Copyright © 2020 INSWAG. All rights reserved.
//

import UIKit

class MemoAddContentCell: TableViewCell {

    // MARK:- UI Properties
    
    let contentTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .white
        textView.text = "내용"
        return textView
    }()
    
    // MARK:- Initialize
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: String(describing: MemoAddController.self))
        self.backgroundColor = .gray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Methods
    
    internal override func setupUIComponents() {
        [contentTextView].forEach {
            self.addSubview($0)
        }
    }
    
    internal override func setupUILayout() {
        contentTextView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(8)
            $0.trailing.equalToSuperview().offset(-8)
            $0.bottom.equalToSuperview().offset(-8)
            
        }
    }
    
}
