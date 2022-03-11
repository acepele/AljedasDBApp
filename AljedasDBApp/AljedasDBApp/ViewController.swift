//
//  ViewController.swift
//  AljedasDBApp
//
//  Created by student on 3/10/22.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var dataManager : NSManagedObjectContext!
    var listArray = [NSManagedObject]()
    
    
    @IBAction func saveRecordBtn(_ sender: UIButton) {
        
        let newEntity = NSEntityDescription.insertNewObject(forEntityName: "Item", into: dataManager)
        newEntity.setValue(enterGlobeDescription.text!, forKey: "about")
        
        do {
            try self.dataManager.save()
            listArray.append(newEntity)
        } catch{
            print ("Error saving data")
        }
        displayDataHere.text?.removeAll()
        enterGlobeDescription.text?.removeAll()
        fetchData()
    }
    
    
    
    @IBAction func deleteRecordBtn(_ sender: UIButton) {
        
        let deleteItem = enterGlobeDescription.text!
        for item in listArray {
            if item.value(forKey: "about") as! String == deleteItem {
                dataManager.delete(item)
            }
            do {
                try self.dataManager.save()
            } catch {
                print("Error deleting data")
            }
        displayDataHere.text?.removeAll()
        enterGlobeDescription.text?.removeAll()
        fetchData()
    }
}
    
    
    @IBOutlet var enterGlobeDescription: UITextField!
    
    
    
    
    
    @IBOutlet var displayDataHere: UILabel!
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        dataManager = appDelegate.persistentContainer.viewContext
        displayDataHere.text?.removeAll()
        fetchData()
       
    }
    func fetchData() {
        let fetchRequest : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Item")
        do {
            let result = try dataManager.fetch(fetchRequest)
            listArray = result as! [NSManagedObject]
            for item in listArray {
                let product = item.value(forKey: "about") as! String
                displayDataHere.text! += product
            }
        } catch {
            print ("Error retrieving data")
        }
        
    }


}

