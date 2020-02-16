//
//  MemoAddPhotoCell.swift
//  LinePlusChallenge
//
//  Created by Insu Park on 2020/02/14.
//  Copyright © 2020 INSWAG. All rights reserved.
//

import UIKit

// Cell Height : 72
class MemoAddPhotoCell: TableViewCell {

    // MARK: - UI Properties
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = .yellow
        cv.setCollectionViewLayout(layout, animated: true)
        cv.dataSource = self
        cv.delegate = self
        cv.register(MemoAddNestedPhotoCell.self, forCellWithReuseIdentifier: String(describing: MemoAddNestedPhotoCell.self))
        return cv
    }()
    
    let borderView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    // MARK:- Initialize
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: String(describing: MemoAddController.self))
        self.backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Methods
    
    internal override func setupUIComponents() {
        [collectionView, borderView].forEach {
            self.addSubview($0)
        }
    }
    
    internal override func setupUILayout() {
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(8)
            $0.trailing.equalToSuperview()
            $0.bottom.equalTo(borderView.snp.top).offset(-7)
        }
        
        borderView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(8)
            $0.trailing.equalToSuperview().offset(-8)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1)
            
            
        }
    }
    
}

// MARK:- Collection View Data Source

extension MemoAddPhotoCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 5
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MemoAddNestedPhotoCell.self), for: indexPath) as? MemoAddNestedPhotoCell ?? UICollectionViewCell()
        return cell
    }
    
    
}

// MARK:- Collection View Delegate Flow Layout

extension MemoAddPhotoCell: UICollectionViewDelegateFlowLayout {
    
}
