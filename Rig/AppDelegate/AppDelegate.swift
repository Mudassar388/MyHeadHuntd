//
//  AppDelegate.swift
//  Rig
//
//  Created by Ale on 10/07/2020.
//  Copyright © 2020 Ale. All rights reserved.
//

import UIKit
import Firebase
import Foundation
import IQKeyboardManagerSwift
import FirebaseCore
import FirebaseMessaging
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var test: String = ""
    let gcmMessageIDKey = "gcm.Message_ID"
    var senderMessage = ""
    var stringName = ""
    
    let content = UNMutableNotificationContent()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        UserDefaults.standard.set(deviceID, forKey: "deviceID")
        
        RIG.DataManager.copyObjCAppDataInSwift()
        FirebaseApp.configure()
        IndividualVC.sharedInstance.saveFcmTokenAPI()
        
        Thread.sleep(forTimeInterval: 3.0)
        IQKeyboardManager.shared.enable = true
        
        registerForPushNotifications()
        application.registerForRemoteNotifications()
        Messaging.messaging().delegate = self

        UNUserNotificationCenter.current().delegate = self
                let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { (isAllow, error) in
            if isAllow {
                Messaging.messaging().delegate = self
            }
        }
        UIApplication.shared.registerForRemoteNotifications()
        
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.tintColor = UIColor(red: 0.00, green: 0.49, blue: 0.51, alpha: 1.00)
        navigationBarAppearace.barTintColor = UIColor(red: 0.00, green: 0.49, blue: 0.51, alpha: 1.00)
        return true
    }
    
    func registerForPushNotifications() {
        UNUserNotificationCenter.current()
          .requestAuthorization(
            options: [.alert, .sound, .badge]) { [weak self] granted, _ in
            print("Permission granted: \(granted)")
            guard granted else { return }
            self?.getNotificationSettings()
          }
    }
    
    
    func getNotificationSettings() {
      UNUserNotificationCenter.current().getNotificationSettings { settings in
          guard settings.authorizationStatus == .authorized else { return }
          DispatchQueue.main.async {
            UIApplication.shared.registerForRemoteNotifications()
          }
      }
    }
    
//    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//      let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
//      let token = tokenParts.joined()
//      print("Device Token: \(token)")
//    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
      print("Failed to register: \(error)")
    }


 
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

//    func application(_ application: UIApplication,
//                     didReceiveRemoteNotification userInfo: [AnyHashable: Any],
//                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult)
//                       -> Void) {
//      // If you are receiving a notification message while your app is in the background,
//      // this callback will not be fired till the user taps on the notification launching the application.
//      // TODO: Handle data of notification
//
//      // With swizzling disabled you must let Messaging know about the message, for Analytics
//      // Messaging.messaging().appDidReceiveMessage(userInfo)
//
//      // Print message ID.
//      if let messageID = userInfo[gcmMessageIDKey] {
//        print("Message ID: \(messageID)")
//      }
//
//      // Print full message.
//      print(userInfo)
//
//      completionHandler(UIBackgroundFetchResult.newData)
//    }


}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
      print("Firebase registration fcm token: \(String(describing: fcmToken))")
        
        let deviceID = fcmToken ?? ""
        UserDefaults.standard.set(deviceID, forKey: "deviceID")

      let dataDict: [String: String] = ["token": fcmToken ?? ""]
      NotificationCenter.default.post(
        name: Notification.Name("FCMToken"),
        object: nil,
        userInfo: dataDict
      )
      // TODO: If necessary send token to application server.
      // Note: This callback is fired at each app startup and whenever a new token is generated.
    }

}

extension AppDelegate:UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
      let userInfo = notification.request.content.userInfo

      Messaging.messaging().appDidReceiveMessage(userInfo)

      // Change this to your preferred presentation option
      completionHandler([[.alert, .sound]])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
      let userInfo = response.notification.request.content.userInfo

      Messaging.messaging().appDidReceiveMessage(userInfo)

      completionHandler()
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
      Messaging.messaging().appDidReceiveMessage(userInfo)
        
        let jsonObj = PushNotification.init(dict: userInfo)
        let storyoard = UIStoryboard.init(name: "Home", bundle: nil)
        
        self.senderMessage = jsonObj.message
        let senderName =  convertStringToDictionary(text: jsonObj.sender)
        let name = senderName?["name"]
        stringName = name as! String
        
        switch jsonObj.type {
            
        case PushTypes.one.rawValue:
            
            print("friend_request")
            
            content.title = jsonObj.title
            content.subtitle = senderMessage
            content.sound = UNNotificationSound.default

            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 4, repeats: false)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request)

        case PushTypes.two.rawValue:
            print("accept_request")
            
            content.title = jsonObj.title
            content.subtitle = senderMessage
            content.sound = UNNotificationSound.default

            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 4, repeats: false)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request)
            
            let vc = storyoard.instantiateViewController(withIdentifier: "NotificationVC") as? NotificationVC
            UIApplication.topViewController()?.navigationController?.pushViewController(vc!, animated: true)

        case PushTypes.three.rawValue:
            print("membership_notification_approved")
            
            content.title = stringName
            content.subtitle = senderMessage
            content.sound = UNNotificationSound.default
            var premiumKey = UserDefaults.standard.bool(forKey: "isPremium")
            if premiumKey {
                premiumKey = true
            }

            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 4, repeats: false)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request)

        case PushTypes.four.rawValue:
            print("membership_notification_expired")
            
            content.title = jsonObj.title
            content.subtitle = senderMessage
            content.sound = UNNotificationSound.default
            
            var premiumKey = UserDefaults.standard.bool(forKey: "isPremium")
            if premiumKey {
                premiumKey = false
            }
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 4, repeats: false)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request)

        case PushTypes.five.rawValue:
            print("new_message_received")
            
            content.title = stringName
            content.subtitle = senderMessage
            content.sound = UNNotificationSound.default

            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 4, repeats: false)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request)
            
            let vc = storyoard.instantiateViewController(withIdentifier: "MessagesVC") as? MessagesVC
            UIApplication.topViewController()?.navigationController?.pushViewController(vc!, animated: true)
            
        case PushTypes.six.rawValue:
            print("membership_notification_reminder")
            
            content.title = jsonObj.title
            content.subtitle = senderMessage
            content.sound = UNNotificationSound.default

            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 4, repeats: false)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request)


        case PushTypes.seven.rawValue:
            
            print("membership_notification_user_refferal")
            
            content.title = jsonObj.title
            content.subtitle = senderMessage
            content.sound = UNNotificationSound.default

            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 4, repeats: false)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request)

            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: {
                guard let vc = storyoard.instantiateViewController(withIdentifier: "PremiuimViewController") as? PremiuimViewController else {return}
                UIApplication.topViewController()?.navigationController?.present(vc, animated: false, completion: nil)
            })
         

        case PushTypes.eight.rawValue:
            print("membership_expire_reminder")
            
            content.title = jsonObj.title
            content.subtitle = senderMessage
            content.sound = UNNotificationSound.default

            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 4, repeats: false)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request)

        case PushTypes.nine.rawValue:
            print("membership_notification_reject")
            
            content.title = jsonObj.title
            content.subtitle = senderMessage
            content.sound = UNNotificationSound.default

            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 4, repeats: false)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request)

        default:
            break
        }
    
      completionHandler(.noData)
    }
    
//    func applicationWillTerminate(_ application: UIApplication) {
//        let content = UNMutableNotificationContent()
//        content.title = stringName
//        content.subtitle = senderMessage
//        content.sound = UNNotificationSound.default
//
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 4, repeats: false)
//        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//        UNUserNotificationCenter.current().add(request)
//    }
    
    
    func convertStringToDictionary(text: String) -> [String: Any]? {
       if let data = text.data(using: .utf8) {
           do {
               let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyObject]
               return json
           } catch {
               print("Something went wrong")
           }
       }
       return nil
   }
    
}


enum PushTypes: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
}



struct PushNotification {
    var id = "id"
    var googleSenderID = "google.c.sender.id"
    var type = "type"
    var sender = "sender"
    var fbID = "google.c.fid"
    var messageID = "gcm.message_id"
    var message = "message"
    var title = "title"
//    var aps = "aps"


    init (dict: [AnyHashable : Any]) {
        self.id = dict ["id"] as! String
        self.googleSenderID = dict ["google.c.sender.id"] as! String
        self.type = dict ["type"] as! String
        self.sender = dict ["sender"] as! String
        self.fbID = dict ["google.c.fid"] as! String
        self.messageID = dict ["gcm.message_id"] as! String
        self.message = dict ["message"] as! String
        self.title = dict ["title"] as! String
//        self.aps = dict ["aps"] as! NSDictionary
    }

}

