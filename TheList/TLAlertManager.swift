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
    
    
    static func notifyUser(title: String, message: String) -> Void
    {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: UIAlertControllerStyle.Alert)
        
        let cancelAction = UIAlertAction(title: "OK",
                                         style: .Cancel, handler: nil)
        
        alert.addAction(cancelAction)
//        self.presentViewController(alert, animated: true,
//                                   completion: nil)
    }
}