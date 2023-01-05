//
//  TechSocialProducts.swift
//  Rig
//
//  Created by Muhammad Asar on 2022-07-20.
//  Copyright © 2022 Ale. All rights reserved.
//

import Foundation

public struct TechSocialProducts {
  
  public static let productID = "com.eliteapps.techsocial.socialite"
  public static let productID1 = "com.eliteapps.techsocial.socialRecruiter1"
  private static let productIdentifiers: Set<ProductIdentifier> = [TechSocialProducts.productID, TechSocialProducts.productID1]
  public static let store = IAPHelper(productIds: TechSocialProducts.productIdentifiers)
}

func resourceNameForProductIdentifier(_ productIdentifier: String) -> String? {
  return productIdentifier.components(separatedBy: ".").last
}





//enum ProductIDs {
//    static let productID1 = "com.eliteapps.techsocial.socialRecruiter1"
//    static let productID = "com.eliteapps.techsocial.socialite"
//}
//
//
//public struct TechSocialProducts {
//
//
//  private static let productIdentifiers: Set<ProductIdentifier> = [ProductIDs.productID]
//  public static let store = IAPHelper(productIds: TechSocialProducts.productIdentifiers)
//}
//
//func resourceNameForProductIdentifier(_ productIdentifier: String) -> String? {
//  return productIdentifier.components(separatedBy: ".").last
//}
