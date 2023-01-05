//
//  RIGNavigationManager.swift
//  Rig
//
//  Created by Mac on 07/04/2022.
//  Copyright © 2022 Ale. All rights reserved.
//

import Foundation
import UIKit
class RIGNavigationManager : NSObject{

        static let sharedInstance = RIGNavigationManager()
        override init()
        {
            super.init()
        }
    func logout(){
        RIG.DataManager.userRIG = nil
        RIG.DataManager.headers?.accessToken = nil
        RIG.DataManager.companyDataRIG = nil
        RIG.DataManager.isUserLoggedIn = false
        RIG.DataManager.isCompanyLoggedIn = false
        RIG.DataManager.isUserPressed =  false
        RIG.DataManager.isCompanyPressed = false
        if #available(iOS 13, *) {
            if let scene = Constants.UIConnectedScenes.first {
                guard let windowScene = (scene as? UIWindowScene) else { return }
                let window: UIWindow = UIWindow(frame:  windowScene.coordinateSpace.bounds)
                Constants.APP_DELEGATE.window = window
                let Home = UIStoryboard(name: RIGStoryboards.MainStoryboard,
                                        bundle: nil).instantiateViewController(withIdentifier: "navToLogin") as! UINavigationController
                    window.windowScene = windowScene
                    window.rootViewController = Home
                    window.makeKeyAndVisible()



            }
        }


    }

    func NavigationTologin(){
        if #available(iOS 13, *) {
            if let scene = Constants.UIConnectedScenes.first {
                guard let windowScene = (scene as? UIWindowScene) else { return }
                let window: UIWindow = UIWindow(frame:  windowScene.coordinateSpace.bounds)
                Constants.APP_DELEGATE.window = window
                    let Home = UIStoryboard(name: RIGStoryboards.MainStoryboard,
                                            bundle: nil).instantiateViewController(withIdentifier: "navToLogin") as! UINavigationController
                    window.windowScene = windowScene
                    window.rootViewController = Home
                    window.makeKeyAndVisible()

            }
        }


    }


    func setUpFirstScreen() {
      //  Constants.designationsArr = []
        if #available(iOS 13, *) {
            if let scene = Constants.UIConnectedScenes.first {
                guard let windowScene = (scene as? UIWindowScene) else { return }
                let window: UIWindow = UIWindow(frame:  windowScene.coordinateSpace.bounds)
                Constants.APP_DELEGATE.window = window
                if RIG.DataManager.isUserLoggedIn ?? false  {
                    let Home = UIStoryboard(name: RIGStoryboards.HomeStoryboard,
                                            bundle: nil).instantiateViewController(withIdentifier: RIGViewControllers.MyTabbarController) as! UITabBarController
                    Home.selectedIndex = TabBarItems.Home.rawValue
                    Home.modalTransitionStyle = .flipHorizontal
                    window.windowScene = windowScene
                    window.rootViewController = Home
                    window.makeKeyAndVisible()

                }
                else if RIG.DataManager.isCompanyLoggedIn ?? false
                {
                    let Home = UIStoryboard(name: RIGStoryboards.CandidateStoryboard,
                                            bundle: nil).instantiateViewController(withIdentifier:RIGViewControllers.CompanyTabbarController) as! UITabBarController
                    Home.selectedIndex = TabBarItemsCompany.Home.rawValue
                    Home.modalTransitionStyle = .flipHorizontal
                    window.windowScene = windowScene
                    window.rootViewController = Home
                    window.makeKeyAndVisible()
                }
            }
        }else
        {
            if RIG.DataManager.isUserLoggedIn ?? false  {
                let Home = UIStoryboard(name: RIGStoryboards.HomeStoryboard,
                                        bundle: nil).instantiateViewController(withIdentifier: RIGViewControllers.MyTabbarController) as! UITabBarController
                Home.selectedIndex = TabBarItems.Home.rawValue
                Home.modalTransitionStyle = .flipHorizontal
                Constants.APP_DELEGATE.window?.rootViewController = Home
                Constants.APP_DELEGATE.window?.makeKeyAndVisible()
            }
            else if RIG.DataManager.isCompanyLoggedIn ?? false
            {
                let Home = UIStoryboard(name: RIGStoryboards.CandidateStoryboard,
                                        bundle: nil).instantiateViewController(withIdentifier: RIGViewControllers.CompanyTabbarController) as! UITabBarController
                Constants.APP_DELEGATE.window?.rootViewController = Home
                Constants.APP_DELEGATE.window?.makeKeyAndVisible()

            }

        }


    }

//    func logoutNavigation(){
//        if let scene = Constants.UIConnectedScenes.first {
//            guard let windowScene = (scene as? UIWindowScene) else { return }
//            let window: UIWindow = UIWindow(frame:  windowScene.coordinateSpace.bounds)
//            Constants.APP_DELEGATE.window = window
//                let OnboardingViewController = UIStoryboard(name: RIGStoryboards.MainStoryboard,
//                                                            bundle: nil).instantiateViewController(withIdentifier:RIGViewControllers.OnboardingViewController) as! OnboardingViewController
//                window.windowScene = windowScene
//                window.rootViewController = OnboardingViewController
//                window.makeKeyAndVisible()
//
//        }
//
//    }


    func navigateToProfileViewController(viewController : UIViewController) -> Void
    {
    let vc = UIStoryboard(name: RIGStoryboards.HomeStoryboard, bundle: nil).instantiateViewController(identifier: RIGViewControllers.ProfileViewController) as! ProfileVC
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    func navigateToCompanyProfileViewController(viewController : UIViewController) -> Void
    {
    let vc = UIStoryboard(name: RIGStoryboards.CandidateStoryboard, bundle: nil).instantiateViewController(identifier: RIGViewControllers.JobDashboardVC) as! JobDashboardVC
        viewController.navigationController?.pushViewController(vc, animated: true)
    }

    func navigateToAboutUSViewController(pagetitle:String?,viewController : UIViewController) -> Void
    {
    let vc = UIStoryboard(name: RIGStoryboards.HomeStoryboard, bundle: nil).instantiateViewController(identifier: RIGViewControllers.AboutUsViewController) as! AboutUsViewController
        vc.pagetitle = pagetitle
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
    func navigateToViewProfilmageViewController(viewController : UIViewController) -> Void
    {
    let vc = UIStoryboard(name: RIGStoryboards.HomeStoryboard, bundle: nil).instantiateViewController(identifier: RIGViewControllers.ViewProfileViewController) as!  ViewProfileViewController
        viewController.navigationController?.pushViewController(vc, animated: true)
    }

    func navigateToFavouriteJobsViewController(viewController : UIViewController) -> Void
    {
    let vc = UIStoryboard(name: RIGStoryboards.HomeStoryboard, bundle: nil).instantiateViewController(identifier: RIGViewControllers.FavouriteJobsViewController) as! FavouriteJobsViewController
        viewController.navigationController?.pushViewController(vc, animated: true)
    }

    func navigateToMembershipPlanViewController(viewController : UIViewController) -> Void
    {
    let vc = UIStoryboard(name: RIGStoryboards.CandidateStoryboard, bundle: nil).instantiateViewController(identifier: RIGViewControllers.MembershipPlanViewController) as! MembershipPlanViewController
        viewController.navigationController?.pushViewController(vc, animated: true)
    }

    func navigateToJobDetailsViewController(jobID:Int,viewController : UIViewController ) -> Void
    {
        let vc = UIStoryboard(name: RIGStoryboards.HomeStoryboard, bundle: nil).instantiateViewController(identifier: RIGViewControllers.JobDetailsVC) as! JobDetailsVC
        vc.jobIDForDetails = jobID
        viewController.navigationController?.pushViewController(vc, animated: true)

    }
    func navigateToPostJobViewController(viewController : UIViewController ) -> Void
    {
        let vc = UIStoryboard(name: RIGStoryboards.CandidateStoryboard, bundle: nil).instantiateViewController(identifier: RIGViewControllers.PostJobVC) as! PostJobVC
        viewController.navigationController?.pushViewController(vc, animated: true)

    }
    func navigateToPublicProfileViewController(Pid:Int,viewController : UIViewController ) -> Void
    {
        let vc = UIStoryboard(name: RIGStoryboards.HomeStoryboard, bundle: nil).instantiateViewController(identifier: RIGViewControllers.PublicProfileViewController) as!  PublicProfileViewController
        vc.profileId = Pid
       // vc.datafor = socializerViewModel
//        vc.userCoverIV = 
        
        viewController.navigationController?.pushViewController(vc, animated: true)

    }
    func PopUpshow(in viewController: UIViewController,notificationDelegate: ProfilePopUp?){

        let alertViewController = PopUpProfile(frame:  viewController.view.bounds)
        viewController.view.addSubview(alertViewController)
        viewController.tabBarController?.tabBar.isUserInteractionEnabled = false
        viewController.navigationController?.navigationBar.isHidden = true
        viewController.definesPresentationContext = true
        alertViewController.delegate = notificationDelegate

    }
    func cellPopUpshow(in viewController: UIViewController,notificationDelegate: MYNetworkCellPopUp?){

        let alertViewController = MyNetworkPopUp(frame: CGRect(x: 100, y: 100, width: 100, height: 74))
        viewController.view.addSubview(alertViewController)
        viewController.tabBarController?.tabBar.isUserInteractionEnabled = false
        viewController.navigationController?.navigationBar.isHidden = true
        viewController.definesPresentationContext = true
        viewController.dismiss(animated: true)
        alertViewController.delegate = notificationDelegate

    }

//    func navigateToClinicsMapScreen(viewController : UIViewController) -> Void
//    {
//        let vc = UIStoryboard(name: TGStoryboards.MainStoryboard, bundle: nil).instantiateViewController(withIdentifier: ViewControllers.ClinicsMapViewController) as! ClinicsMapViewController
//        viewController.navigationController?.pushViewController(vc, animated: true)
//    }
//    func showHomePopupScreen(viewController : UIViewController, homePopup: HomePopup?) -> Void
//    {
//        let vc = UIStoryboard(name: TGStoryboards.HomeStoryboard, bundle: nil).instantiateViewController(withIdentifier: ViewControllers.HomePopupViewController) as! HomePopupViewController
//        vc.delegate = (viewController as! HomePopupViewControllerDelegate)
//        let model : HomePopupViewModel = HomePopupViewModel.init(homePopup: homePopup)
//        vc.viewModel = model
//
//        let cont = UINavigationController.init(rootViewController: vc)
//        cont.navigationBar.tintColor = UIColor.black
//        viewController.definesPresentationContext = true
//        cont.view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
//        cont.modalPresentationStyle = .overCurrentContext
//        vc.view.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
//        vc.modalPresentationStyle = .overCurrentContext
//        viewController.tabBarController?.present(cont, animated: true, completion: nil)
//    }
}

