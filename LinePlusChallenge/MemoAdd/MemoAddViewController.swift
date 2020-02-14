//
//  MemoAddViewController.swift
//  LinePlusChallenge
//
//  Created by Insu Park on 2020/02/14.
//  Copyright © 2020 INSWAG. All rights reserved.
//

import UIKit

class MemoAddViewController: ViewController {
    
    // MARK:- Properties
    
    
    
    // MARK:- UI Properties
    
    let memoTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Writing.."
        label.textAlignment = .center
        label.textColor = UIColor.black
        return label
    }()
    
    lazy var completeButton = UIBarButtonItem(title: "Complete",
                                              style: .plain,
                                              target: self,
                                              action: #selector(actionComplete))
    
    @objc func actionComplete() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK:- View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    // MARK:- Methods
    
    override func setupUIComponents() {
        self.navigationItem.rightBarButtonItem = completeButton
        self.navigationItem.titleView = memoTitleLabel
        
        self.view.backgroundColor = .blue
        
    }
    
    override func setupUILayout() {
        
    }
    
}
