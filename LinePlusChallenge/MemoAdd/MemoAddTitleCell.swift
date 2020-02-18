//
//  MemoAddTitleCell.swift
//  LinePlusChallenge
//
//  Created by Insu Park on 2020/02/14.
//  Copyright © 2020 INSWAG. All rights reserved.
//

import UIKit

protocol TextFieldDelegate: class {
    func sendDataFromTF(text: String)
}

class MemoAddTitleCell: TableViewCell {
    
    // MARK:- Properties
    
    weak var delegate: TextFieldDelegate?
    
    // MARK:- UI Properties
    
    lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "제목"
        textField.text = "Title OK"
        textField.textColor = .black
        textField.backgroundColor = UIColor.white
        textField.borderStyle = .none
//        textField.font = Tools.font.systemFont(size: 14)
        textField.addTarget(self,
                            action: #selector(actionInput),
                            for: .editingChanged)
        return textField
    }()
    
    @objc func actionInput() {
        delegate?.sendDataFromTF(text: titleTextField.text!)
    }
    
    let borderView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        return view
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
    
    // MARK:- Methods
    
    internal override func setupUIComponents() {
        [titleTextField, borderView].forEach {
            self.addSubview($0)
        }
    }
    
    internal override func setupUILayout() {
        titleTextField.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(8)
            $0.trailing.equalToSuperview().offset(-8)
            $0.bottom.equalTo(borderView.snp.top).offset(-15)
        }
        
        borderView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(8)
            $0.trailing.equalToSuperview().offset(-8)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
}
