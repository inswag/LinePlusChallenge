//
//  ViewController.swift
//  LinePlusChallenge
//
//  Created by Insu Park on 2020/02/13.
//  Copyright © 2020 INSWAG. All rights reserved.
//

import UIKit
import SnapKit // 앱의 레이아웃을 구현하기 위해 사용합니다.

class ViewController: UIViewController {
    
    // MARK:- Initialize
     
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIComponents()
        setupUILayout()
    }
    
    // MARK:- UI Methods

    
    func setupUIComponents() {
        
    }

    func setupUILayout() {
        
    }
    
    deinit {
        print("ok")
    }
    
}
