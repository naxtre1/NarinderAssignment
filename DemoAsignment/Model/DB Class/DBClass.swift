

import UIKit
import  CoreData

class DBClass: NSObject {
    
    func saveDataINDB(parameter : NSMutableDictionary , entityName : String) -> Bool
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return false
        }
        
        let context = appDelegate.persistentContainer.viewContext

        let entity =  NSEntityDescription.entity(forEntityName: entityName, in: context)
        let transc = NSManagedObject(entity: entity!, insertInto: context)
        
        //set the entity values
        let allkeys = parameter.allKeys
        for item in allkeys
        {
            var keyName = item as! String
            let dataValue = "\(parameter.value(forKey: item as! String)!)"
            transc.setValue(dataValue, forKey: keyName)
        }

        //save the object
        do {
            try context.save()
            print("saved!")
            print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
            return true
            
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
            return false
        } catch
        {
            return false
        }
    
    
    
    }

    
    
    func getDataFromDB(entityName : String) -> [likedUser]?
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
           
            var dataArray = [likedUser]()
            for item in result {
                if let obj : NSManagedObject = item as? NSManagedObject {
                    let saveduser = likedUser(managedObj: obj)
                    dataArray.append(saveduser)
                }
            }
            
            return dataArray
            
        } catch {
            print("Failed")
            return nil
        }
    }

    
    func getDataFromDB(entityName : String) -> [savedUser]?
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
           
            var dataArray = [savedUser]()
            for item in result {
                if let obj : NSManagedObject = item as? NSManagedObject {
                    let saveduser = savedUser(managedObj: obj)
                    dataArray.append(saveduser)
                }
            }
            
            return dataArray
            
        } catch {
            print("Failed")
            return nil
        }
    }
    
}
