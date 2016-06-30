//
//  TLInviteUser.swift
//  TheList
//
//  Created by Blaine Anderson on 6/29/16.
//  Copyright © 2016 Blaine Anderson. All rights reserved.
//

import UIKit
import Foundation

class TLInviteUser: UIViewController {
    @IBOutlet weak var appleIdTextEdit: UITextField!
    
    @IBOutlet weak var addFriendButton: UIButton!
    
    
    
    
    
    @IBAction func addFriendAction(sender: AnyObject) {
        print("Add User: ", (appleIdTextEdit.text)! as String)
        
        
    }
    
}