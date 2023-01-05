//
//  APIError.swift
//  MyResumeCloud
//
//  Created by Ale on 8/23/20.
//  Copyright © 2020 M.Ali Zafar. All rights reserved.
//

import Foundation
import UIKit

enum NetworkErrorString {
    
    static let kGeneralServer       = "We are unable to process your request at the moment. Please try again later."
    static let kUnknownServer       = "Connection with the server cannot be established at this time. Please try again or contact your service provider."
    static let kRequestTimeOut      = "This seems to be taking longer than usual. Please try again later."
    static let kServiceUnavailable  = "Service unavailable due to technical difficulties. Please try again or contact service provider."
    static let kNoInternet          = "There is no or poor internet connection. Please connect to stable internet connection and try again."
    static let kConnectionLost      = "The network connection was lost"
    
}

class APIError {
    static let shared = APIError()
    
    private init() {}
    
    func handleNetworkErrors(error: Error?) {
        var status = false
//        print("Error code is: \(code)")
        
        var errorMsg = ""
        
        if let err = error as? URLError {
            switch err.code {
            case .notConnectedToInternet:
                errorMsg = NetworkErrorString.kNoInternet
                break
            case .cannotFindHost:
                errorMsg = NetworkErrorString.kUnknownServer
                break
            case .timedOut:
                errorMsg = NetworkErrorString.kRequestTimeOut
                break
            case .networkConnectionLost:
                errorMsg = NetworkErrorString.kConnectionLost
                break
            default:
                errorMsg = NetworkErrorString.kGeneralServer
                break
            }
        } else {
            let message = "\(error?.localizedDescription ?? NetworkErrorString.kGeneralServer)"
            errorMsg = message
        }
        let alertController = UIAlertController(title: "Error", message: errorMsg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (okA) in
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let ivc = storyboard.instantiateViewController(withIdentifier: "SWRevealViewController") as? SWRevealViewController
//            var navigationController: UINavigationController? = nil
//            if let ivc = ivc {
//                navigationController = UINavigationController(rootViewController: ivc)
//                navigationController?.navigationBar.isHidden = true
//            }
//            UIApplication.shared.keyWindow?.rootViewController = nil
//            UIApplication.shared.keyWindow?.rootViewController = navigationController
//            UIApplication.shared.keyWindow?.makeKeyAndVisible()
        }
        alertController.addAction(okAction)
//        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
}
