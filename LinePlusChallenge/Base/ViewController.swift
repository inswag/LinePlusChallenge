//
//  ViewController.swift
//  LinePlusChallenge
//
//  Created by Insu Park on 2020/02/13.
//  Copyright © 2020 INSWAG. All rights reserved.
//

import UIKit
import SnapKit

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
    }
    
    // MARK:- UI Methods

    
    func setupUIComponents() {
        
    }

    deinit {
        print("ok")
    }
    
}
