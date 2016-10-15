
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
        self.container = CKContainer.default()
        self.publicDB = container.publicCloudDatabase
        self.privateDB = container.privateCloudDatabase 
    }
    
    func saveItemRecord(_ item: String, listId: String, recordName: String) {
        let itemRecord = CKRecord(recordType: "Item")
        itemRecord.setValue(item, forKey: "ItemName")
        let reference = CKReference(recordID: CKRecordID( recordName: recordName), action: .deleteSelf)
        itemRecord.setObject(reference, forKey: "List")
        self.publicDB.save(itemRecord, completionHandler: { (record, error) -> Void in
            if let saveError = error as NSError? {
                 NSLog("There was an error saving the record: %@", saveError)
            }else{
                 NSLog("Saved Item %@ to cloud kit", item)
            }
            
        })
    }
    
    func createList(_ listName: String, callback:@escaping (String)->()){
        //Create the record object
        let listRecord = CKRecord(recordType: "List")
        if(!listName.isEmpty){
            listRecord.setValue(listName, forKey: "ListName")
            //Set the referene
            let reference = CKReference(recordID: CKRecordID( recordName: TLUserModel.sharedInstance.userId), action: .none)
            var referenceArray = [CKReference]()
            referenceArray.append(reference)
            listRecord.setObject(referenceArray as CKRecordValue?, forKey: "Participants")
        }
        self.publicDB.save(listRecord, completionHandler: { (record, error) -> Void in
            if let saveError = error as NSError?{
                NSLog("There was an error saving the record: %@", saveError)
            }else{
                NSLog("Saved List to cloud kit")
                let itemRecordName = (record?.recordID.recordName)!
                callback(itemRecordName)
            }
            
        })
    }
    
    func getListItems(_ listId: CKRecord, callback:@escaping (Array<CKRecord>)->()){
       
        let ref = CKReference(recordID: listId.recordID, action: .deleteSelf)
        let predicate = NSPredicate(format: "List == %@", ref)
        let query = CKQuery(recordType: "Item", predicate: predicate)
        
        self.publicDB.perform(query, inZoneWith: nil) { (results, error) -> Void in
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
    
    func deleteListItem(_ record: CKRecord, callback:@escaping (String)->()){
        publicDB.delete(withRecordID: record.recordID) { (recordId, error ) in
            if let err = error{
                //handle error
                #if DEBUG
                    print("There was an error: %@", err)
                #endif
                TLAlertHelper.notifyUser("Error", message: "There was an error deleting your record", sender: self)
            }else{
                callback(record.value(forKey: "ListName") as! String)
            }
        }
    }
    
    func getUserRecord(_ callback:@escaping (String)->()){
        if(TLUserModel.sharedInstance.userId.isEmpty){
            #if DEBUG
                print("Getting user record")
            #endif
            container.fetchUserRecordID { (record, error) in
                TLUserModel.sharedInstance.userId = (record?.recordName)!
                #if DEBUG
                    print("User record: ", TLUserModel.sharedInstance.userId)
                #endif
                callback(TLUserModel.sharedInstance.userId)
            }
        }else{
            callback(TLUserModel.sharedInstance.userId)
        }
    }
    
}
