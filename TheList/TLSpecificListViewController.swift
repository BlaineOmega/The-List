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
    
    var tableData: [CKReference] = []
    var listObject: CKRecord!
    

    
    
    func initWithListObject(listObject: CKRecord) {
        self.tableData = listObject.valueForKey("ListItems") as! [CKReference]
        self.listObject = listObject
    }
    
    override func viewDidLoad() {
        self.tableData                      = listObject.valueForKey("ListItems") as! [CKReference]
        self.navigationItem.title           = listObject.valueForKey("ListName") as? String
        self.navigationItem.hidesBackButton = false

        specificListTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tableData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
         let cell:UITableViewCell = specificListTableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        
//        let list: CKRecord = self.tableData[indexPath.row]
//        cell.textLabel?.text = list.valueForKey("ListName") as? String
        
        //let item = self.tableData[indexPath.row] as? [CKReference]
        //cell.textLabel?.text = item.id as? String
        //cell.textLabel?.text = item.
        return cell
    }

}
