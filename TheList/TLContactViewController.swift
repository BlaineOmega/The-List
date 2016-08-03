//
//  TLContactViewController.swift
//  TheList
//
//  Created by Blaine Anderson on 6/27/16.
//  Copyright © 2016 Blaine Anderson. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

class TLContactViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet var contactTableView: UITableView!
    
    override func viewDidLoad() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image:UIImage(named:"Add")?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), style: .Done, target: self, action: #selector(TLContactViewController.addContact(_:)))
        self.title = "Contacts"
        self.navigationController!.navigationBar.barTintColor = TLUtilitiesHelper.UIColorFromHex(0x6B4A87, alpha: 1.0)
        self.navigationController!.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont (name: "Slim Joe", size: 20)!, NSForegroundColorAttributeName : UIColor.whiteColor()]
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = contactTableView.dequeueReusableCellWithIdentifier("contactCell")! as UITableViewCell
        cell.textLabel?.text = "Annabell Sussman"
        //Need to get current users from cloudkit.
//        let list: CKRecord = self.list.lists[indexPath.row]
//        cell.textLabel?.text = list.valueForKey("ListName") as? String
        cell.textLabel?.font = UIFont (name: "Slim Joe", size: 20)
//        cell.accessoryType = .DisclosureIndicator
        return cell
    }
    
    func addContact(sender: UIBarButtonItem) {
        print("Testing Function")
        performSegueWithIdentifier("TLAddContactSegue", sender: nil)
    }


    
    
}