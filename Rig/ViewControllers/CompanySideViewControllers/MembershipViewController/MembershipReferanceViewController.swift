//
//  MembershipReferanceViewController.swift
//  Rig
//
//  Created by Sajjad Malik on 12.01.22.
//  Copyright © 2022 Ale. All rights reserved.
//

import UIKit

class MembershipReferanceViewController: UIViewController {

    @IBOutlet weak var popViewWidth: NSLayoutConstraint!
    @IBOutlet weak var popViewHeight: NSLayoutConstraint!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var popView: UIView!
    
    @IBOutlet weak var ref1Name: UITextField!
    @IBOutlet weak var ref1Email: UITextField!
    @IBOutlet weak var ref1PhoneNo: UITextField!
    @IBOutlet weak var ref1Company: UITextField!
    
    @IBOutlet weak var ref2Name: UITextField!
    @IBOutlet weak var ref2Email: UITextField!
    @IBOutlet weak var ref2PhoneNo: UITextField!
    @IBOutlet weak var ref2Company: UITextField!
    
    @IBOutlet weak var lblNote: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateView()
    }
    
    // MARK: - Action
    @IBAction func applyBtnTapped(_ sender: UIButton) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [self] in
            self.popViewHeight.constant = 200
            self.popViewWidth.constant = 212
            UIView.animate(withDuration: 0.2) {
                popView.isHidden = false
            }
        }
    }
    @IBAction func backBtnTapped(_ sender: UIButton) {
//        self.navigationController?.popViewController(animated: true)
        self.navigationController?.popToViewController(ofClass: MembershipPlanViewController.self, animated: true)
    }
    
    @IBAction func okBtnTapped(_ sender: UIButton) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [self] in
            self.popViewHeight.constant = 0
            self.popViewWidth.constant = 0
            UIView.animate(withDuration: 0.2) {
                popView.isHidden = true
            }
        }
        
    }
    // MARK: - Custom Funtion
    func updateView() {
        mainView.addshadowColor()
        mainView.addRadius(10)
        popView.addRadius(10)
        popView.addshadowColor()
        popView.isHidden = true
    }

}
