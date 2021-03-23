

import UIKit
import CoreData

class savedUser {
     var dob: String
     var gender: String
     var name:String
     var image: String
   
    init(managedObj : NSManagedObject) {
        
        self.dob = managedObj.value(forKey: "dob") as? String  ?? ""
        self.gender = managedObj.value(forKey: "gender") as? String ?? ""
        self.name = managedObj.value(forKey: "name") as? String ?? ""
        self.image = managedObj.value(forKey: "image") as? String ?? ""
        
    }
   
}

class likedUser {
     var age: String
     var name:String
    var image: String
    var email: String
    
    init(managedObj : NSManagedObject) {
        
        self.age = managedObj.value(forKey: "age") as? String  ?? ""
        self.email = managedObj.value(forKey: "email") as? String ?? ""
        self.name = managedObj.value(forKey: "name") as? String ?? ""
        self.image = managedObj.value(forKey: "picture") as? String ?? ""
        
    }
   
}
