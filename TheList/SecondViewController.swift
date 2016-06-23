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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func createListAction(sender: AnyObject) {
        let cloudkit = TLCloudKitHelper()
        let listArray = createListFromTextField(textInputArea.text)
        if (!listArray.isEmpty){
            for item in listArray{
                cloudkit.saveItemRecord(item)
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

