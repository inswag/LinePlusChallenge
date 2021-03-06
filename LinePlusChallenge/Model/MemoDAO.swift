//
//  MemoDAO.swift
//  LinePlusChallenge
//
//  Created by Insu Park on 2020/02/16.
//  Copyright © 2020 INSWAG. All rights reserved.
//

import CoreData
import UIKit

class MemoDAO {
    
    // MARK:- Properties
    
    lazy var context: NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }()
    
    // MARK:- Methods
    
    // For MemoList
    func fetch() -> [MemoData] {
        var memolist = [MemoData]()
        
        let fetchRequest: NSFetchRequest<MemoMO> = MemoMO.fetchRequest()
        let regdateDesc = NSSortDescriptor(key: "regdate",
                                           ascending: false)
        fetchRequest.sortDescriptors = [regdateDesc]
        
        do {
            let resultSet = try self.context.fetch(fetchRequest)
            
            for record in resultSet {
                let data = MemoData()
                data.title = record.title
                data.contents = record.contents
                data.regdate = record.regdate! as Date
                data.objectID = record.objectID
                
//                data.images = record.images
                
                
                if let images = record.images {
                    data.images = NSKeyedUnarchiver.unarchiveObject(with: images) as? [UIImage]
                }
                
//                if let image = record.image as Data? {
//                    data.image = UIImage(data: image)
//                }
                
                memolist.append(data)
                
            }
        } catch let error as NSError {
            NSLog("Error: \(error.localizedDescription)")
        }
        
        return memolist
    }
    
    
    // For MemoDetail & Modify
    func fetchSingle(indexPath: IndexPath) -> MemoData {
        var memolist = [MemoData]()
        
        let fetchRequest: NSFetchRequest<MemoMO> = MemoMO.fetchRequest()
        let regdateDesc = NSSortDescriptor(key: "regdate",
                                           ascending: false)
        fetchRequest.sortDescriptors = [regdateDesc]
        
        do {
            let resultSet = try self.context.fetch(fetchRequest)
            
            for record in resultSet {
                let data = MemoData()
                
                data.title = record.title
                data.contents = record.contents
                data.regdate = record.regdate! as Date
                data.objectID = record.objectID
                
                if let images = record.images {
                    //            object.image = image.pngData()!
                    data.images = NSKeyedUnarchiver.unarchiveObject(with: images) as? [UIImage]
                }
                
                memolist.append(data)
            }
        } catch let error as NSError {
            NSLog("Error: \(error.localizedDescription)")
        }
        
        return memolist[indexPath.row]
    }
    
    // For MemoAdd
    func insert(_ data: MemoData) {
        let object = NSEntityDescription.insertNewObject(forEntityName: "Memo",
                                                         into: self.context) as! MemoMO
        object.title = data.title
        object.contents = data.contents
        object.regdate = data.regdate!

        if let images = data.images {
            object.images = NSKeyedArchiver.archivedData(withRootObject: images)
        }

        do {
            try self.context.save()
        } catch let error as NSError {
            NSLog("Error :", error.localizedDescription)
        }
    }
    
    func delete(_ objectID: NSManagedObjectID) -> Bool {
        let object = self.context.object(with: objectID)
        self.context.delete(object)
        do {
            try self.context.save()
            return true
        } catch let error as NSError {
            NSLog("Error : ", error.localizedDescription)
            return false
        }
    }
    
    func edit(_ objectID: NSManagedObjectID, title: String, contents: String, images: [UIImage]?) -> Bool {

        let object = self.context.object(with: objectID)

        object.setValue(title, forKey: "title")
        object.setValue(contents, forKey: "contents")

        if let images = images {
            
            let result = NSKeyedArchiver.archivedData(withRootObject: images)
            object.setValue(result, forKey: "images")
        }
            
        do {
            try context.save()
            return true
        } catch {
            context.rollback()
            return false
        }
    }
    
}
