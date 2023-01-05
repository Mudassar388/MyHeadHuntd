//
//  RIGDataManager.swift
//  Rig
//
//  Created by Mac on 06/04/2022.
//  Copyright © 2022 Ale. All rights reserved.
//

import UIKit

class RIGDataManager: NSObject
{

    static let sharedInstance = RIGDataManager()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    var isUserLoggedIn : Bool?
    {
        didSet
        {
            UserDefaults.standard.set(isUserLoggedIn ?? false, forKey: "isUserLoggedIn")
            UserDefaults.standard.synchronize()
        }
    }
    var isCompanyLoggedIn : Bool?
    {
        didSet
        {
            UserDefaults.standard.set(isCompanyLoggedIn ?? false, forKey: "isCompanyLoggedIn")
            UserDefaults.standard.synchronize()
        }
    }
    var isUserPressed : Bool?
    {
        didSet
        {
            UserDefaults.standard.set(isUserPressed ?? false, forKey: "isUserPressed")
        }
    }
    var isCompanyPressed : Bool?
    {
        didSet
        {
            UserDefaults.standard.set(isCompanyPressed ?? false, forKey: "isCompanyPressed")
        }
    }

   var userRIG : UserModel?
   {
       didSet
       {
           let encoder = JSONEncoder()
           if let encoded = try? encoder.encode(userRIG) {
               let defaults = UserDefaults.standard
               defaults.set(encoded, forKey: "userRIG")
           }

       }
   }
    var companyDataRIG : CompanyModel?
    {
        didSet
        {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(companyDataRIG) {
                let defaults = UserDefaults.standard
                defaults.set(encoded, forKey: "companyDataRIG")
            }

        }
    }


    var deviceID : String?
    {
        didSet
        {
            UIDevice.current.identifierForVendor!.uuidString
        }
    }


    var headers : RIGHeaders?
    {
        didSet
        {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(headers) {
                let defaults = UserDefaults.standard
                defaults.set(encoded, forKey: "RIGHeaders")
            }
        }
    }


    var isCopyHeadersFormPreviousApp : Bool?
    {
        didSet
        {
            UserDefaults.standard.set(isCopyHeadersFormPreviousApp, forKey: "isCopyHeadersFormPreviousApp")
        }
    }


    override init()
    {
        super.init()
        deviceID = UIDevice.current.identifierForVendor!.uuidString
        if let rigHeaders = Constants.USER_DEFAULTS.value(forKey: "RIGHeaders")
        {
            headers = rigHeaders as? RIGHeaders
        }

        if let isUserLoggedInString = Constants.USER_DEFAULTS.value(forKey: "isUserLoggedIn")
        {
            isUserLoggedIn = isUserLoggedInString as? Bool ?? false
        }
        if let isUserLoggedInString = Constants.USER_DEFAULTS.value(forKey: "isCompanyLoggedIn")
        {
            isCompanyLoggedIn = isUserLoggedInString as? Bool ?? false
        }



        // ------ Set TGUser from User Defaults------------//
        if let userData = Constants.USER_DEFAULTS.value(forKey: "userRIG") as? Data {
            let decoder = JSONDecoder()
            if ((try? userRIG = decoder.decode(UserModel.self, from: userData)) != nil) {


            }
        }
        // ------ Set TGUser from User Defaults------------//
        if let companyData = Constants.USER_DEFAULTS.value(forKey: "companyDataRIG") as? Data {
            let decoder = JSONDecoder()
            if ((try? companyDataRIG = decoder.decode(CompanyModel.self, from: companyData)) != nil) {


            }
        }

        // ------ Set TGHeaders from User Defaults------------//
        if let headersData = Constants.USER_DEFAULTS.value(forKey: "RIGHeaders") as? Data {
            let decoder = JSONDecoder()
            if ((try? headers = decoder.decode(RIGHeaders.self, from: headersData)) != nil) {


            }
        }
         

    }

    func copyObjCAppDataInSwift()
    {
        if !(RIG.DataManager.isCopyHeadersFormPreviousApp ?? false)
        {

            let accessToken = UserDefaults.standard.value(forKey: "access-token") as? String
            if accessToken?.isNotEmpty() ?? false
            {
                var header : RIGHeaders = RIGHeaders()
                header.accessToken = accessToken
                RIG.DataManager.headers = header
            }
//            let userStatus = UserDefaults.standard.value(forKey: "userStatus") as? String
//            if userStatus == "confirmed"
//            {
//
//                let id = UserDefaults.standard.value(forKey: "id") as? Int
//                let userType = UserDefaults.standard.value(forKey: "userType") as? Int
//                let firstName = UserDefaults.standard.value(forKey: "firstName") as? String
//                let lastName = UserDefaults.standard.value(forKey: "lastName") as? String
//                let email = UserDefaults.standard.value(forKey: "email") as? String
//                let profileImage = UserDefaults.standard.value(forKey: "profileImage") as? String
//                let coverImage = UserDefaults.standard.value(forKey: "coverImage") as? String
//                let isNew = UserDefaults.standard.value(forKey: "isNew") as? Bool
//                let cvUploaded = UserDefaults.standard.value(forKey: "cvUploaded") as? Bool
//                let skillsExists = UserDefaults.standard.value(forKey: "skillsExists") as? Bool
//                let loginToken = UserDefaults.standard.value(forKey: "loginToken") as? String
//
//
//                var user : User = User()
//
//                user.id = id
//                user.userType = userType
//                user.firstName = firstName
//                user.lastName = lastName
//                user.email = email
//                user.profileImage = profileImage
//                user.coverImage = coverImage
//                user.isNew = isNew
//                user.cvUploaded = cvUploaded
//                user.skillsExists = skillsExists
//                user.loginToken = loginToken
//
//
//                RIG.DataManager.userRIG = user
//                RIG.DataManager.isUserLoggedIn = true
//                RIG.DataManager.isCopyHeadersFormPreviousApp = true
//            }
        }

   }



     
    //MARK:-

    func getJsonData(data : Data) -> Data
    {
        let jsondict = try! JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
        if jsondict["status"] as! Int == 201 || jsondict["status"] as! Int == 200
        {
             let jsonData =  try! JSONSerialization.data(withJSONObject: jsondict["data"]!, options: .prettyPrinted)
              return jsonData
        }
        else
        {
            let jsonData : Data = Data()
            return jsonData
        }

    }



   
    func dateFromString(timeString: String?, withFormatIN formatIN: String?, andFormatOut formatOUT: String?) -> String?
    {
        let fmt = DateFormatter()
        fmt.timeZone = TimeZone(abbreviation: "UTC")

        fmt.dateFormat = formatIN
        let utc = fmt.date(from: timeString ?? "")
//        var local: String? = nil
//
//        local = try? fmt.string(from: utc ?? Date.init())
//
//        print("\(local ?? "")")

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatOUT
        dateFormatter.timeZone = TimeZone.current
        var dateString: String? = nil
        dateString = dateFormatter.string(from: utc ?? Date())

        return dateString
    }

    func timeFromString(timeString: String?, withFormatIN formatIN: String?, andFormatOut formatOUT: String?) -> String?
    {
        let fmt = DateFormatter()
        fmt.timeZone = NSTimeZone(name: "AST") as TimeZone?
        fmt.dateFormat = formatIN
        let utc = fmt.date(from: timeString ?? "")
//        var local: String? = nil
//
//            local = try? fmt.string(from: utc ?? Date.init())
//
//        print("\(local ?? "")")

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatOUT
        dateFormatter.timeZone = NSTimeZone(name: "AST") as TimeZone?
        var dateString: String? = nil

        dateString = dateFormatter.string(from: utc ?? Date())

        return dateString
    }






    func convert24HoursTo12HoursTime(time: String?) -> String?
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let timeDate = dateFormatter.date(from: time ?? "")
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: timeDate ?? Date())
    }


    func dateObjectFromString(timeString: String?, withFormatIN formatIN: String?) -> Date?
    {
        let fmt = DateFormatter()
        fmt.calendar = Calendar(identifier: .gregorian)
        fmt.timeZone = NSTimeZone(name: "AST") as TimeZone?
        fmt.dateFormat = formatIN
        let utc = (fmt.date(from: timeString ?? "") ?? Date()) as Date
        return utc
    }

    func getDateStringToString(dateToConvert inputdate:String?,withFormatIN formatIN: String?,withFormatOut formatOut: String? ) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatIN
        let date = dateFormatter.date(from: inputdate ?? "") as Date?
        dateFormatter.dateFormat = formatOut
        return dateFormatter.string(from: date ?? Date())
     }







    func compressImage(image: UIImage) -> UIImage
    {
        var actualHeight: Float = Float(image.size.height)
        var actualWidth: Float = Float(image.size.width)
        let maxHeight: Float = 1000.0
        let maxWidth: Float = 1000.0
        var imgRatio: Float = actualWidth / actualHeight
        let maxRatio: Float = maxWidth / maxHeight
        let compressionQuality: Float = 1


        if actualHeight > maxHeight || actualWidth > maxWidth {
            if imgRatio < maxRatio {
                //adjust width according to maxHeight
                imgRatio = maxHeight / actualHeight
                actualWidth = imgRatio * actualWidth
                actualHeight = maxHeight
            }
            else if imgRatio > maxRatio {
                //adjust height according to maxWidth
                imgRatio = maxWidth / actualWidth
                actualHeight = imgRatio * actualHeight
                actualWidth = maxWidth
            }
            else {
                actualHeight = maxHeight
                actualWidth = maxWidth
            }
        }

        let rect = CGRect(x: 0.0, y: 0.0, width: CGFloat(actualWidth), height: CGFloat(actualHeight))
        UIGraphicsBeginImageContext(rect.size)
        image.draw(in: rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        let imageData = img!.jpegData(compressionQuality: CGFloat(compressionQuality))
        UIGraphicsEndImageContext()
        return UIImage(data: imageData!)!
    }









    func numberFromString(string: String?) ->NSNumber
    {
        if (string?.count ?? 0) > 0
        {
            let f = NumberFormatter()
            f.numberStyle = .decimal
            let t =  (try? f.number(from: string ?? "0")) ?? 0
            return t
        }
        else
        {
            return 0
        }
    }





}

 


