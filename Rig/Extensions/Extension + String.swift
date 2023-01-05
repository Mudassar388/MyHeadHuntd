//
//  Extension + String.swift
//  Rig
//
//
//

import Foundation
import UIKit


extension UIImage {
    static func from(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}
extension String {
    
    // Evaluate email
    func isEmail() -> Bool {
        let firstpart = "[A-Z0-9a-z]([A-Z0-9a-z._%+-]{0,30}[A-Z0-9a-z])?"
        let serverpart = "([A-Z0-9a-z]([A-Z0-9a-z-]{0,30}[A-Z0-9a-z])?\\.){1,5}"
        let emailRegex = firstpart + "@" + serverpart + "[A-Za-z]{2,8}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
    
    // Evaluate Password
    func isPassword() -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=])(?=\\S+$).{8,}$").evaluate(with: self)
    }
    
    // Evaluate Name
    func name(with string: String) -> (Bool, String) {
        if string.trim() == "" {
            return (false, "Please provide valid name")
        }
        return (true, "Valid surname")
    }
    // Make Encoded URL
    func encodedStringForUrl() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
    }
    
    // Width of string
    func width(_ font: UIFont) -> CGFloat {
        return self.size(withAttributes: [NSAttributedString.Key.font: font]).width
    }
    
    // height of string
    func height(_ font: UIFont) -> CGFloat {
        return self.size(withAttributes: [NSAttributedString.Key.font: font]).height
    }
    
    // Remove all white spaces
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func trimWordSpace() -> String {
        return self.replacingOccurrences(of: " ", with: "")
    }
    
    // Get height and width of text
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.width)
    }
    
    func toHexEncodedString(uppercase: Bool = true, prefix: String = "", separator: String = "") -> String {
        return unicodeScalars.map { prefix + .init($0.value, radix: 16, uppercase: uppercase) } .joined(separator: separator)
    }
    
    func addSubcript(_ fontSize: CGFloat, _ fontSuperSize: CGFloat) -> NSAttributedString {
        
        let font: UIFont? = UIFont(name: "System", size: fontSize)
        let fontSuper: UIFont? = UIFont(name: "System", size: fontSuperSize)
        let attString: NSMutableAttributedString = NSMutableAttributedString(string: self, attributes: [NSAttributedString.Key.font: font!])
        attString.setAttributes([NSAttributedString.Key.font: fontSuper!, NSAttributedString.Key.baselineOffset: 5], range: NSRange(location: 2, length: 1))
        
        return attString
    }
    func addSub(_ fontSize: CGFloat, _ fontSuperSize: CGFloat) -> NSMutableAttributedString {
        let attributed = " m2".addSubcript(fontSize, fontSuperSize)
        let anOtherString = NSAttributedString(string: self)
        let combination = NSMutableAttributedString()
        
        combination.append(anOtherString)
        combination.append(attributed)
        return combination
    }
    
    func concate(_ with: NSMutableAttributedString) -> NSMutableAttributedString {
        let anOtherString = NSAttributedString(string: self)
        let combination = NSMutableAttributedString()
        combination.append(anOtherString)
        combination.append(with)
        return combination
    }

        func base64Encoded() -> String? {
            return data(using: .utf8)?.base64EncodedString()
        }

        func base64Decoded() -> String? {
            guard let data = Data(base64Encoded: self) else { return nil }
            return String(data: data, encoding: .utf8)
        }
    
    public var withoutHtml: String {
          guard let data = self.data(using: .utf8) else {
              return self
          }

          let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
              .documentType: NSAttributedString.DocumentType.html,
              .characterEncoding: String.Encoding.utf8.rawValue
          ]

          guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
              return self
          }

          return attributedString.string
      }
}
