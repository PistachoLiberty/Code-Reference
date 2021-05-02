import UIKit
import CoreData

--------------------------------------------------------------------------------------------------
// To save into an entity in the database

    // if using a save button to save values
    @IBAction func saveButtonTapped(_ sender: UIButton) {
       let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newKey = NSEntityDescription.insertNewObject(forEntityName: "Entity", into: context)
        
        newKey.setValue(label.text, forKey: "key")
        
        do {
            try context.save()
            print("success")
        } catch {
            print("error while saving into CoreData")
        }
        }
--------------------------------------------------------------------------------------------------
// To fetch data from CoreData

// Create high level properties to save title and id of saved entries
var titleArray = [String]()
var idArray = [UUID]()

 // getData function
    // getData function
    func getData() {
        // appDelegate property (dont forget to forcast)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        // context property
        let context = appDelegate.persistentContainer.viewContext
        // request property for entity "Places"
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Places")
        // returnObjectsAsFaults = false
        request.returnsObjectsAsFaults = false
        
        // Use do-try-catch structure to fetch data
        do {
            let results = try context.fetch(request)
            
            if results.count > 0 {
                
                // Clear out the arrays first to avoid duplications
                self.titleArray.removeAll(keepingCapacity: false)
                self.idArray.removeAll(keepingCapacity: false)
                
                for result in results as! [NSManagedObject] {
                    if let title = result.value(forKey: "title") as? String {
                        self.titleArray.append(title)
                    }
                    if let id = result.value(forKey: "id") as? UUID {
                        self.idArray.append(id)
                    }
                    tableView.reloadData()
                }
            }
        } catch {
            print("Error while fetching data")
        }
    }
----------------------------------------------------------------------------------------------


