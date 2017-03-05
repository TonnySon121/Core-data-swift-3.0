//
//  DataTableViewController.swift
//  Manager
//
//  Created by Tonny Son on 02/03/2017.
//  Copyright © 2017 Tonny Son. All rights reserved.
//

import UIKit
import CoreData

class DataTableViewController: UITableViewController {

    var arrName:[NSManagedObject]!
    var arrAddress:[NSManagedObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        arrName = []
        arrAddress = []
        
        let app = UIApplication.shared.delegate as! AppDelegate
        let context = app.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Manager")
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try! context.fetch(request)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    arrName.append(result)
                    arrAddress.append(result)
                    
                }
            }
        }
        
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrName.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let name = self.arrName[indexPath.row].value(forKey: "name") as! String
        let address = self.arrAddress[indexPath.row].value(forKey: "address") as! String
        
        cell.textLabel?.text = name
        cell.detailTextLabel?.text = address

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            context.delete(self.arrName[indexPath.row])
            appDelegate.saveContext()
            
            arrName.remove(at: indexPath.row)
            tableView.reloadData()
            
            
            print("Delete Success")
        } else if editingStyle == .insert {
        }    
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UpdateManager" {
            let v = segue.destination as! ViewController
            let indexpath = self.tableView.indexPathForSelectedRow
            let row = indexpath?.row
            v.manager = arrName[row!]
        }
    }
    

}
