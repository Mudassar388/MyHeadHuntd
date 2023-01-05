//
//  ViewController.swift
//  Rig
//
//  Created by Muhammad Asar on 2022-07-24.
//  Copyright © 2022 Ale. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var refTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    
    @IBOutlet weak var premiumView: UIView!
    
    static let sharedvc = PopUpViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.layer.cornerRadius = 5
        submitButton.layer.cornerRadius = 10
        cancelButton.layer.cornerRadius = 10
        refTextField.layer.cornerRadius = 10
        
        refTextField.attributedPlaceholder = NSAttributedString(
            string: "Add Refferal Code",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "greenColor")?.withAlphaComponent(0.2)]
        )
    }
    

    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func submitAction(_ sender: Any) {
        self.saveRefferalCode()
    }
    
    func saveRefferalCode () {
        let referalText = refTextField.text ?? ""
        let params = [
            "refferal_code": referalText
        ] as [String: Any]
        
        HTTPManager.shared.post(APIURLs.saveRefferal.rawValue, withparams: params, noHeaders: false) { (response: Refferal?) in
            guard let response = response else {return }
            if response.status == 200 {
                let alert = UIAlertController(title: "Refferal", message: response.message ?? "", preferredStyle: UIAlertController.Style.alert)
                      alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
                      }))
                self.present(alert, animated: true, completion: nil)
                print("ERROR TO DECODING3")
                
            } else {
                
                let alert = UIAlertController(title: "Refferal", message: response.message ?? "", preferredStyle: UIAlertController.Style.alert)
                      alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
                      }))
                self.present(alert, animated: true, completion: nil)
                print("ERROR TO DECODING3")
            }
        }
    }
    
    @IBAction func laterButton(_ sender: Any) {
    }
    
    
    @IBAction func addNowButton(_ sender: Any) {
    }
    
    @IBAction func dismissButton(_ sender: Any) {
    }
}
