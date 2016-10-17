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
    



    override func viewDidLoad()
    {
        super.viewDidLoad()
        let myContainer = CKContainer.default()
        list = TLListModel(container: myContainer, viewController: self)
        if(listTableView != nil){
            listTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        }
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("number of items: %i", list.lists.count)
        return list.lists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = listTableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        let list: CKRecord = self.list.lists[(indexPath as NSIndexPath).row]
        cell.textLabel?.text = list.value(forKey: "ListName") as? String
        cell.textLabel?.font = UIFont (name: "Slim Joe", size: 20)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("This object has been selected")
        print(self.list.lists[(indexPath as NSIndexPath).row])
        
        specificList = self.list.lists[(indexPath as NSIndexPath).row]
        performSegue(withIdentifier: "TLSpecificListSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TLSpecificListSegue"{
            if let destinationVC = segue.destination as? TLSpecificListViewController{
                destinationVC.listObject = specificList
            }
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            let cloudkit = TLCloudKitHelper()            
            cloudkit.deleteListItem(self.list.lists[(indexPath as NSIndexPath).row], callback: { (listName) in
                TLAlertHelper.notifyUser("List Deleted", message: NSString(format: "List for %@ successfully deleted", listName) as String, sender: self)
                
                 let myContainer = CKContainer.default()
                 self.list = TLListModel(container: myContainer, viewController: self)
                DispatchQueue.main.async {
                    self.listTableView.reloadData()
                }
                
            })
            
            
        }
    }

}

