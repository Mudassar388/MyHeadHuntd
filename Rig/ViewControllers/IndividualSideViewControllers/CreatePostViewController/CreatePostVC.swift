//
//  CreatePostVC.swift
//  Rig
//
//  Created by Ale on 11/23/20.
//  Copyright © 2020 Ale. All rights reserved.
//

import JGProgressHUD
import UIKit

class CreatePostVC: UIViewController, UITextViewDelegate {
    // MARK: - Variables

    var currentImage: UIImage?
    var imagePicker = UIImagePickerController()

    // MARK: - IBOutlets

    @IBOutlet var postDescriptionTV: UITextView!
    @IBOutlet weak var selectedImage: UIImageView!
    
    // MARK: - View Controller Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        SharedModel.sharedInstance.setStatusBarColor()
        setLayout()
        // Do any additional setup after loading the view.
    }

    // MARK: - Custom Methods

    private func setLayout() {
        postDescriptionTV.delegate = self
        imagePicker.delegate = self
    }

    // MARK: - IBActions

    @IBAction func btnActionBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnActionPost(_ sender: UIButton) {
//        if postDescriptionTV.hasText &&  postDescriptionTV.text != "Write text for the post..."{
//            if currentImage != nil {
//                let hud = JGProgressHUD(style: .dark)
//                hud.textLabel.text = "Please wait..."
//                hud.show(in: view)
//                Repository.createPost(image: currentImage, descriptionText: postDescriptionTV.text ?? "") { status, _, _ in
//                    hud.dismiss()
//                    if status {
//                        print("Post Created")
//                        self.navigationController?.popViewController(animated: true)
//                    } else {
//                        print("Unable to create post")
//                    }
//                }
//            } else {
//                let hud = JGProgressHUD(style: .dark)
//                hud.textLabel.text = "Please wait..."
//                hud.show(in: view)
//                Repository.createPost(image: currentImage, descriptionText: postDescriptionTV.text ?? "") { status, _, _ in
//                    hud.dismiss()
//                    if status {
//                        print("Post Created")
//                        self.navigationController?.popViewController(animated: true)
//                    } else {
//                        print("Unable to create post")
//                    }
//                }
//            }
//        }
    }

    @IBAction func btnActionAddAttachment(_ sender: UIButton) {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Gallery", style: .default) {
            _ in
            if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
                self.imagePicker.sourceType = .savedPhotosAlbum
                self.imagePicker.allowsEditing = false
                self.present(self.imagePicker, animated: true, completion: nil)
            } else {
                print("Camera Not found")
            }
        }
        let galleryAction = UIAlertAction(title: "Camera", style: .default) {
            _ in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.imagePicker.sourceType = .camera
                self.imagePicker.allowsEditing = false
                self.present(self.imagePicker, animated: true, completion: nil)
            } else {
                print("Unable to open gallery")
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}

//MARK:- Image picker controller delegate methods
extension CreatePostVC: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {
//            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
            return
        }
        currentImage = image
        selectedImage.image = image
        selectedImage.contentMode = .scaleAspectFill
        selectedImage.layer.cornerRadius = 25
    }

    //MARK:- Textview delegate methods
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "Write text for the post..."
        }
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Write text for the post..." {
            textView.text = ""
        }
    }
}
