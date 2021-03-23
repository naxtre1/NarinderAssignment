
import Foundation
import UIKit

extension UserViewController : UITableViewDataSource
{
    // MARK: - Table view datasource method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  selectedInex == 0 ? maleListData?.count ?? 0 : femaleListData?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
         
        var user_obj : UserResponse?
        
        if selectedInex == 0 {
            user_obj = maleListData?[indexPath.row]
        }
        else
        {
            user_obj = femaleListData?[indexPath.row]
        }
        cell.lbl_name.text = user_obj?.name
        cell.lbl_email.text = user_obj?.email
        cell.lbl_age.text = String(user_obj?.age ?? 0)
        Utility().setImage(imageView: cell.img_user, url: user_obj?.picture ?? "", placeHolderImage: "profile_dummy")
        cell.bnt_like.tag = indexPath.row
        cell.bnt_like.isHidden = false
        cell.bnt_like.addTarget(self, action: #selector(btn_clicked_like(_:)), for: .touchUpInside)
        
        return cell
    }
    
    
     @objc func btn_clicked_like(_ sender: UIButton) {
        
        var user_obj : UserResponse?

        if selectedInex == 0 {
            user_obj = maleListData?[sender.tag]
        }
        else
        {
            user_obj = femaleListData?[sender.tag]
        }
        
        let dataDict = NSMutableDictionary()
        dataDict.setValue(String(user_obj?.age ?? 0), forKey: "age")
        dataDict.setValue(user_obj?.name, forKey: "name")
        dataDict.setValue(user_obj?.picture, forKey: "picture")
        dataDict.setValue(user_obj?.email, forKey: "email")

        if DBClass().saveDataINDB(parameter: dataDict, entityName: "Likelist"){
            self.showPositiveMessage(message: "Liked")
        }
     }
 
    
    
}
