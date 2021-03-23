

import UIKit
import SVProgressHUD
import Kingfisher
import MobileCoreServices
import SystemConfiguration
import CommonCrypto


class Utility: NSObject {
    
    var pathUrl : String?
    
    //  MARK:- CheckInternetCOnnection
    func isInternetAvailable() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
            
        }) else {
            
            return false
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
    func setRoundCorner(view:UIView)
    {
        view.layer.cornerRadius = view.frame.size.height/2;
        view.clipsToBounds = true;
    }
    
    
    //  MARK:- GETIMAGE
    
    func setImage(imageView:UIImageView,url:String, placeHolderImage : String)
    {
        let urlString : String = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        if  (urlString == "")
        {
            imageView.image =  UIImage(named: placeHolderImage)
        }
        else
        {
            
            if let url = NSURL(string: urlString)
            {
                
                let sharedImageUrl: URL = url as URL
                imageView.kf.setImage(with: sharedImageUrl, placeholder: UIImage(named:placeHolderImage), options: [.transition(.fade(0.3))], progressBlock: nil, completionHandler: nil)
            }
            else
            {
                imageView.image =  UIImage(named: placeHolderImage)!
            }
            
        }
        
    }
    func getDateStringFromPicker(sender : UIDatePicker, format : String) -> String
    {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = format
        return timeFormatter.string(from: sender.date)
    }
    
    
    
}
