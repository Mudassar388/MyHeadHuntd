//
//  EditProfileViewController.swift
//  Rig
//
//  Created by Muhammad Asar on 2022-09-19.
//  Copyright © 2022 Ale. All rights reserved.
//

import UIKit
import iOSDropDown
class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    static let sharedinstant: EditProfileViewController = EditProfileViewController()
    
    @IBOutlet weak var tfFirstName: UITextField!
    @IBOutlet weak var tfLastName: UITextField!
    @IBOutlet weak var tfDesignation: DropDown!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var changePassword: UIButton!
    @IBOutlet weak var changeImageButton: UIButton!
    @IBOutlet weak var tfOldPassword: UITextField!
    @IBOutlet weak var tfNewPassword: UITextField!
    @IBOutlet weak var oldPassimgicon: UIImageView!
    @IBOutlet weak var newpassimgicon: UIImageView!
    @IBOutlet weak var tfConfirmPassword: UITextField!
    @IBOutlet weak var cnfrmpassimgicon: UIImageView!
    @IBOutlet weak var tfView: UIView!
    let imagePicker = UIImagePickerController()
    
    var jobSkill: [JobSkills] = []
    var profile = ProfileViewModel()
    var editProfile: EditProfile? = nil
    var showPassword: Bool = false
    var showConfirmPassword: Bool = false
    var showNewPassword: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProfileImage()
        updateDropdown()
        editProfileDropDown()
//        NotificationCenter.default.addObserver(self, selector: #selector(objectReceived), name: Notification.Name("editprofilenotification"), object: nil)
        //editProfileDrop()
        tfEmail.text = profile.profileV?.email
        tfFirstName.text = profile.profileV?.firstName
        tfLastName.text = profile.profileV?.lastName
        tfDesignation.text = profile.profileV?.designation?.title
        profileImage.loadSimpleCloudImage(url:profile.profileV?.profileImage)
        let profileImg = UserDefaults.standard.string(forKey: "image")
        if let profileImage = profileImg {
            self.profileImage.loadSimpleCloudImage(url: profileImg)
            
        }
        
        tfView.isHidden = true
        imagePicker.delegate = self
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        
        let tapGestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(newImageTapped(tapGestureRecognizer:)))
        
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(confirmImageTapped(tapGestureRecognizer:)))
        
        oldPassimgicon.isUserInteractionEnabled = true
        oldPassimgicon.addGestureRecognizer(tapGestureRecognizer)
        oldPassimgicon.isHidden = false
        
        newpassimgicon.isUserInteractionEnabled = true
        newpassimgicon.addGestureRecognizer(tapGestureRecognizer1)
        
        cnfrmpassimgicon.isUserInteractionEnabled = true
        cnfrmpassimgicon.addGestureRecognizer(tapGestureRecognizer2)
        
    }
   
    
    @IBAction func btnDropdownAction(_ sender: Any) {
        updateDropdown()
    }
    @IBAction func changePasswordAction(_ sender: UIButton) {
        tfView.isHidden = !tfView.isHidden
    }
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnSaveAction(_ sender: Any) {
        
        let email = isValidEmail(tfEmail.text ?? "")
        
        if tfFirstName.text != "" && tfLastName.text != "" {
            
            if email == true {
                editProfile(firstName: tfFirstName.text ?? "", lastName: tfLastName.text ?? "", email: tfEmail.text ?? "", jobDesignation: 2)
            } else {
                self.showAlert(title: "HeadHuntd", message: "Please Enter Correct Email")
            }
        } else {
            self.showAlert(title: "HeadHuntd", message: "Please Enter all Fields")
        }
        
        
        
//      MARK: -  When this Api is trigger ?
        
        guard let firstName = tfFirstName.text,
              let lastName = tfLastName.text,
              let email = tfEmail.text,
              let currentPass = tfOldPassword.text,
              let newPassword = tfNewPassword.text else { return }

        self.changePassword(firstName: firstName, lastName: lastName, email: email, currentPassword: currentPass, newPassword: newPassword, jobDesignation: 2)
    }
    
    
    @IBAction func changeImageButtonAction(_ sender: Any) {
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
    
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        if (tappedImage == oldPassimgicon) {
            if(showPassword){
                showPassword = false
                oldPassimgicon.image = UIImage(named: "show_pass_icon")
                tfOldPassword.isSecureTextEntry = true;
            }
            else{
                showPassword = true
                oldPassimgicon.image = UIImage(named: "hide_pass_icon")
                tfOldPassword.isSecureTextEntry = false;
            }
        }// And some actions
    }
    
    @objc func confirmImageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        if (tappedImage == cnfrmpassimgicon) {
            if(showConfirmPassword){
                showConfirmPassword = false
                cnfrmpassimgicon.image = UIImage(named: "show_pass_icon")
                tfConfirmPassword.isSecureTextEntry = true;
            }
            else{
                showConfirmPassword = true
                cnfrmpassimgicon.image = UIImage(named: "hide_pass_icon")
                tfConfirmPassword.isSecureTextEntry = false;
            }
        }
        // And some actions
    }
    
    @objc func newImageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        if (tappedImage == newpassimgicon) {
            if(showNewPassword){
                showNewPassword = false
                newpassimgicon.image = UIImage(named: "show_pass_icon")
                tfNewPassword.isSecureTextEntry = true;
            }
            else{
                showNewPassword = true
                newpassimgicon.image = UIImage(named: "hide_pass_icon")
                tfNewPassword.isSecureTextEntry = false;
            }
        }// And some actions
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
        profileImage.image = image
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func setupProfileImage() {
        
        changeImageButton.setTitle("", for: .normal)
        changeImageButton.layer.cornerRadius = changeImageButton.frame.height/2
        changeImageButton.layer.cornerRadius = changeImageButton.frame.height/2
        changeImageButton.clipsToBounds = true
        
        changePassword.layer.shadowColor = UIColor.gray.cgColor
        changePassword.layer.shadowOffset =  CGSize(width: 3, height: 3)
        changePassword.layer.shadowOpacity = 0.5
        changePassword.layer.shadowRadius = 3.0
        changePassword.backgroundColor = UIColor.white
        changePassword.clipsToBounds = false
        changePassword.layer.cornerRadius = 8
        
        profileImage.layer.borderWidth = 3
        profileImage.layer.masksToBounds = false
        profileImage.layer.borderColor = UIColor(named: "greenColor")?.cgColor
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.clipsToBounds = true
        
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func updateDropdown() {
        
        var titleArray: [String] = []
        for i in jobSkill {
            let title = i.title ?? ""
            titleArray.append(title)
        }
        if tfDesignation.text == "" {
            self.tfDesignation.text = ".Net Developer"
        }
        self.tfDesignation.optionArray = titleArray
    }
    
    func editProfile(firstName: String, lastName: String, email: String, jobDesignation: Int) {
        RIG.UIManager.showCustomActivityIndicator(controller: self, withMessage: "")
        let params = [
            "first_name": firstName,
            "last_name": lastName,
            "email": email,
            "job_designation_id": jobDesignation
        ] as! [String: Any]
        
        HTTPManager.shared.post(APIURLs.editProfile.rawValue, withparams: params, noHeaders: false) { (response: GenericModelWithoutArray<EditProfile>?)  in
            guard let response = response else {return}
            if response.status == 200 {
                RIG.UIManager.hideCustomActivityIndicator(controller: self)
                let dataModel = response.data
              self.editProfile = dataModel
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    
    
    func changePassword(firstName: String,
                        lastName: String,
                        email: String,
                        currentPassword: String,
                        newPassword: String ,
                        jobDesignation: Int) {
        
        let params = [
            "first_name": firstName,
            "last_name": lastName,
            "email": email,
            "current_password": currentPassword,
            "new_password": newPassword,
            "job_designation_id": jobDesignation
        ] as! [String: Any]
    
        HTTPManager.shared.post(APIURLs.editProfile.rawValue, withparams: params, noHeaders: false) { (response: GenericModelWithoutArray<EditProfile>?)  in
            guard let response = response else {return}
            if response.status == 200 {
                let dataModel = response.data
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
//    var profileData = [ProfileViewModel]()
//    @objc func objectReceived(_ notification: NSNotification) {
//        if let dict = notification.userInfo as? [String: Any],
//           let receivedData = dict["object"] as? ProfileViewModel
//        {
//            tfFirstName.text = receivedData.profileV?.firstName
//            tfLastName.text = receivedData.profileV?.lastName
//            tfEmail.text = receivedData.profileV?.email
//            print("i am here")
//
//        }
//
//    }
    
    
    func editProfileDropDown() {
        let designation = "designation"
        HTTPManager.shared.get("skill/industry?type=\(designation)") { (response: GenericModel<JobSkills>?) in
            guard let respo = response else {return}
            if respo.status == 200 {
                self.jobSkill = respo.data ?? []
            }
        }
    }
}
