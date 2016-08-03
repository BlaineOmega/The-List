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
//    var tableData: [String]             = ["Christ Redeemer", "Great Wall of China", "Machu Picchu","Petra","Pyramid at Chichén Itzá","Roman Colosseum","Taj Mahal"]
    var listObject: CKRecord!
    

    
    
    func initWithListObject(listObject: CKRecord) {
        self.listObject = listObject
    }
    
    override func viewDidLoad() {

        self.navigationItem.title           = listObject.valueForKey("ListName") as? String
        self.navigationItem.hidesBackButton = false
        
        specificListTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func viewWillAppear(animated: Bool) {
        let cloudkit = TLCloudKitHelper()
        let listId = listObject.recordID.recordName as String
        
        cloudkit.getListItems(listId) { (responseArray) in
            self.tableData = responseArray
            //Update UI Thread
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                self.specificListTableView.reloadData()
                self.specificListTableView.hidden = false
            })

        }

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tableData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = specificListTableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        let item = self.tableData[indexPath.row]
        cell.textLabel?.text = item.valueForKey("ItemName") as? String
        cell.textLabel?.font = UIFont (name: "Slim Joe", size: 24)
        cell.accessoryType = .DetailButton
        return cell
    }

}
