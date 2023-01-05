//
//  OnboardingViewController.swift
//  Rig
//
//  Created by Sajjad Malik on 27.12.21.
//  Copyright © 2021 Ale. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var onboardImageView: UIImageView!
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    let arrTitle = ["Meet Professionals", "Authentic Community", "Find Jobs"]
    let arrFooter = ["Meet and hire professionals around you", "Authenitic and verified community", "Find and post jobs"]
    let arrImages = ["onboarding1", "onboarding2", "onboarding3"]
    var index = 0
    var timer: Timer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: OnboardingCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: OnboardingCollectionViewCell.identifier)
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        //collectionView.allowsMultipleSelection = false
        // Do any additional setup after loading the view.
        
        updateView()
        
        
        //pageControl.currentPage = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if  RIG.DataManager.headers?.accessToken?.isNotEmpty() ?? false
        {
            if RIG.DataManager.isUserLoggedIn ?? false
            {
                RIG.NavigationManager.setUpFirstScreen()
                
            }else if RIG.DataManager.isCompanyLoggedIn ?? false
            {
                RIG.NavigationManager.setUpFirstScreen()
            }
            
            
        }else{
            
            RIG.DataManager.isUserLoggedIn = false
            RIG.DataManager.isCompanyLoggedIn = false
            RIG.DataManager.userRIG = nil
            RIG.DataManager.companyDataRIG = nil
            RIG.DataManager.headers?.accessToken = nil
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Check App version
        //self.checkSession()
        self.pageControl.numberOfPages = 3
        pageControl.currentPage = index
        setTimer()

    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer?.invalidate()
    }
    
    func setTimer() {
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.autoScroll), userInfo: nil, repeats: true)
    }
 
    @objc func autoScroll() {
        if index == arrTitle.count - 1 {
            index = 0
            pageControl.currentPage = index
            
        } else {
            index += 1
            pageControl.currentPage = index
        }
    
           self.collectionView.scrollToItem(at: IndexPath(row: self.index , section: 0), at: .centeredHorizontally, animated: true)
    }
    
    func updateView(){
        
        btnStart.layer.shadowColor = UIColor.black.cgColor
        btnStart.layer.shadowOffset = CGSize(width:0.0, height:2.0);
        btnStart.layer.shadowOpacity = 0.25;
        btnStart.layer.masksToBounds = false;
        
        //        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
        //            self.pageControl.currentPage = 1
        //            // self.lblHeading.text = "Authentic Community"
        //            // self.lblDetail.text = "Authenitic and verified community"
        //            // self.onboardImageView.contentMode  = .scaleAspectFit
        //            /// self.onboardImageView.image = UIImage(named: "onboarding2")
        //
        //            DispatchQueue.main.asyncAfter(deadline: .now()+3) {
        //                self.pageControl.currentPage = 2
        //                // self.lblHeading.text = "Find Jobs"
        //                //self.lblDetail.text = "Find and post jobs"
        //                //self.onboardImageView.contentMode  = .scaleAspectFit
        //                // self.onboardImageView.image = UIImage(named: "onboarding3")
        //
        //
        //            }
        //        }
    }
    
    @IBAction func btnStartTapped(_ sender: Any) {
        RIG.NavigationManager.NavigationTologin()
    }
    
    
}
extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        arrTitle.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        cell.lblTitle.text = arrTitle[indexPath.row]
        cell.lblFooter.text = arrFooter[indexPath.row]
        cell.img.image = UIImage (named: arrImages[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //return CGSize(width: 50, height: 50)
        // return CGSize(width: self.view.frame.width+100, height:(self.view.frame.height))
        // Set your item size here
        
        let itemWidth = collectionView.frame.width - 10
        let itemHeight = collectionView.frame.height
        return CGSize(width: itemWidth, height: itemHeight)
        // return CGSize(width: self.view.frame.width - 10, height: self.view.frame.height)
    }
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            pageControl.currentPage = indexPath.row
//            collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
//               collectionView.reloadItems(at: [index])
        }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //pageControl.currentPage = indexPath.item
        
//        collectionView.scrollToItem(at: IndexPath(row: 0, section: pageControl.currentPage), at: .centeredHorizontally, animated: true)

    }
}
