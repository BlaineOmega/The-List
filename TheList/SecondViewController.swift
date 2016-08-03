//
//  SecondViewController.swift
//  TheList
//
//  Created by Blaine Anderson on 5/1/16.
//  Copyright © 2016 Blaine Anderson. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    @IBOutlet weak var createListButton: UIButton!
    @IBOutlet weak var textInputArea: UITextView!
    @IBOutlet weak var listNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createListButton.layer.borderColor  = TLUtilitiesHelper.UIColorFromHex(0x6B4A87).CGColor
        createListButton.titleLabel?.font   = UIFont (name: "Slim Joe", size: 28)

        textInputArea.layer.borderColor     = TLUtilitiesHelper.UIColorFromHex(0x6B4A87).CGColor
        textInputArea.layer.borderWidth     = 1

        listNameTextField.layer.borderColor = TLUtilitiesHelper.UIColorFromHex(0x6B4A87).CGColor
        listNameTextField.layer.borderWidth = 1
        
        print("List User Record: ", TLUserModel.sharedInstance.userId)
    }

    @IBAction func createListAction(sender: AnyObject) {
        let cloudkit = TLCloudKitHelper()
        let listArray = createListFromTextField(textInputArea.text)

        cloudkit.createList(listNameTextField.text!) { (response) in
            let listId = response
            if (!listArray.isEmpty){
                for item in listArray{
                    cloudkit.saveItemRecord(item, listId: listId)
                }
            }
        }
        
    }
    
    func createListFromTextField(listText: String) -> [String] {
        var listArray: [String] = [String]()
        listText.enumerateLines { (line, stop) in
            listArray.append(line)
        }
        return listArray
    }
    

}

