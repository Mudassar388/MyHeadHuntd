//
//  RIGValidationManager.swift
//  Rig
//
//  Created by Mac on 07/04/2022.
//  Copyright © 2022 Ale. All rights reserved.
//

import Foundation
import UIKit

class RIGValidationManager : NSObject
{
    static let sharedInstance = RIGValidationManager()



    func dateToString(stringDate:String) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy-MM-dd"
        let date: NSDate? = dateFormatterGet.date(from: stringDate) as NSDate?
        var  dateConverted = dateFormatterPrint.string(from: date as! Date)
        return dateConverted
    }


    //Alamofire Error Message Validation

        func alamofireErrorValidation(errorMessage:String?) -> NSError{
            var arabicMessage = ""
            if errorMessage == RIGAlerts.requestTimedout{
                arabicMessage =   RIGAlerts.requestTimedout
            }else if errorMessage  == RIGAlerts.internetConnectionOffline{
                arabicMessage =   RIGAlerts.internetConnectionOffline
            }else if errorMessage  == RIGAlerts.serverHostnameNotFound{
                arabicMessage =    RIGAlerts.serverHostnameNotFound
            }else if errorMessage  == RIGAlerts.networkConnectionLost{
                arabicMessage =   RIGAlerts.networkConnectionLost
            }else{
                arabicMessage = errorMessage ?? ""
            }
            let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : arabicMessage])
            return error
        }






   func isStringContainOnlyNumbers(_ string: String?) -> Bool
   {
        var regex: NSRegularExpression? = nil
        do {
            regex = try NSRegularExpression(
                pattern: "^[0-9][0-9]*[0-9]$",
                options: [])
        } catch {
        }
        let matches = regex?.numberOfMatches(
            in: string ?? "",
            options: [],
            range: NSRange(location: 0, length: string?.count ?? 0)) ?? 0

        if matches == 1
        {
            return true
            // String` contains all English letter.
        }
        return false

    }

    func validateLength(_ string: String?, maxLenght maxlenght: Int, minLenght: Int) -> Bool
    {
        if (string?.count ?? 0) > maxlenght || (string?.count ?? 0) < minLenght
        {
            return false
        }
        return true
    }

    func isMobileStartsFromDoubleZero(phoneNumber: String?) -> Bool
    {
        let numberWithCode = "00966\(String(describing: phoneNumber))"
        if (numberWithCode as NSString).substring(to: 2) == "00"
        {
            return true
        }
        return false
    }




    //name validation



    func isStringOnlyContainSpaces(_ string: String?) -> Bool
    {
        let set = CharacterSet.whitespaces
        if (string?.trimmingCharacters(in: set).count ?? 0) == 0
        {
            return true
        }
        return false
    }

    func isStringContainsAlphabetsAndSpacesOnlyArabic(_ string: String?) -> Bool
    {
        if isStringContainsAlphabetsAndSpacesOnlyEnglish(string)
        {
            return true // form is in Arabic but user is filling in English -> acceptable ;
        }

        var regex: NSRegularExpression? = nil
        do {
            regex = try NSRegularExpression(
                pattern: "^[\u{0620}-\u{064f}]([\u{0620}-\u{064f}]* [\u{0620}-\u{064f}])*[\u{0620}-\u{064f}]*$",
                options: [])
        } catch {
        }

        let matches = regex?.numberOfMatches(in: string ?? "", options: [], range: NSRange(location: 0, length: string?.count ?? 0)) ?? 0

        if matches == 1
        {
            return true
            // String` contains all English letter.
        }
        return false

    }

    func isStringContainsAlphabetsAndSpacesOnlyEnglish(_ string: String?) -> Bool
    {
        var regex: NSRegularExpression? = nil
        do {
            regex = try NSRegularExpression(
                pattern: "^[a-zA-Z]([a-zA-Z]* [a-zA-Z])*[a-zA-Z]*$",
                options: [])
        }
        catch
        {
        }

        // Assuming you have some NSString `string`.
        let matches = regex?.numberOfMatches(in: string ?? "", options: [], range: NSRange(location: 0, length: string?.count ?? 0)) ?? 0
        if matches == 1
        {
            return true
            // String` contains all English letter.
        }
        return false
    }



   
}
