//
//  RIGUIManager.swift
//  Rig
//
//  Created by Mac on 07/04/2022.
//  Copyright © 2022 Ale. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD
import FLAnimatedImage

class RIGUIManager : NSObject
{
    static let sharedInstance = RIGUIManager()

    override init()
    {
        super.init()
    }


     func showCustomActivityIndicator(controller :  UIViewController? , withMessage: String?)
     {
        if controller != nil
        {
            DispatchQueue.main.async {
                let loadingNotification = MBProgressHUD.showAdded(to: controller!.view, animated: true)
                loadingNotification.bezelView.color = .darkGray // Your backgroundcolor
                loadingNotification.bezelView.style = .solidColor
                loadingNotification.contentColor = .white
            }
            

        }

    }

     func hideCustomActivityIndicator(controller : UIViewController?)
     {
           DispatchQueue.main.async() { () -> Void in
               if controller != nil
               {
                   MBProgressHUD.hide(for: controller!.view, animated: true)
               }
           }
       }


//    func hideCustomActivityIndicator()
//     {
//         let  hud = JGProgressHUD(style: .dark)
//         hud.hideToast()
//      }
//
//    func showCustomActivityIndicator(controller : UIViewController? , withMessage: String?)
//    {
//        if controller != nil
//        {
//            let hud = JGProgressHUD(style: .dark)
//            hud.textLabel.text = withMessage
//            hud.show(in: controller!.view  )
//        }
//    }
//

//
     
    func showAlert(title:String?, message:String?, okButton:Bool? = false, trackAppointmentButton:Bool? = false, cancelButton:Bool?  = false, continueButton:Bool?  = false, backButton:Bool? = false, continueShoppingButton: Bool? = false, goToPaymentButton:Bool? = false, yesButton:Bool? = false,  noButton:Bool? = false, updateAppButton:Bool? = false, viewController : UIViewController, getArabicForTitle:Bool? = true, getArabicForMessage: Bool? = true, actionButtonClosure: @escaping (_ alertAction: AlertViewActions?) -> Void)
       {

        var titleText: String?
        var messageText: String?

         titleText = title ?? ""
         messageText = message ?? ""



        let alert = UIAlertController(title: titleText, message: messageText, preferredStyle: .alert)

//        let titleAttributes = [NSAttributedString.Key.font: UIFont(name: Constants.fontLight, size: 17), NSAttributedString.Key.foregroundColor: UIColor.black]
//        let titleString = NSAttributedString(string: titleText!, attributes: titleAttributes)
//        let messageAttributes = [NSAttributedString.Key.font: UIFont(name: Constants.fontLight, size: 15), NSAttributedString.Key.foregroundColor: UIColor.gray]
//          let messageString = NSAttributedString(string: messageText!, attributes: messageAttributes)
//          alert.setValue(titleString, forKey: "attributedTitle")
//          alert.setValue(messageString, forKey: "attributedMessage")

           if cancelButton ?? false
           {
               let cancelAction = UIAlertAction(title:  AlertViewActions.Cancel.rawValue, style: .cancel, handler:{_ in

                   actionButtonClosure(AlertViewActions.Cancel)
               })


               alert.addAction(cancelAction)
           }


           if okButton ?? false
           {
               let okAction = UIAlertAction(title: AlertViewActions.OK.rawValue, style: .default, handler: {_ in
                   actionButtonClosure(AlertViewActions.OK)
               })
               alert.addAction(okAction)
           }


           if yesButton ?? false
           {
               let yesAction = UIAlertAction(title:  AlertViewActions.Yes.rawValue, style: .default, handler:{_ in

                   actionButtonClosure(AlertViewActions.Yes)
               })
               alert.addAction(yesAction)
           }

           if noButton ?? false
           {
               let noAction = UIAlertAction(title:  AlertViewActions.No.rawValue, style: .cancel, handler:{_ in

                   actionButtonClosure(AlertViewActions.No)

               })
               alert.addAction(noAction)
           }
           DispatchQueue.main.async {
               viewController.present(alert, animated: true){}
           }

       }
}
