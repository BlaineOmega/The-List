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
        self.container = CKContainer.defaultContainer()
        self.publicDB = container.publicCloudDatabase
        self.privateDB = container.privateCloudDatabase 
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
        let listRecord = CKRecord(recordType: "List")
        if(!listName.isEmpty){
            listRecord.setValue(listName, forKey: "ListName")
            let reference = CKReference(recordID: CKRecordID( recordName: TLUserModel.sharedInstance.userId), action: .None)
            var referenceArray = [CKReference]()
            referenceArray.append(reference)
            listRecord.setObject(referenceArray, forKey: "Participants")
        }
        self.publicDB.saveRecord(listRecord, completionHandler: { (record, error) -> Void in
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
    
    func getUserRecord(callback:(String)->()){
        if(TLUserModel.sharedInstance.userId.isEmpty){
            #if DEBUG
                print("Getting user record")
            #endif
            container.fetchUserRecordIDWithCompletionHandler { (record, error) in
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
