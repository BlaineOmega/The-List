//
//  TLSpecificListViewController.swift
//  TheList
//
//  Created by Blaine Anderson on 6/19/16.
//  Copyright © 2016 Blaine Anderson. All rights reserved.
//

import UIKit
import Foundation
import CloudKit

class TLSpecificListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource  {
    
    @IBOutlet weak var specificListTableView: UITableView!
    
    var tableData: [CKRecord] = []
    var listObject: CKRecord!
    

    
    
    func initWithListObject(_ listObject: CKRecord) {
        self.listObject = listObject
    }
    
    override func viewDidLoad() {

        self.navigationItem.title           = listObject.value(forKey: "ListName") as? String
        self.navigationItem.hidesBackButton = false
        
        specificListTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let cloudkit = TLCloudKitHelper()
        let listId = listObject
        
        cloudkit.getListItems(listId!) { (responseArray) in
            self.tableData = responseArray
            //Update UI Thread
            OperationQueue.main.addOperation({ () -> Void in
                self.specificListTableView.reloadData()
                self.specificListTableView.isHidden = false
            })

        }

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = specificListTableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        let item = self.tableData[(indexPath as NSIndexPath).row]
        cell.textLabel?.text = item.value(forKey: "ItemName") as? String
        cell.textLabel?.font = UIFont (name: "Slim Joe", size: 24)
        cell.accessoryType = .detailButton
        return cell
    }

}
