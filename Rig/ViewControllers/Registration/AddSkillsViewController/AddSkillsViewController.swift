//
//  AddSkillsViewController.swift
//  Rig
//
//  Created by Sajjad Malik on 09.01.22.
//  Copyright © 2022 Ale. All rights reserved.
//

import UIKit
import JGProgressHUD
import iOSDropDown
import MessageKit

class AddSkillsViewController: UIViewController {
    
    @IBOutlet weak var addSkillsView: UIView!
    @IBOutlet weak var nextBtnView: UIView!
    @IBOutlet weak var skillsView: UIView!
    @IBOutlet weak var skillTFView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var skillTF: DropDown!
    var registrationViewModel = RegistrationViewModel()
    var skillArray: [String] = []
    var secondskill: [String] = []
    var skillIntArray = [Int]()
    var viewmodel = DesignationData()
    var indexForCell = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = CenterAlignedCollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 200, height: 30)
        self.collectionView.collectionViewLayout = layout
       // collectionView.collectionViewLayout = CenterAlignedCollectionViewFlowLayout()
       // collectionView.cornerRadius = 10
        
     updateView()
//        prepare(is: true, With: collectionView)
        updateDropdown()
//        if let flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//            flowLayout.estimatedItemSize = CGSize(width: 1, height: 30)
//            collectionView.collectionViewLayout = CenterAlignedCollectionViewFlowLayout()
//        }
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        layout.minimumInteritemSpacing = -10
//        layout.minimumLineSpacing = 5
//        layout.estimatedItemSize = CGSize(width: 1, height: 1)
//        self.collectionView.collectionViewLayout = layout
//        if let flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//            flowLayout.estimatedItemSize = CGSize(width: 50, height: 30)
//        }
    }
    
    func updateDropdown() {
        
        var titleArray: [String] = []
        for i in Constants.skills {
            let title = i.title ?? ""
            titleArray.append(title)
        }
        self.skillTF.text = ".Net Developer"
        self.skillTF.optionArray = titleArray
        skillTF.checkMarkEnabled = false
        skillTF.isSearchEnable = true
        skillTF.arrowSize = 15
        skillTF.arrowColor = .darkGray
        skillTF.listHeight = 250
        skillTF.selectedRowColor = .lightGray
    }
      
    
    // MARK: - Action
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func nextBtnTapped(_ sender: UIButton) {
        sendUserSkillAPI() {[weak self] in
            self?.navigate()
            }
        }
    
    func navigate() {
        let home : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
           let homeVc = home.instantiateViewController(withIdentifier: "HomeVC") as? HomeVC
        self.navigationController?.pushViewController(homeVc!, animated: true)
           let popVc = home.instantiateViewController(withIdentifier: "PopUpViewController") as? PopUpViewController
       DispatchQueue.main.asyncAfter(deadline: .now() + 0.8){
           popVc?.view.backgroundColor = .black.withAlphaComponent(0.3)
           self.present(popVc!, animated: true)
       }
    }
      
    func sendUserSkillAPI(completion: @escaping () -> Void ){
        if RIG.NetworkManager.isNetworkReachable(viewController: self)
        {
            skillIntArray = [213,913,532]

            RIG.UIManager.showCustomActivityIndicator(controller: self.tabBarController, withMessage: "")
            registrationViewModel.sendUserSkillsAPI(userSkillArray: skillIntArray) { (response) in
                RIG.UIManager.hideCustomActivityIndicator(controller: self)
                if response?.status == APIStatus.Success.rawValue
                {
                    RIG.UIManager.showAlert(title: RIGAlerts.RIG, message:response?.message, okButton: true, viewController: self) { _ in
                    RIG.DataManager.isCompanyLoggedIn = false
                    RIG.DataManager.isUserLoggedIn = true
                   // RIG.NavigationManager.setUpFirstScreen()
                        completion()
                    }


                }else{
                    RIG.UIManager.showAlert(title: RIGAlerts.RIG, message:response?.message, okButton: true, viewController: self) { _ in }
                }
            } errorMessage: { message in
                RIG.UIManager.hideCustomActivityIndicator(controller: self)
                print (message ?? "")

                RIG.UIManager.showAlert(title: RIGAlerts.RIG, message:message, okButton: true, viewController: self) { _ in }
            }


        }

    }
    
    @IBAction func addSkillTapped(_ sender: UIButton) {
        
      // sendUserSkillAPI()
//        Repository.signUpEmployer(email: emailTF.text ?? "", password: passwordTF.text ?? "", country: countryTF.text ?? "", designation: DesignationTF.text ?? "") { (status, data, message) in
//            hud.dismiss()
//            if status{
//                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "UploadResumeViewController") as! UploadResumeViewController
//                self.navigationController?.pushViewController(vc, animated: true)
//                Singleton.shared.loginTocken = data?.data?.login_token ?? ""
//                print("data:\(data?.data?.first_name ?? "")")
//            }else{
//                print("could not register")
//            }
//        }
        
        
        if let skill = skillTF.text {
            if skillArray.contains(where: {$0 == "\(skill)"}) {
                let newArray = skillArray.filter({$0 != "\(skill)"})
                self.skillArray = newArray
                alert()
            } else {
            skillArray.append(skill)
                collectionView.reloadData()
                print(skillArray)
                skillTF.text = nil
            }
            
            
        }
            
        
    }
    func alert() {
        let alert = UIAlertController(title: "Alert", message: "Skill Already Exist", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    // MARK: - Custom Function
    func updateView() {
        addSkillsView.addRadius(10)
        addSkillsView.addshadowColor()
        nextBtnView.addRadius(25)
        nextBtnView.addshadowColor()
        skillsView.addRadius(10)
        skillsView.addshadowColor()
        skillTFView.addshadowColor()
        skillTFView.addRadius(15)
    
    }
    
    private func prepare(is hotizontal: Bool, With collectionView: UICollectionView) {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.clearBackground()
        collectionView.updateFLow(2, 2, true)
    }
    
}

extension AddSkillsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
     
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return skillArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.register(UINib(nibName: SkillsCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: SkillsCollectionViewCell.identifier)
        
        // Cell
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SkillsCollectionViewCell.identifier, for: indexPath) as? SkillsCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.skillsLabel.text = skillArray[indexPath.row]
        cell.cornerRadius = 15
        cell.completion = {
            self.skillArray.remove(at: indexPath.row)
            
            self.collectionView.reloadData()
            return
        }
        return cell
        
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        //return skillArray[indexPath.row].size(withAttributes: nil)
//    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        indexForCell = indexPath.row
    }
}
