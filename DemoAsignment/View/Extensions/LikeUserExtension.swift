

import Foundation
import UIKit

extension LikeViewController : UITableViewDataSource
{
    // MARK: - Table view datasource method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.tableDataArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
        
        let dataDict = self.tableDataArray[indexPath.row]

        cell.lbl_name.text = dataDict.name
        cell.lbl_email.text = dataDict.email
        cell.lbl_age.text = dataDict.age
        Utility().setImage(imageView: cell.img_user, url: dataDict.image ?? "", placeHolderImage: "profile_dummy")

        return cell
    }
}

