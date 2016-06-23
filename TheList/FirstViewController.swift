//
//  FirstViewController.swift
//  TheList
//
//  Created by Blaine Anderson on 5/1/16.
//  Copyright © 2016 Blaine Anderson. All rights reserved.
//

import UIKit
import CloudKit

class FirstViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var listTableView: UITableView!
    var list: TLListModel!
    var specificList: CKRecord!
    
    var tableData: [String] = ["Christ Redeemer", "Great Wall of China", "Machu Picchu","Petra","Pyramid at Chichén Itzá","Roman Colosseum","Taj Mahal"]


    override func viewDidLoad()
    {
        super.viewDidLoad()
        let myContainer = CKContainer.defaultContainer()
        list = TLListModel(container: myContainer, viewController: self)
        // Do any additional setup after loading the view, typically from a nib.
        listTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("number of items: %i", list.lists.count)
    return list.lists.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell:UITableViewCell = listTableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        let list: CKRecord = self.list.lists[indexPath.row]
        cell.textLabel?.text = list.valueForKey("ListName") as? String
//    cell.textLabel?.text = self.tableData[indexPath.row]
    return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("This object has been selected")
        print(self.list.lists[indexPath.row])
        
        specificList = self.list.lists[indexPath.row]
        performSegueWithIdentifier("TLSpecificListSegue", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "TLSpecificListSegue"{
            if let destinationVC = segue.destinationViewController as? TLSpecificListViewController{
                destinationVC.listObject = specificList
            }
        }
    }

}

