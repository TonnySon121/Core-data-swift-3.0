//
//  ViewController.swift
//  Manager
//
//  Created by Tonny Son on 02/03/2017.
//  Copyright © 2017 Tonny Son. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController {
    
    @IBOutlet weak var lblName: UITextField!
    @IBOutlet weak var lblAddress: UITextField!
    
    
    
    var manager:NSManagedObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let s = manager{
            lblName.text = s.value(forKey: "name") as! String?
            lblAddress.text = s.value(forKey: "address") as! String?
            
        }
    }

    

    @IBAction func btnSave(_ sender: Any) {
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        
        if (self.manager != nil) {
            manager?.setValue(lblName.text, forKey: "name")
            manager?.setValue(lblAddress.text, forKey: "address")
            
        } else {
            let newUser = NSEntityDescription.insertNewObject(forEntityName: "Manager", into: context)
            newUser.setValue(lblName.text, forKey: "name")
            newUser.setValue(lblAddress.text, forKey: "address")
            
        }
        
        do {
            try context.save()
            print("Save Success")
            navigationController?.popViewController(animated: true)
        } catch {
            print("Error")
        }

    }
    
    func clearText() {
        lblName.text = ""
        lblAddress.text = ""
    }
    
    
}

