//
//  MemoDetailContentCellViewModel.swift
//  LinePlusChallenge
//
//  Created by Insu Park on 2020/02/20.
//  Copyright © 2020 INSWAG. All rights reserved.
//

class MemoDetailContentCellViewModel {
    
    // MARK:- Properties
    
    let contents: String?
    
    // MARK:- Initialize
    
    init(contents: MemoData) {
        self.contents = contents.contents
    }
    
    
}
