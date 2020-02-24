//
//  MemoDetailPhotoCell.swift
//  LinePlusChallenge
//
//  Created by Insu Park on 2020/02/19.
//  Copyright © 2020 INSWAG. All rights reserved.
//

import UIKit
import SnapKit

class MemoDetailPhotoCell: TableViewCell {

    // MARK:- Properties
    
    var viewModel: MemoDetailPhotoCellViewModel!
    
    // MARK:- UI Properties
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.setCollectionViewLayout(layout, animated: true)
        cv.dataSource = self
        cv.delegate = self
        cv.register(DetailPhotoNestedCell.self,
                    forCellWithReuseIdentifier: String(describing: DetailPhotoNestedCell.self))
        return cv
    }()
    
    lazy var noticeButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "swipe_icon"), for: .normal)
        btn.backgroundColor = .white
        btn.contentMode = .scaleAspectFit
        btn.layer.cornerRadius = 25
        btn.addTarget(self, action: #selector(actionHidden), for: .touchUpInside)
        return btn
    }()
    
    @objc func actionHidden() {
        self.noticeButton.isHidden = true
    }
    
    // MARK:- Initialize
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: String(describing: MemoDetailController.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- UI Methods
    
    override func setupUIComponents() {
        backgroundColor = .white
        selectionStyle = .none
        clipsToBounds = true
        
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        
        [collectionView, noticeButton].forEach {
            self.addSubview($0)
        }
        
    }
    
    override func setupUILayout() {
        self.collectionView.snp.makeConstraints { (m) in
            m.top.equalToSuperview()
            m.leading.equalToSuperview()
            m.trailing.equalToSuperview()
            m.bottom.equalToSuperview()
        }
        
        self.noticeButton.snp.makeConstraints { (m) in
            m.centerX.equalToSuperview()
            m.bottom.equalToSuperview().offset(-8)
            m.width.equalTo(50)
            m.height.equalTo(50)
        }
    }

}

// MARK:- Collection View Data Source

extension MemoDetailPhotoCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: DetailPhotoNestedCell.self),
                                                            for: indexPath) as? DetailPhotoNestedCell else { return UICollectionViewCell() }
        cell.viewModel = DetailPhotoNestedCellViewModel(images: viewModel.images[indexPath.item])
        return cell
    }
    
}

// MARK:- Collection View Delegate Flow Layout

extension MemoDetailPhotoCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.contentView.frame.width
        return CGSize(width: width, height: width)
    }
}
