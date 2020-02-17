//
//  MemoAddController.swift
//  LinePlusChallenge
//
//  Created by Insu Park on 2020/02/14.
//  Copyright © 2020 INSWAG. All rights reserved.
//

import CoreData
import UIKit

class MemoAddController: ViewController {
    
    // MARK:- Properties
    
    lazy var memoDAO = MemoDAO()
    
    var memoTitle: String?
    var memoContents: String?
    
    lazy var list: [NSManagedObject] = {
        return self.fetch()
    }()
    
    func fetch() -> [NSManagedObject] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Memo")
        let result = try! context.fetch(fetchRequest)
        return result
    }
    
    // MARK:- UI Properties
    
    lazy var tableView: UITableView = {
        let tv = UITableView(frame: UIScreen.main.bounds,
                             style: UITableView.Style.plain)
        tv.allowsSelection = false
        tv.backgroundColor = .white
        tv.separatorStyle = .none
        tv.dataSource = self
        tv.delegate = self
        tv.register(MemoListCell.self,
                    forCellReuseIdentifier: String(describing: MemoListCell.self))
        tv.register(MemoAddPhotoCell.self,
                    forCellReuseIdentifier: String(describing: MemoAddPhotoCell.self))
        tv.register(MemoAddTitleCell.self,
                    forCellReuseIdentifier: String(describing: MemoAddTitleCell.self))
        tv.register(MemoAddContentCell.self,
                    forCellReuseIdentifier: String(describing: MemoAddContentCell.self))
        return tv
    }()
    
    let memoTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Writing.."
        label.textAlignment = .center
        label.textColor = UIColor.black
        return label
    }()
    
    lazy var completeButton = UIBarButtonItem(title: "Save",
                                              style: .plain,
                                              target: self,
                                              action: #selector(actionSave))
    
    
    func save(title: String, contents: String) -> Bool {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let object = NSEntityDescription.insertNewObject(forEntityName: "Memo",
                                                         into: context)
        
        object.setValue(memoTitle, forKey: "title")
        object.setValue(memoContents, forKey: "contents")
        object.setValue(Date(), forKey: "regdate")
        
        do {
            try context.save()
            self.list.append(object)
            return true
        } catch {
            context.rollback()
            return false
        }
        
    }
    
    @objc func actionSave() {
        
        // 제목이 입력되지 않은 경우에 대한 alert 처리가 필요.
        guard self.memoTitle?.isEmpty == false else {
            let alert = UIAlertController(title: nil,
                                          message: "제목을 입력해주세요",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        
        if self.save(title: memoTitle!, contents: memoContents!) == true {
            self.tableView.reloadData()
        }
        
        
//        let data = MemoData()
//        data.title =
//        data.contents
//        data.image
//        data.regdate
//
//        self.memoDAO.insert()
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

        self.view.backgroundColor = .white
        
        [tableView].forEach {
            self.view.addSubview($0)
        }
    }
    
    override func setupUILayout() {
        tableView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
}

// MARK:- Table View Data Source

extension MemoAddController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MemoAddPhotoCell.self),
                                                     for: indexPath) as! MemoAddPhotoCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MemoAddTitleCell.self),
                                                     for: indexPath) as! MemoAddTitleCell
            self.memoTitle = cell.titleTextField.text
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MemoAddContentCell.self),
                                                     for: indexPath) as! MemoAddContentCell
            self.memoContents = cell.contentTextView.text
            return cell
        default :
            return UITableViewCell()
        }
    }
    
}

// MARK:- Table View Delegate

extension MemoAddController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
        case 0, 1:
            return 72
        default:
            
            return 300
//            return UITableView.automaticDimension
        }
        
    }
    
    
    
}
