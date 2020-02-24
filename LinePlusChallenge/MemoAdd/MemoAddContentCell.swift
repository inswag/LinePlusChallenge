//
//  MemoAddContentCell.swift
//  LinePlusChallenge
//
//  Created by Insu Park on 2020/02/15.
//  Copyright © 2020 INSWAG. All rights reserved.
//

import UIKit

protocol MemoAddContentCellDelegate: class {
    func sendDataFromTV(text: String)
}

class MemoAddContentCell: TableViewCell {

    // MARK:- Properties
    
    weak var delegate: MemoAddContentCellDelegate?
    
    // MARK:- UI Properties
    
    lazy var contentTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .white
        textView.text = "내용"
        textView.font = Tools.font.appleSDGothicNeoRegular(size: 16)
        textView.textColor = .black
        textView.delegate = self
        return textView
    }()
    
    // MARK:- Initialize
    
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: .default,
                   reuseIdentifier: String(describing: MemoAddController.self))
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
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(8)
            $0.trailing.equalToSuperview().offset(-8)
            $0.bottom.equalToSuperview().offset(-8)
            
        }
    }

}

extension MemoAddContentCell: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        guard let text = textView.text else { return }
        delegate?.sendDataFromTV(text: text)
    }
    
}
