//
//  TLCloudKitHelper.swift
//  TheList
//
//  Created by Blaine Anderson on 6/21/16.
//  Copyright © 2016 Blaine Anderson. All rights reserved.
//

import Foundation
import CloudKit

class TLCloudKitHelper {
    
    var container : CKContainer
    var publicDB : CKDatabase
    var privateDB : CKDatabase
    
    
    init(){
        self.container = CKContainer.defaultContainer() //1
        self.publicDB = container.publicCloudDatabase //2
        self.privateDB = container.privateCloudDatabase //3
    }
    
    func saveItemRecord(item: String) {
        let itemRecord = CKRecord(recordType: "Item")
        itemRecord.setValue(item, forKey: "ItemName")
        self.publicDB.saveRecord(itemRecord, completionHandler: { (record, error) -> Void in
            if let saveError = error {
                 NSLog("There was an error saving the record: %@", saveError)
            }else{
                 NSLog("Saved to cloud kit")
            }
            
        })
    }
    
}
