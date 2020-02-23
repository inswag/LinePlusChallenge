//
//  MemoModifyPhotoCell.swift
//  LinePlusChallenge
//
//  Created by Insu Park on 2020/02/23.
//  Copyright © 2020 INSWAG. All rights reserved.
//

import UIKit

class MemoModifyPhotoCell: TableViewCell {

    // MARK:- Properties
    
    var viewModel: MemoAddPhotoCellViewModel!
    let notiCenter = NotificationCenter.default
    
    // MARK: - UI Properties
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: CGRect.zero,
                                  collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.showsHorizontalScrollIndicator = false
        cv.setCollectionViewLayout(layout, animated: true)
        cv.dataSource = self
        cv.delegate = self
        cv.register(ModifyPhotoNestedAddCell.self,
                    forCellWithReuseIdentifier: String(describing: ModifyPhotoNestedAddCell.self))
        cv.register(ModifyPhotoNestedImageCell.self,
                    forCellWithReuseIdentifier: String(describing: ModifyPhotoNestedImageCell.self))
        return cv
    }()
    
    let borderView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    // MARK:- Initialize & Deinitialize
    
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: .default,
                   reuseIdentifier: String(describing: MemoModifyController.self))
        
        addObserver()
        
    }
    
    deinit {
        notiCenter.removeObserver(self,
                                  name: NSNotification.Name("requestReload"),
                                  object: nil)
        notiCenter.removeObserver(self,
                                  name: NSNotification.Name("requestDelete"),
                                  object: nil)
        notiCenter.removeObserver(self, name: NSNotification.Name("requestFetch"), object: nil)
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
    
    fileprivate func addObserver() {
        notiCenter.addObserver(self, selector: #selector(actionReloadByAdd), name: NSNotification.Name(rawValue: "requestReload"), object: nil)
        notiCenter.addObserver(self, selector: #selector(actionReloadByDelete), name: NSNotification.Name(rawValue: "requestDelete"), object: nil)
        notiCenter.addObserver(self, selector: #selector(actionReloadByFetching), name: NSNotification.Name(rawValue: "requestFetch"), object: nil)

    }
    
    @objc func actionReloadByAdd() {
        self.collectionView.reloadData()
    }
    
    @objc func actionReloadByDelete() {
        self.collectionView.reloadData()
    }
    
    @objc func actionReloadByFetching() {
        self.collectionView.reloadData()
        print("Fetch finish")
    }
}

// MARK:- Collection View Data Source

extension MemoModifyPhotoCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ModifyPhotoNestedAddCell.self),
                                                                for: indexPath) as? ModifyPhotoNestedAddCell else { return UICollectionViewCell() }
            return cell
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ModifyPhotoNestedImageCell.self),
                                                                for: indexPath) as? ModifyPhotoNestedImageCell else { return UICollectionViewCell() }
            cell.viewModel = ModifyPhotoNestedImageCellViewModel(image: viewModel.images[indexPath.item - 1], indexPath: indexPath.item - 1)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
    
}

// MARK:- Collection View Delegate Flow Layout

extension MemoModifyPhotoCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 56, height: 56)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
}

