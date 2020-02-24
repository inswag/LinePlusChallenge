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
    
    var viewModel: MemoDetailPhotoCellViewModel! {
        didSet {
            progressView.setProgress(Float(0.0 / collectionView.frame.width) + 1 / Float(viewModel.images.count), animated: false)
        }
    }
    
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
    
    lazy var progressView: UIProgressView = {
        let pgView = UIProgressView()
        pgView.progressTintColor = UIColor.white
        pgView.trackTintColor = UIColor.black
        return pgView
    }()
    
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
        
        [collectionView, progressView].forEach {
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
        
        self.progressView.snp.makeConstraints { (m) in
            m.leading.equalToSuperview().offset(24)
            m.trailing.equalToSuperview().offset(-24)
            m.bottom.equalToSuperview().offset(-24)
            m.height.equalTo(4)
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        progressView.progress = Float((scrollView.contentOffset.x / collectionView.frame.width) + 1) / Float(viewModel.images.count)
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
