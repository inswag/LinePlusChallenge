//
//  MemoDetailContentCell.swift
//  LinePlusChallenge
//
//  Created by Insu Park on 2020/02/19.
//  Copyright © 2020 INSWAG. All rights reserved.
//

import UIKit


class MemoDetailContentCell: TableViewCell {

    // MARK:- Properties

    var viewModel: MemoDetailContentCellViewModel! {
        didSet {
            contentTextView.text = viewModel.contents
        }
    }
    
    // MARK:- UI Properties
    
    let contentTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .white
        textView.text = "내용"
        textView.textColor = .black
        textView.isEditable = false
        return textView
    }()
    
    // MARK:- Initialize
    
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: .default,
                   reuseIdentifier: String(describing: MemoDetailController.self))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- UI Methods
    
    internal override func setupUIComponents() {
        self.backgroundColor = .white
        [contentTextView].forEach {
            self.addSubview($0)
        }
    }
    
    internal override func setupUILayout() {
        contentTextView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-16)
            
        }
    }

}
