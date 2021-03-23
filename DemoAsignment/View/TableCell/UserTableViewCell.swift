
import UIKit

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbl_age: UILabel!
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var img_user: UIImageView!
    @IBOutlet weak var lbl_email: UILabel!
    @IBOutlet weak var bnt_like: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        Utility().setRoundCorner(view: self.img_user)

        // Configure the view for the selected state
    }
    
}
