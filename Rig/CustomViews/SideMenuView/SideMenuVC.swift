//
//  SideMenuVC.swift
//  Rig
//
//  Created by STC Macbook Pro on 26/03/2021.
//  Copyright © 2021 Ale. All rights reserved.
//

import UIKit
import SDWebImage

typealias menuCB = (_ index :Int) ->()
class SideMenuVC: UIViewController, UITableViewDelegate, UITableViewDataSource, ProfilePopUp, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
   
    var completionBlock:menuCB?
    let imagePicker = UIImagePickerController()
    @IBOutlet var lblUsername: UILabel!
    @IBOutlet weak var dismissimage: UIImageView!
    @IBOutlet var imageViewDp: UIImageView!
    @IBOutlet weak var menuTableView: UITableView!
    
    var getImageData: String?
    var getcoverPhoto: String?
    var image = UIImage()
    var tableViewData: NSMutableArray!
    var tableIconData: NSMutableArray!
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        registerXib()
        SharedModel.sharedInstance.setStatusBarColor()
        self.navigationController?.setNavigationBarHidden(true, animated: false)

        if RIG.DataManager.isUserLoggedIn ?? false {
        
            //let pkiImage = UserDefaults.standard.string(forKey: "image")
            let img = RIG.DataManager.userRIG?.profileImage
            if let image = img {
                imageViewDp.loadSimpleCloudImage(url: image)
            }

        }else if RIG.DataManager.isCompanyLoggedIn ?? false{
            if  let image =  RIG.DataManager.companyDataRIG?.profileImage {

                imageViewDp.loadSimpleCloudImage(url:image)
            }
        }
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        dismissimage.isUserInteractionEnabled = true
        dismissimage.addGestureRecognizer(tapGestureRecognizer)
        
        self.imageViewDp.layer.cornerRadius = 40.0
        self.imageViewDp.clipsToBounds = true
        self.imageViewDp.layer.borderColor = UIColor(red: 0.60, green: 0.79, blue: 0.82, alpha: 1.00).cgColor
        self.imageViewDp.layer.borderWidth = 1.0


        
        tableViewData = NSMutableArray()
        tableIconData = NSMutableArray()
        tableViewData.add("Profile")
        tableViewData.add("Favorites")
        tableViewData.add("Membership")
        tableViewData.add("My Network")
        //tableViewData.add("Join FB Group")
        tableViewData.add("About Us")
        tableViewData.add("Invite Socialize")
        tableViewData.add("Report Problem")
        // icon
        tableIconData.add("My Profile")
        tableIconData.add("Favourite")
        tableIconData.add("Membership")
        tableIconData.add("My Network")
        //tableIconData.add("Joni FB Group")
        tableIconData.add("About us")
        tableIconData.add("Invite")
        tableIconData.add("Report")
        
        // Do any additional setup after loading the view.
    }
    
//    func saveImage() {
//        guard let data = UIImage(named: "image")?.jpegData(compressionQuality: 0.5) else { return }
//        let encoded = try! PropertyListEncoder().encode(data)
//        UserDefaults.standard.set(encoded, forKey: "KEY")
//    }
//
//    func loadImage() -> UIImage? {
//         guard let data = UserDefaults.standard.data(forKey: "KEY") else { return UIImage() }
//         let decoded = try! PropertyListDecoder().decode(Data.self, from: data)
//         let image = UIImage(data: decoded)
//         return image
//    }

    private func registerXib(){
        menuTableView.register(UINib(nibName: "SlideTableViewCell", bundle: nil), forCellReuseIdentifier: "SlideTableViewCell")
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }


    
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
            return 60.0
        }
        public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
            return 0
        }
        public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
            return 0
        }
        
        public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return ""
        }
        
        public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String?{
            return ""
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return tableViewData.count
        }
        
        public func numberOfSections(in tableView: UITableView) -> Int{
            return 1
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SlideTableViewCell", for: indexPath) as! SlideTableViewCell
            
            cell.backgroundColor = .clear
            cell.lblName.text = (tableViewData.object(at: indexPath.row) as! String)
            cell.imageIcon.image = UIImage(named: tableIconData.object(at: indexPath.row) as! String)
            cell.imageIcon.tintColor = UIColor(named: "imageColor")
            //imageNamed:[tableImages objectAtIndex:indexPath.row
            
    //        slideCell.imageIcon.image = slideCell.imageIcon.image!.withRenderingMode(.alwaysTemplate)
            //cell.imageIcon.tintColor = UIColor.darkGray
            cell.selectionStyle = .none
            return cell
            
            
        }
        
        public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
            dismiss(animated: true, completion: nil)
            
            let storyboard = UIStoryboard(name: "Home" , bundle: nil)
            if tableViewData[indexPath.row] as! String == "My Network" {
                dismiss(animated: true, completion: nil)
//                menuTableView.isHidden = true
                guard let vc = storyboard.instantiateViewController(withIdentifier: "MyNetworkViewController") as? MyNetworkViewController else {
                    return
                }

                navigationController?.pushViewController(vc, animated: true)
            } else if tableViewData[indexPath.row] as! String == "Invite Socialize" {
                guard let refferralCode =  UserDefaults.standard.string(forKey: "ref") else { return }
                let text = "Please Install this Application using this link and use Referral Code in your App                 ReferralCode: \(refferralCode) https://appstoreconnect.apple.com/apps/1561945942"
                let textToShare = [ text ]
                let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
                activityViewController.popoverPresentationController?.sourceView = self.view
                dismiss(animated: true) {
                    UIApplication.topViewController()?.present(activityViewController, animated: true)
                }
            }
            
    //        if (indexPath.row == 13){
    //            UserDataModel.sharedInstance().clearUserData()
    //            appDelegate.isLogout = true
    //            let url = NSURL(string: GlobalConstants.base_url)
    //            let protectionSpace = URLProtectionSpace(host: url?.host ?? "", port: url?.port?.intValue ?? 0, protocol: url?.scheme, realm: nil, authenticationMethod: NSURLAuthenticationMethodHTTPDigest)
    //            let credentials = URLCredentialStorage.shared.credentials(for: protectionSpace)
    //            var credential: URLCredential! = URLCredential()
    //            for c in (credentials?.enumerated())!{
    //                credential = c.element.value
    //            }
    //            print("credential: ", credential as Any)
    //            if credentials != nil {
    //                URLCredentialStorage.shared.remove(credential, for: protectionSpace)
    //            }
    //        }
            guard let cb = completionBlock else {return}
            cb(indexPath.row)
           
    //        let credential = URLCredential(user: self.userName, password: self.password, persistence: .permanent)
    //        let url = NSURL(string: GlobalConstants.base_url)
    //        // var host = "172.16.10.60/hitchman/" as!
    //        print("port: ", url?.port?.intValue ?? 0)
    //        let protectionSpace = URLProtectionSpace(host: url?.host ?? "", port: url?.port?.intValue ?? 0, protocol: url?.scheme, realm: nil, authenticationMethod: NSURLAuthenticationMethodHTTPDigest)
    //        URLCredentialStorage.shared.setDefaultCredential(credential, for: protectionSpace)
        }
    
    
//    func topMostController() -> UIViewController? {
//        guard let window = UIApplication.shared.keyWindow,
//              let rootViewController = window.rootViewController else {
//            return nil
//        }
//
//        var topController = rootViewController
//
//        while let newTopController = topController.presentedViewController {
//            topController = newTopController
//        }
//
//        return topController
//    }
    
    
    @IBAction func privacyButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        guard let cb = completionBlock else {return}
        cb(-1)
    }
    
    @IBAction func termsButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        guard let cb = completionBlock else {return}
        cb(-2)
    }
    
    @IBAction func logoutButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        guard let cb = completionBlock else {return}
        cb(-3)
    }
    @IBAction func ProfileButtonTapped(_ sender: Any) {
        RIG.NavigationManager.PopUpshow(in: self, notificationDelegate: self)
    }
    func ButtonTapped(tag: Int) {
        
        if tag == 2 {
            EditProfileimageClick()
//             dismiss(animated: true, completion: nil)
//             guard let cb = completionBlock else {return}
//             cb(-5)


        } else {
            dismiss(animated: true, completion: nil)
            guard let cb = completionBlock else {return}
            cb(-5)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension UIApplication {
    
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
extension SideMenuVC {
    
    func ViewProfileimageClick() {}
    
    func EditProfileimageClick() {
        
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary()

        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            alert.popoverPresentationController?.sourceView = view.self
            alert.popoverPresentationController?.sourceRect = view.bounds
            alert.popoverPresentationController?.permittedArrowDirections = .up
        default:
            break
        }
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func openCamera() {
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallary() {
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated:  true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imageViewDp.image = image
        if let image = imageViewDp.image {
            self.image = image
        }
        imagePicker.dismiss(animated: true, completion: {
            self.sendImageToServer(type: "P", image: image)
            PopUpProfile.shared.contentView.isHidden = true
            PopUpProfile.shared.gestureView.isHidden = true
            
            self.dismiss(animated: true, completion: nil)
            guard let cb = self.completionBlock else {return}
//            cb(-5)
            
        })
       
    }
    
    func sendImageToServer (type: String, image: UIImage) {
        RIG.UIManager.showCustomActivityIndicator(controller: self, withMessage: "")
        let params = [
            "type": type,
            "image": image
        ] as? [String: Any]

        guard let params = params else {return}

        HTTPManager.shared.multipart(APIURLs.uploadImage.rawValue, image: image, withparams: params) { (completion: GenericModelWithoutArray<uploadImageModel>?) in

            guard let response = completion else {return}

            if response.status == 200 {
                RIG.UIManager.hideCustomActivityIndicator(controller: self)
                self.getImageData = response.data?.profile_image ?? ""
                self.getcoverPhoto = response.data?.cover_image ?? ""

                UserDefaults.standard.set(self.getImageData, forKey: "image")
            } else {
                print("something went wrong")
            }
        }
    }
}

