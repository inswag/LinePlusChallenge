//
//  Application.swift
//  LinePlusChallenge
//
//  Created by Insu Park on 2020/02/14.
//  Copyright © 2020 INSWAG. All rights reserved.
//

import UIKit

final class Application: NSObject {
    
    static let shared = Application()
    
    var window: UIWindow?
    
    private override init() {
        super.init()
    }
    
    func presentInitialScreen(in window: UIWindow) {
        self.window = window
        
        window.rootViewController = UINavigationController(rootViewController: MemoListViewController())
        
    }
}
