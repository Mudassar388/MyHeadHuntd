//
//  StyleGuide.swift
//  Hitchman
//
//  Created by STC on 10/17/18.
//  Copyright © 2018 STC. All rights reserved.
//

import UIKit

class StyleGuide: NSObject {

    class func colorDefault()->UIColor{
        let regularColor = UIColor(red:0.0/255.0, green:192.0/255.0, blue:217.0/255.0, alpha:1.0)
        return regularColor
    }
    
    
    class func fontPoppinsRegularWithSize(size:CGFloat)->UIFont{
        return  UIFont(name: "Poppins-Regular", size: size)!
    }
    
    
    class func fontPoppinsSemiBoldWithSize(size:CGFloat)->UIFont{
        return  UIFont(name: "Poppins-SemiBold", size: size)!
    }
    
    
    class func fontPoppinsMediumWithSize(size:CGFloat)->UIFont{
        return  UIFont(name: "Poppins-Medium", size: size)!

    }
}
