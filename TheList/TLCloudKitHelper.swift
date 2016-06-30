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
    
    func saveItemRecord(item: String, listId: String) {
        let itemRecord = CKRecord(recordType: "Item")
        itemRecord.setValue(item, forKey: "ItemName")
        itemRecord.setValue(listId, forKey: "ListId")
        self.publicDB.saveRecord(itemRecord, completionHandler: { (record, error) -> Void in
            if let saveError = error {
                 NSLog("There was an error saving the record: %@", saveError)
            }else{
                 NSLog("Saved Item to cloud kit")
            }
            
        })
    }
    
    func createList(listName: String, callback:(String)->()){
        let itemRecord = CKRecord(recordType: "List")
        if(!listName.isEmpty){
            itemRecord.setValue(listName, forKey: "ListName")
        }
        self.publicDB.saveRecord(itemRecord, completionHandler: { (record, error) -> Void in
            if let saveError = error {
                NSLog("There was an error saving the record: %@", saveError)
            }else{
                NSLog("Saved List to cloud kit")
                let itemRecordName = (record?.recordID.recordName)!
                callback(itemRecordName)
            }
            
        })
    }
    
    func getListItems(listId: String, callback:(Array<CKRecord>)->()){
        let predicate = NSPredicate(format: "ListId == %@", listId)
        let query = CKQuery(recordType: "Item", predicate: predicate)
        
        self.publicDB.performQuery(query, inZoneWithID: nil) { (results, error) -> Void in
            if error != nil {
                print(error)
            }
            else {
                print(results)
                var listItems: Array<CKRecord> = []
                for result in results! {
                    listItems.append(result)
                }
                callback(listItems)
            }
        }
    }
    
    func deleteListItem(record: CKRecord, callback:(String)->()){
        publicDB.deleteRecordWithID(record.recordID) { (recordId, error ) in
            if let err = error{
                //handle error
                #if DEBUG
                print("There was an error: %@", err)
                #endif
                TLAlertHelper.notifyUser("Error", message: "There was an error deleting your record")
            }else{
                callback(record.valueForKey("ListName") as! String)
            }
        }
    }
    
    func getUserRecord() {
#if DEBUG
        print("Getting user record")
#endif
    }

    
}
