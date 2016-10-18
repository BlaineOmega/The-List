//
//  SecondViewController.swift
//  TheList
//
//  Created by Blaine Anderson on 5/1/16.
//  Copyright © 2016 Blaine Anderson. All rights reserved.
//

import UIKit

class TLNewListViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var createListButton: UIButton!
    @IBOutlet weak var textInputArea: UITextView!
    @IBOutlet weak var listNameTextField: UITextField!
    
    var notificationId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createListButton.layer.borderColor  = TLUtilitiesHelper.UIColorFromHex(0x6B4A87).cgColor
        createListButton.titleLabel?.font   = UIFont (name: "Slim Joe", size: 28)

        textInputArea.layer.borderColor     = TLUtilitiesHelper.UIColorFromHex(0x6B4A87).cgColor
        textInputArea.layer.borderWidth     = 1

        listNameTextField.layer.borderColor = TLUtilitiesHelper.UIColorFromHex(0x6B4A87).cgColor
        listNameTextField.layer.borderWidth = 1
        
        print("List User Record: ", TLUserModel.sharedInstance.userId)
        
        textInputArea.delegate = self
        notificationId = "Notificationid"
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(sender:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(sender:)), name: .UIKeyboardWillHide, object: nil)
    
    }

    @IBAction func createListAction(_ sender: AnyObject) {
        let cloudkit = TLCloudKitHelper()
        let listArray = createListFromTextField(textInputArea.text)

        if(!(listNameTextField.text?.isEmpty)!){
            cloudkit.createList(listNameTextField.text!) { (response) in
                let listId = response
                if (!listArray.isEmpty){
                    for item in listArray{
                        cloudkit.saveItemRecord(item, listId: listId, recordName: response)
                    }
                }
              
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let fvc = storyboard.instantiateViewController(withIdentifier: "tabViewController")
                DispatchQueue.main.async {
                    self.present(fvc, animated: true, completion: nil)
                }
                
            }
        }else{
            TLAlertHelper.notifyUser("Give the list a name", message: "You need to give you list a name...", sender:self)
        }
        
        
    }
    
    func createListFromTextField(_ listText: String) -> [String] {
        var listArray: [String] = [String]()
        listText.enumerateLines { (line, stop) in
            listArray.append(line)
        }
        return listArray
    }
    
    func keyboardWillShow(sender: NSNotification) {
        if(listNameTextField.isFirstResponder){
            return
        }
        self.view.frame.origin.y -= 150
    }
    
    func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       view.endEditing(true)
       super.touchesBegan(touches, with: event)
    }
    
    internal func textViewDidBeginEditing(_ textView: UITextView) {
        if(textView.isKind(of: UITextField.self)){
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: notificationId!), object: nil)
        }
        
    }
    
    internal func textViewDidEndEditing(_ textView: UITextView) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: notificationId!), object: nil)
    }

}

