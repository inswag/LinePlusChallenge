//
//  MemoDetailTitleCell.swift
//  LinePlusChallenge
//
//  Created by Insu Park on 2020/02/19.
//  Copyright © 2020 INSWAG. All rights reserved.
//

import UIKit

class MemoDetailTitleCell: TableViewCell {
    
    // MARK:- Properties
    
    weak var delegate: TextFieldDelegate?
    
    var viewModel: MemoDetailTitleCellViewModel! {
        didSet {
            titleLabel.text = viewModel.title
        }
    }
        
    // MARK:- UI Properties
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.backgroundColor = UIColor.white
        label.text = "Test"
        return label
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
                   reuseIdentifier: String(describing: MemoDetailController.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Methods
    
    internal override func setupUIComponents() {
        [titleLabel, borderView].forEach {
            self.addSubview($0)
        }
    }
    
    internal override func setupUILayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalTo(borderView.snp.top).offset(-15)
        }
        
        borderView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
}
