//
//  AppSingleton.swift
//  Rig
//
//  Created by Sajjad Malik on 28.12.21.
//  Copyright © 2021 Ale. All rights reserved.
//

import Foundation
import UIKit

class AppSingleton: NSObject {
    
    // MARK: - Shared instance
    static let shared = AppSingleton()
    
    // MARK: - Shared Variables
    var isLogin = false
    var currentUser: Login?
    var currentCompany: CompanyLogin?
    var loginTocken: String = ""
    func setStatusBarColor(){
        
    }
    // APP Delegate
    var appDelegate: AppDelegate!
    let userDefault = UserDefaults.standard
    // var currentUser = User(from: <#Decoder#>)
    // MARK: - Token
    func getToken() -> String {
        let token = userDefault.value(forKey: Utilities.Defaults.accessToken) as? String ?? ""
        return token
    }
    
    func saveToken(token: String) {
        userDefault.set(token, forKey: Utilities.Defaults.accessToken)
        saveContext()
    }
    
//    func saveUserData(user: Login) {
//        userDefault.set(user, forKey: Utilities.Defaults.userData)
//        saveContext()
//    }
//    
//    func getUserData() -> Login {
//        let user = userDefault.value(forKey: Utilities.Defaults.userData)
//        return user as? Login ?? Login()
//    }
    
    func getRefreshToken() -> String {
        return userDefault.value(forKey: Utilities.Defaults.refreshToken) as? String ?? ""
    }
    
    func saveRefreshToken(token: String) {
        userDefault.set(token, forKey: Utilities.Defaults.refreshToken)
        saveContext()
    }
    
    func deleteUserData() {
        userDefault.set(nil, forKey: Utilities.Defaults.accessToken)
        userDefault.set(nil, forKey: Utilities.Defaults.refreshToken)
        userDefault.set(nil, forKey: Utilities.Defaults.userData)
        saveContext()
    }
    private func saveContext() {
        userDefault.synchronize()
    }
    // Date Formates
    let appDateFormate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()
    
    let serverFormate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    let dateFormate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter
    }()
    
    func changeDateFormat(dateString: String) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        guard let resultDate = formatter.date(from: dateString) else {
            return ""
        }
        formatter.dateFormat = "yyyy.MM.dd"
        let formatedDate = formatter.string(from: resultDate)
        return formatedDate
    }
    
    
    // MARK: - Init
    override init() {
        appDelegate = UIApplication.shared.delegate as? AppDelegate
    }
    
    // MARK: - Shared methods
    func getStoryboardReference(storyboard: StoryboardReference) -> UIStoryboard {
        return UIStoryboard(name: storyboard.rawValue, bundle: nil)
    }
    
    func navigateView(viewRef: ViewControllerReference, storyboard: StoryboardReference) -> UIViewController {
        let view = getStoryboardReference(storyboard: storyboard).instantiateViewController(withIdentifier: viewRef.rawValue)
        return view
    }
    
    func setRoot(_ viewController: UIViewController) {
        if let scene = UIApplication.shared.connectedScenes.first {
            guard let windowScene = (scene as? UIWindowScene) else { return }
            let window: UIWindow = UIWindow(frame: windowScene.coordinateSpace.bounds)
            self.appDelegate.window = window
            window.windowScene = windowScene
            window.rootViewController = viewController
            window.makeKeyAndVisible()
        }
    }
    
    func getTop() -> UIViewController? {
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            
            // topController should now be your topmost view controller
            return topController
        }
        
        return nil
    }
    
    func backLogin() {
        // Navigate to get started screen
        
    }
    
    func getDate(_ formate: String = "HH:mm:ss", _ date: String) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        if let date = formatter.date(from: date) {
            formatter.dateFormat = formate
            formatter.timeZone = TimeZone(abbreviation: "UTC")
            return formatter.string(from: date)
        } else {
            return nil
        }
    }
    
    func getServerDate(_ date: String) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        if let date = formatter.date(from: date) {
            formatter.dateFormat = appDateFormate.dateFormat
            formatter.timeZone = TimeZone(abbreviation: "UTC")
            return formatter.string(from: date)
        } else {
            return nil
        }
    }
    
    func getServerDate1(_ date: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let utcDate = dateFormatter.date(from: date) ?? Date()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let dateStr = dateFormatter.string(from: utcDate)
        return dateStr
        
    }
  
    
    func hexStringToUIColor(_ hex: String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }

        if cString.count != 6 {
         //   return Utilities.Colors.appBlue ?? UIColor.lightGray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func trim(with value: Double, to digits: Int) -> String {
        let data = String(value)
        let split = data.components(separatedBy: ".")
        let sub = split[1].prefix(digits)
        return "\(split[0]).\(sub)"
    }
    
}
