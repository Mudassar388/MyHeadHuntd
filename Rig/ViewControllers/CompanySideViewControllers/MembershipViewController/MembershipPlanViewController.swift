//
//  MembershipPlanViewController.swift
//  Rig
//
//  Created by Sajjad Malik on 10.01.22.
//  Copyright © 2022 Ale. All rights reserved.
//

import UIKit
import StoreKit

class MembershipPlanViewController: UIViewController {

    @IBOutlet weak var sociateView: UIView!
    @IBOutlet weak var socialRecruiterView: UIView!
    
    @IBOutlet weak var popViewWidth: NSLayoutConstraint!
    @IBOutlet weak var popViewHeight: NSLayoutConstraint!
    @IBOutlet weak var popView: UIView!
    @IBOutlet weak var socialitePlanBtn: UIButton!
    @IBOutlet weak var recruiterPlanBtn: UIButton!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    
    
    private var buyButtonHandler: ((_ product: SKProduct) -> Void)?
    var product: SKProduct?
    var product1: SKProduct?
    var products: [SKProduct] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateView()
        self.getProductsFromServer()
        NotificationCenter.default.addObserver(self, selector: #selector(MembershipPlanViewController.handlePurchaseNotification(_:)),
                                               name: .IAPHelperPurchaseNotification,
                                               object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showViewOnUserBase()
    }
    
    
    func showViewOnUserBase() {
        if RIG.DataManager.isCompanyLoggedIn == true {
            socialRecruiterView.isHidden = false
            sociateView.isHidden = true
        } else {
            socialRecruiterView.isHidden = true
            sociateView.isHidden = false
        }
    }
    
    func getProductsFromServer() {
        RIG.UIManager.showCustomActivityIndicator(controller: self, withMessage: "")
        TechSocialProducts.store.requestProducts{ [weak self] success, products in
            guard let self = self else { return }
          if success {
              self.products = products ?? []
          } else {
              print("shit happens")
          }
            RIG.UIManager.hideCustomActivityIndicator(controller: self)
        }
        
        buyButtonHandler = { product in
         TechSocialProducts.store.buyProduct(product)
       }
    }
    
    @objc func handlePurchaseNotification(_ notification: Notification) {
      guard
        let productID = notification.object as? String,
        let _ = products.firstIndex(where: { product -> Bool in
          product.productIdentifier == productID
        })
      else { return }
    }
    
    
    
    // MARK: - Action
    
    @IBAction func recruiterPlanBtnTapped(_ sender: UIButton) {
        RIG.UIManager.showCustomActivityIndicator(controller: UIApplication.topViewController(), withMessage: "")
        guard let product = self.products.filter({ $0.productIdentifier == "com.eliteapps.techsocial.socialRecruiter1" }).first else { return }
//        RIG.UIManager.hideCustomActivityIndicator(controller: UIApplication.topViewController())
        buyButtonHandler?(product)
    }
    
    @IBAction func socialiteTappedBtn(_ sender: Any) {
        RIG.UIManager.showCustomActivityIndicator(controller: UIApplication.topViewController(), withMessage: "")
        guard let product = self.products.filter({ $0.productIdentifier == "com.eliteapps.techsocial.socialite" }).first else { return }
//        RIG.UIManager.hideCustomActivityIndicator(controller: UIApplication.topViewController())
        buyButtonHandler?(product)
    }
    
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func questionBtnTapped(_ sender: UIButton) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            guard let self = self else { return }
            UIView.animate(withDuration: 0.2) {
                self.popView.isHidden = false
                if sender.tag == 1 {
                    self.lblTitle.text = "Unilimited job postings"
                    self.lblDetail.text = "Post as many jobs as you need to attract the best talent in the market"
                } else if sender.tag == 2 {
                    self.lblTitle.text = "Recommended Socializers"
                    self.lblDetail.text = "Our research team will email you with suggested candidates based on your requirements"
                    self.popViewHeight.constant = 160
                    self.popViewWidth.constant = 180
                    
                } else if sender.tag == 3 {
                    self.lblTitle.text = "Access to verified Socializers"
                    self.lblDetail.text = "You will be able to see socializers that have provided character references to our team"
                    self.popViewHeight.constant = 160
                    self.popViewWidth.constant = 180
                } else  {
                    self.lblTitle.text = "Dummy Data"
                    self.lblDetail.text = "Detail will be updated soon."
                    self.popViewHeight.constant = 120
                    self.popViewWidth.constant = 180
                }
            }
        }
    }
    
    @IBAction func okBtnTapped(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            guard let self = self else { return }
            UIView.animate(withDuration: 0.2) {
                self.popView.isHidden = true
            }
        }
    }
    
    
    // MARK: - Custom Function
    func updateView(){
        sociateView.addshadowColor()
        sociateView.addRadius(10)
        socialRecruiterView.addshadowColor()
        socialRecruiterView.addRadius(10)
        popView.addshadowColor()
        popView.addRadius(10)
        popView.isHidden = true
    }
}
