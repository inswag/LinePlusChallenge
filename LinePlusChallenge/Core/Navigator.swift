//
//  Navigator.swift
//  LinePlusChallenge
//
//  Created by Insu Park on 2020/02/14.
//  Copyright © 2020 INSWAG. All rights reserved.
//

import UIKit

class Navigator {
    
    enum Scene {
        case memoList
        case memoAdd
        case memoDetail
    }
    
    func get(segue: Scene) -> UIViewController {
        switch segue {
        case .memoList:
            let viewModel = MemoListControllerViewModel()
            let memoListVC = NavigationController(rootViewController: MemoListController(navigator: self, viewModel: viewModel))
            return memoListVC
        case .memoAdd:
            let viewModel = MemoAddControllerViewModel()
            let memoAddVC = MemoAddController(navigator: self, viewModel: viewModel)
            return memoAddVC
        case .memoDetail:
            let memoDetailVC = MemoDetailController()
            return memoDetailVC
        }
    }
    
    
}
