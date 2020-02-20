//
//  MemoDetailTitleCellViewModel.swift
//  LinePlusChallenge
//
//  Created by Insu Park on 2020/02/20.
//  Copyright © 2020 INSWAG. All rights reserved.
//

class MemoDetailTitleCellViewModel {
    
    // MARK:- Properties
    
    let title: String?
    
    // MARK:- Initialize
    
    init(contents: MemoData) {
        self.title = contents.title
    }
    
    
}
