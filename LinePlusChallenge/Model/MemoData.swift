//
//  Memo.swift
//  LinePlusChallenge
//
//  Created by Insu Park on 2020/02/14.
//  Copyright © 2020 INSWAG. All rights reserved.
//

import UIKit
import CoreData

class MemoData {
    var memoIdx: Int?
    var title: String?
    var contents: String?
    var images: [UIImage]?
    var regdate: Date?

    var objectID: NSManagedObjectID? // access to original object
}
