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
    var navigator: Navigator
    
    private override init() {
        self.navigator = Navigator()
        super.init()
    }
    
    func presentInitialScreen(in window: UIWindow) {
        self.window = window
        
        window.rootViewController = navigator.get(segue: .memoList
        )
        
    }
}
