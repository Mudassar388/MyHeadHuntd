//
//  Extensions+Protocol.swift
//  TabibGroup_Swift
//
 
//

import Foundation
import UIKit





extension Encodable
{
    func objectToJSON() throws -> String
    {
        let jsonEncoder =  JSONEncoder()
            jsonEncoder.outputFormatting = .prettyPrinted
        let encodePerson = try jsonEncoder.encode(self)
        if let string  = String(data: encodePerson, encoding: .utf8){
            return string
                }
        throw NSError(domain: "object", code: 1, userInfo: ["message": "Data cannot be converted to .utf8 string"])
    }
  func asDictionary() throws -> [String: Any]
  {
    let data = try JSONEncoder().encode(self)
      guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
      throw NSError()
    }

    return dictionary
  }
    func asDictionaryVar() throws -> [String: Any]
    {
      let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
        throw NSError()
      }
        var dic : [String: Any] = [:]
        dic = dictionary
      return dic
    }
    
    
    func asArray() throws -> [Any]
    {
      let data = try JSONEncoder().encode(self)
      guard let array = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [Any] else {
        throw NSError()
      }
      return array
    }
}

extension Dictionary {

    /// Convert Dictionary to JSON string
    /// - Throws: exception if dictionary cannot be converted to JSON data or when data cannot be converted to UTF8 string
    /// - Returns: JSON string
    func toJson() throws -> String {
        let data = try JSONSerialization.data(withJSONObject: self)
        if let string = String(data: data, encoding: .utf8) {
            return string
        }
        throw NSError(domain: "Dictionary", code: 1, userInfo: ["message": "Data cannot be converted to .utf8 string"])
    }
}

extension UIImageView
{
//    func loadSimpleImage(url: String?)
//    {
//        let configurationmanager : ConfigurationManager = ConfigurationManager()
//        var urlimage = String(format: "%@%@", configurationmanager.getBaseURLImage().absoluteString, url!)
//
//        urlimage = urlimage.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? urlimage
//        self.sd_setImage(with: URL(string: urlimage), placeholderImage: TGImages.TGPlaceholderImage)
//    }
//
    func loadSimpleCloudImage(url: String?)
    {
        if let Url = url{
            self.sd_setImage(with: URL(string: Url), placeholderImage: RIGImages.RIGPlaceholderImage)
        }

    }
    
    
//    func loadChatImage(fileName: String?)
//    {
//        let urlimage = String(format: "%@%@%@", TG.DataManager.ChatUrl ?? "", APIURLs.chatUploadsAPI.rawValue , fileName!)
//        self.sd_setImage(with: URL(string: urlimage), placeholderImage: TGImages.TGPlaceholderImage)
//    }
}

extension Double
{
    var cleanValue: String {
        return self .truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
    
    func toStringWithSAR() -> String
    {
        return String(format: "SAR %.2f", self)
    }
    
    func toString () -> String
    {
        return String(format: "%.2f", self)
    }
    
    func toLongString () -> String
    {
        return String(format: "%.5f", self)
    }
}

extension CGFloat
{
    func toString () -> String
    {
        return String(format: "%f", self)
    }
}


extension String
{
    func isNotEmpty() -> Bool
    {
        if self == ""
        {
            return false
        }
        else
        {
            return true
        }
    }
    
    func toDouble() -> Double
    {
        let value = Double(self)
        return value ?? 0
    }
    
//
//    func heightOfLabelText(fontSize: CGFloat? = 12, widthMinus: CGFloat? = 30) -> CGFloat
//    {
//        let label = UILabel.init()
//        label.frame.size.width = Constants.ScreenWidth - widthMinus!
//        label.font = UIFont(name: Constants.fontArabicLight, size: fontSize!)
//        label.numberOfLines = 0
//        label.lineBreakMode = NSLineBreakMode.byWordWrapping
//        label.text = self
//        label.sizeToFit()
//
//        let height = label.systemLayoutSizeFitting(CGSize(width: Constants.ScreenWidth - widthMinus!, height: label.intrinsicContentSize.height), withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel).height
//
//        return height
//    }
    
//    func sizeOfLabelText(fontSize: CGFloat? = 12) -> CGSize
//    {
//        let label = UILabel.init()
//        label.text = self
//        label.font = UIFont(name: Constants.fontArabicLight, size: 12)
//        let size = CGSize(width: label.intrinsicContentSize.width + 40 , height: 40)
//        return size
//    }
    
 
    func getId() -> String
    {
        var splitArray: NSArray?

        if self.count > 0
        {
            splitArray = (self.components(separatedBy: "=")) as NSArray
        }
        
        if (splitArray?.count ?? 0) > 1
        {
            return (splitArray![1] as? String)!
        }
        return ""
    }
    
}

extension NSMutableString
{

//    func sha256Encode() ->NSMutableString
//    {
//        guard let stringData = self.cString(using: String.Encoding.utf8.rawValue) else { return "" }
//        let data = NSData(bytes: stringData, length: self.length)
//        var digest = [UInt8](repeating: 0, count: 32)
//        CC_SHA256(data.bytes, CC_LONG(data.length), &digest)
//
//        let output = NSMutableString.init(capacity: 32 * 2)
//
//        for i in 0..<32
//        {
//            output.appendFormat("%02x", digest[i])
//        }
//
//        return output
//    }
    
    
}
  

extension UIView
{
    func setViewForSelectedMenuItem()
    {
        self.backgroundColor = RIGColors.TGPinkColor
    }
    func setViewForUnSelectedMenuItem()
    {
        self.backgroundColor = RIGColors.TGLightGrayColor
    }
}

extension UILabel
{
    func setLabelForSelectedMenuItem()
    {
        self.textColor = RIGColors.TGPinkColor
    }
    func setLabelForUnSelectedMenuItem()
    {
        self.textColor = UIColor.lightGray
    }
}


 
extension Date{
     func convertDate(toFormat format: String) -> Date?{
           let dateFormatterPrint = DateFormatter()
           dateFormatterPrint.dateFormat = format
           let dateConverted = dateFormatterPrint.string(from: self)
           return dateFormatterPrint.date(from: dateConverted)
       }
    func convertDateToString(toFormat format: String) -> String?{
          let dateFormatterPrint = DateFormatter()
          dateFormatterPrint.dateFormat = format
          return  dateFormatterPrint.string(from: self)
        }


}
