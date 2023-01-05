//
//  Storyboard.swift
//  Rig
//
//  Created by Sajjad Malik on 27.12.21.
//  Copyright © 2021 Ale. All rights reserved.
//

import Foundation

// MARK: - Enum for Storyboard Reference
enum StoryboardReference: String {
    case Main
    case Home
    case Candidate
}

// MARK: - View Controller Reference
enum ViewControllerReference: String {
    
    // MARK: - Main
    /// Main Stroyboard contain the following views
    case OnboardingViewController
    
}

// MARK: - Navigation Reference
enum NavigationReference: String {
    
    // MARK: - Main
    /// Main Stroyboard contain the following navigation
    case Appnavigation
    case MyTabbarController
}

