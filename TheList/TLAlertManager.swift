//
//  TLAlertManager.swift
//  TheList
//
//  Created by Blaine Anderson on 6/21/16.
//  Copyright © 2016 Blaine Anderson. All rights reserved.
//

import Foundation
import UIKit

class TLAlertHelper: UIAlertController {
    
    
    static func notifyUser(_ title: String, message: String, sender: AnyObject) -> Void
    {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: UIAlertControllerStyle.alert)
        
        let cancelAction = UIAlertAction(title: "OK",
                                         style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
        sender.present(alert, animated: true, completion: nil)
    }
}
