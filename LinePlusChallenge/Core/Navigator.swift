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
    }
    
    func get(segue: Scene) -> UIViewController {
        switch segue {
        case .memoList:
            let memoListVC = NavigationController(rootViewController: MemoListViewController())
            return memoListVC
        }
    }
    
    
}
