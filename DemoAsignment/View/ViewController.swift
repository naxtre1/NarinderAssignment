

import UIKit
import CoreData

class ViewController: UIViewController {

//    MARK:- Outlet
    
    @IBOutlet weak var imageview_User: UIImageView!
    @IBOutlet weak var lbl_userName: UITextField!
    @IBOutlet weak var textfield_DOB: UITextField!
    @IBOutlet weak var imageview_Female: UIImageView!
    @IBOutlet weak var imageview_male: UIImageView!
    
    
//    MARK:- Variable
    let imagePicker = UIImagePickerController()
    let datePicker = UIDatePicker()
    var imageData : Data?

    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupDatePicker()


        self.setInitialData()
        // Do any additional setup after loading the view, typically from a nib.
    }

//    MARK:- Set Initial Data
    
    func setInitialData() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.0001) {
            Utility().setRoundCorner(view: self.imageview_User)
        }
    }
    

    
    //    MARK:- Set up Date Picker
    
    func setupDatePicker()
    {
        //Formate Date
        
        if #available(iOS 13.4, *) {
            self.datePicker.preferredDatePickerStyle =  UIDatePickerStyle.wheels
        }
        self.datePicker.datePickerMode = .date
        self.datePicker.maximumDate = Date()
        
        //ToolBar
        
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        doneButton.tintColor = .orange
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain,  target: self, action: #selector(cancelDatePicker));
        cancelButton.tintColor = .orange
        
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        
        self.textfield_DOB.inputAccessoryView = toolbar
        self.textfield_DOB.inputView = datePicker
        
    }
    
    
    @objc func donedatePicker()
    {
        self.textfield_DOB.text = Utility().getDateStringFromPicker(sender: datePicker, format: "dd-MM-yyyy")
        self.view.endEditing(true)
    }
    
    
    @objc func cancelDatePicker()
    {
        self.view.endEditing(true)
    }
    

    
//    MARK:- Btn Clicked Action .
    
    
    @IBAction func btn_Clicked_EditImage(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Choose image", message: "Choose from existing or take new", preferredStyle: .actionSheet)
        let cameraButton = UIAlertAction(title: "Camera", style: .default, handler: { (action) -> Void in
            self.openCamera(isEdit: false)
        })
        
        let  galleryButton = UIAlertAction(title: "Gallery", style: .default, handler: { (action) -> Void in
            self.openGallery(isEdit: false)
        })
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
        })
        
        alertController.addAction(cameraButton)
        alertController.addAction(galleryButton)
        alertController.addAction(cancelButton)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func btn_Clicked_Save(_ sender: Any) {
           
           if self.lbl_userName.text == "" {
               self.showPositiveMessage(message: "Please enter user name")
               return
           }
           if textfield_DOB.text == "" {
               self.showPositiveMessage(message: "Please select user DOB.")
               return
           }
           
         
           
           let tempData =  imageData?.base64EncodedString()
           
           let dataDict = NSMutableDictionary()
           dataDict.setValue(self.lbl_userName.text, forKey: "name")
           dataDict.setValue(selectedIndex == 0 ? "male":"female", forKey: "gender")
           dataDict.setValue(self.textfield_DOB.text, forKey: "dob")
           dataDict.setValue(tempData, forKey: "image")

           if DBClass().saveDataINDB(parameter: dataDict, entityName: "Users") {
               print("-------Data Saved ------")
            self.lbl_userName.text = ""
            self.textfield_DOB.text = ""
            self.selectedIndex = 0
            imageview_male.image = #imageLiteral(resourceName: "radio_selected")
            imageview_Female.image = #imageLiteral(resourceName: "radio_unselect")
            self.imageData = nil
            self.imageview_User.image = #imageLiteral(resourceName: "profile_dummy")
           }
       }
    
    
    
    @IBAction func btn_Clicked_Male_Female(_ sender: UIButton) {
        if sender.tag == 0 {
//            male
            self.selectedIndex = sender.tag
            imageview_male.image = #imageLiteral(resourceName: "radio_selected")
            imageview_Female.image = #imageLiteral(resourceName: "radio_unselect")

        }
        else {
//            female
            self.selectedIndex = sender.tag
            imageview_male.image = #imageLiteral(resourceName: "radio_unselect")
            imageview_Female.image = #imageLiteral(resourceName: "radio_selected")
        }
    }
    
    
    
}


extension ViewController:  UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    
    // MARK: -  Open Camera
    
    func openCamera(isEdit:Bool){
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            self.imagePicker.sourceType = .camera
            self.imagePicker.delegate = self
            self.imagePicker.allowsEditing = true
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        else{
            self.showPositiveMessage(message: "Your device doesn't have Camera")
        }
    }
    
    // MARK: -  OpenPhotoGallary
    
    func openGallery(isEdit:Bool) {
        self.imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.imagePicker.allowsEditing = true
        self.imagePicker.delegate = self
        self.present(self.imagePicker, animated: true, completion: nil)
    }
    
    
    // MARK: -  ImagePickerDidFinish
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        guard let image = info[.editedImage] as? UIImage else
        {
            print("No image found")
            return
        }
        self.imageview_User.image = image
        imageData = image.jpegData(compressionQuality: 0.6)
        picker.dismiss(animated: true)
    }
    
    
    
}

extension UIViewController {
    
    func showPositiveMessage(message:String)
    {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    

    
}
