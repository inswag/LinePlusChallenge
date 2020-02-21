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
        cv.register(PhotoNestedCell.self,
                    forCellWithReuseIdentifier: String(describing: PhotoNestedCell.self))
        return cv
    }()
    
    lazy var progressView: UIProgressView = {
        let pgView = UIProgressView()
        pgView.progressTintColor = UIColor.white
        pgView.trackTintColor = UIColor.rgb(r: 0, g: 0, b: 10, a: 0.36)
        return pgView
    }()
    
    // MARK:- Initialize
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: String(describing: MemoDetailController.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Methods
    
    override func setupUIComponents() {
        backgroundColor = .black
        selectionStyle = .none
        layer.cornerRadius = 30
        clipsToBounds = true
//        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        collectionView.backgroundColor = .black
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
    

    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
//    var imageSet: [String] = [] {
//        didSet {
//            self.progressView.setProgress(Float(1.0) / Float(self.imageSet.count), animated: false)
//            self.collectionView.reloadData()
//        }
//    }
    
}

extension MemoDetailPhotoCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PhotoNestedCell.self), for: indexPath) as! PhotoNestedCell
        cell.backgroundColor = .purple
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        progressView.progress = Float((scrollView.contentOffset.x / collectionView.frame.width) + 1) / Float(self.imageSet.count)
    }
    
}

extension MemoDetailPhotoCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.contentView.frame.width
        return CGSize(width: width, height: width)
    }
}
