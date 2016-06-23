//
//  TLListModel.swift
//  TheList
//
//  Created by Developer on 6/8/16.
//  Copyright © 2016 Blaine Anderson. All rights reserved.
//

import Foundation
import CloudKit
import CoreLocation

class TLListModel: NSObject {

    var viewController : FirstViewController
    
    var lists: Array<CKRecord> = []
    
    init(container: CKContainer, viewController: FirstViewController) {
        
        let cloudkit = TLCloudKitHelper()
        self.viewController = viewController
        
        super.init()
        
        
        let predicate = NSPredicate(value: true)
        
        let query = CKQuery(recordType: "List", predicate: predicate)
        
        
        cloudkit.publicDB.performQuery(query, inZoneWithID: nil) { (results, error) -> Void in
            if error != nil {
                print(error)
            }
            else {
                print(results)
                
                for result in results! {
                    self.lists.append(result )
                }
                
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                   viewController.listTableView.reloadData()
                })
            }
        }
        //userInfo = UserInfo(container: container)
     
    }
}



