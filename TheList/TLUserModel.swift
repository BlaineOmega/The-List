//
//  TLUserModel.swift
//  TheList
//
//  Created by Developer on 6/8/16.
//  Copyright © 2016 Blaine Anderson. All rights reserved.
//

import Foundation

class TLUserModel: NSObject {
    var userId : String = ""
    var userName : String = ""
    var tagline : String = ""
    static let sharedInstance = TLUserModel()
    
}
