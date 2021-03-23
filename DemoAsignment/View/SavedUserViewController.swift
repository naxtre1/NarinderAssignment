//
//  SavedUserViewController.swift
//  DemoAsignment
//
//  Created by Anuj Goel on 23/03/21.
//

import UIKit
import CoreData

class SavedUserViewController: UIViewController {

    @IBOutlet weak var tableView_Saveduser: UITableView!

    var tableDataArray = [savedUser]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableDataArray = DBClass().getDataFromDB(entityName: "Users") ?? []
        tableView_Saveduser.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "UserTableViewCell")
        self.tableView_Saveduser.reloadData()

    }
    
}


extension SavedUserViewController : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell") as! UserTableViewCell
        let dataDict = self.tableDataArray[indexPath.row]
        cell.lbl_age.text = dataDict.dob
        cell.lbl_name.text = dataDict.name
        cell.lbl_email.text = dataDict.gender
        let dataDecoded:NSData = NSData(base64Encoded: dataDict.image, options: NSData.Base64DecodingOptions(rawValue: 0))!
        if dataDecoded != nil {
            cell.img_user.image = UIImage(data: dataDecoded as Data)
        }
        return cell
    }

}
