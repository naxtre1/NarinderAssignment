

import UIKit

class UserViewController: UIViewController {
    
    @IBOutlet weak var tableView_user: UITableView!
    
    @IBOutlet weak var segmentControl_gender: UISegmentedControl!
    
    
    var userViewModel : UserViewModel = UserViewModel()
    
    var maleListData : [UserResponse?]? = nil
    var femaleListData : [UserResponse?]? = nil
    
    var selectedInex : Int = 0 {
        didSet
        {
            DispatchQueue.main.async {
                self.tableView_user.reloadData()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setUpIntialData()
        getUsers()
    }
    
    
    func setUpIntialData()
    {
        tableView_user.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "UserTableViewCell")
        let likeButtonItem = UIBarButtonItem.init(
            title: "Like",
            style: .done,
            target: self,
            action: Selector("likeButtonAction")
        )
        self.navigationItem.rightBarButtonItem = likeButtonItem
    }
    
    @objc func likeButtonAction()
    {
        let likeVC = self.storyboard!.instantiateViewController(withIdentifier: "LikeVC") as! LikeViewController
        self.navigationController?.pushViewController(likeVC, animated: true)
    }
    
    
    
    private func getUsers()
    {
        if !Utility().isInternetAvailable(){
            self.showPositiveMessage(message: "Please check you internet connection.")
            return
        }
        else{
            userViewModel.getUsers { (userApiResponse) in
                if (userApiResponse != nil)
                {
                    self.maleListData = userApiResponse?.filter { $0.gender == "male" }
                    self.femaleListData = userApiResponse?.filter { $0.gender == "female" }
                    self.selectedInex = 0
                }
                else
                {
                    debugPrint("Error")
                }
            }
        }
    }
    
    
    
    @IBAction func segment_valueChanged(_ sender: Any) {
        self.selectedInex = segmentControl_gender.selectedSegmentIndex
    }
    
    
    
    
}
