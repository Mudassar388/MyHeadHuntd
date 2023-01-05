//
//  MyNetworkViewController.swift
//  Rig
//
//  Created by Sajjad Malik on 13.01.22.
//  Copyright © 2022 Ale. All rights reserved.
//

import UIKit
import iOSDropDown
import Toast_Swift


class MyNetworkViewController: UIViewController, MYNetworkCellPopUp, MyNetworkCellDelegate  {
    
    // MARK: - Outlet
    
    @IBOutlet weak var lblNetwork: UILabel!
    @IBOutlet weak var lblConnection: UILabel!
    @IBOutlet weak var tfChooseOption: DropDown!
    @IBOutlet weak var tfSearch: DesignableUITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyImage: UIImageView!
    @IBOutlet weak var lblNoConnection: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var imgPopUp: UIImageView!
    @IBOutlet weak var lblPopUp: UILabel!
    @IBOutlet weak var buttonOutlet: UIButton!
    
    var friendsList: GetMyFriend?
    var friendsArray: [Friends] = []
    var searchedArray = [Friends]()
    var isSearching:Bool = false
    var selectedIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        imgPopUp.isHidden = true
        lblNoConnection.isHidden = true
        buttonOutlet.setTitle("", for: .normal)
        updateView()
        FriendsViewModel.shared.friendData(sortOrder: 0, lastID: 0, text: "") {[weak self] model in
            guard let self = self else {return}
            self.AddedByUser(model: model)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    // MARK: - Action
    @IBAction func btnPopupAction(_ sender: Any) {
        
        RIG.NavigationManager.cellPopUpshow(in: self, notificationDelegate: self)
        //let view = MyNetworkPopUp()
        //self.view.showToast(view, duration: .infinity, position: .center, completion: {didTap in
       // })
    }
    
    @IBAction func butonAction(_ sender: Any) {
        guard let text = tfSearch.text else {return}
        
        if text.isEmpty {
            let alert = UIAlertController(title: "Alert", message: "Please Enter Name", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            FriendsViewModel.shared.friendData(sortOrder: 0, lastID: 0, text: text) {[weak self] model in
                guard let self = self else {return}
                self.friendsList = model
                self.friendsArray = self.friendsList?.friends ?? []
                if self.friendsArray.count == 0 {
                    self.imgPopUp.isHidden = false
                    self.lblNoConnection.isHidden = false
                }
                self.imgPopUp.isHidden = true
                self.lblNoConnection.isHidden = true
                self.tableView.reloadData()
                
            }
        }
    }
    
    
    @IBAction func backButtonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: - Custom Function
    
    //    func getFriendsResponse () {
    //        FriendsViewModel.shared.friendData(text: self.text) { check in
    //            self.friendsList = check
    //            self.friendsArray = self.friendsList?.friends ?? []
    //            self.tableView.reloadData()
    //        }
    //    }
    @objc func buttonTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    
}

extension MyNetworkViewController:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let array = searchedArray.count != 0 ? searchedArray.count : friendsArray.count
        if searchedArray.count == 0 {
            return friendsArray.count
        }
        return array
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyNetworkCell") as! MyNetworkCell
        //cell.cellDelegate = self
        //cell.btnOptions.tag = indexPath.row
        //        //cell.btnPopUpAction(didPressButton(0) as! UIButton)
        //        cell.btnOptions.addTarget(self, action: #selector(didPressButton), for: .touchUpInside)
        if searchedArray.count != 0 {
            let searchFriends = searchedArray[indexPath.row]
            cell.lblName.text = searchFriends.first_name ?? ""
            cell.lblDesignation.text = searchFriends.designation?.title ?? ""
            cell.lblTime.text = searchFriends.created_at ?? ""
            if let url = URL(string: searchFriends.profile_image ?? "") {
                UIImage.loadFrom(url: url) { image in
                    cell.imgUser.image = image
                    
                }
            }
        }else{
            let frdndz = friendsArray[indexPath.row]
            cell.lblName.text = frdndz.first_name ?? ""
            cell.lblDesignation.text = frdndz.designation?.title ?? ""
            cell.lblTime.text = frdndz.created_at ?? ""
            if let url = URL(string: frdndz.profile_image ?? "") {
                UIImage.loadFrom(url: url) { image in
                    cell.imgUser.image = image
                }
            }
        }
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
    }
    func didPressButton(_ tag: Int) {
        print("I have pressed a button with a tag: \(tag)")
    }
    
    
    func ButtonTapped(tag: Int) {
        if tag == 0 {
            let storyboard = UIStoryboard(name: "Home", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "MessagesVC")
            self.present(vc, animated: true)
            // self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let storyboard = UIStoryboard(name: "Home", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "MessagesVC")
            self.present(vc, animated: true)
        }
    }
    
    func updateView() {
        tfChooseOption.text = "Recently added"
        tfChooseOption.paddingLeftCustom = 5
        tfChooseOption.selectedIndex = 0
        tfChooseOption.checkMarkEnabled = false
        tfChooseOption.isSearchEnable = false
        tfChooseOption.arrowSize = 15
        tfChooseOption.arrowColor = .darkGray
        tfChooseOption.selectedRowColor = .lightGray
        tfChooseOption.layer.borderWidth = 1
        tfChooseOption.layer.borderColor = UIColor.lightGray.cgColor
        tfChooseOption.layer.cornerRadius = 5
        

        
        tfChooseOption.optionArray = ["Recently added", "First Name", "Last Name"]
        tfChooseOption.didSelect{(_ , index ,_) in
            self.tfChooseOption.resignFirstResponder()
            self.tfChooseOption.selectedIndex = index
            if index == 0 {
                print("recently added")
                FriendsViewModel.shared.friendData(sortOrder: 0, lastID: 0, text: "") {[weak self] model in
                    guard let self = self else {return}
                    self.AddedByUser(model: model)
                }
                
            } else if index == 1 {
                print("first Name")
                FriendsViewModel.shared.friendData(sortOrder: 4, lastID: 0, text: "") {[weak self] model in
                    guard let self = self else {return}
                    self.AddedByUser(model: model)
                }
                
            } else {
                print("last Name")
                FriendsViewModel.shared.friendData(sortOrder: 5, lastID: 0, text: "") {[weak self] model in
                    guard let self = self else {return}
                    self.AddedByUser(model: model)
                }
            }
        }
    }
    
    func AddedByUser(model: GetMyFriend?) {
        
        self.friendsList = model
        self.friendsArray = self.friendsList?.friends ?? []
        if self.friendsArray.count == 0 {
            self.imgPopUp.isHidden = false
            self.lblNoConnection.isHidden = false
            
        }
        self.imgPopUp.isHidden = true
        self.lblNoConnection.isHidden = true
        self.tableView.reloadData()
    }
}
extension MyNetworkViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        if let text = textField.text {
            searchedArray = friendsArray.filter({($0.first_name!.lowercased().contains(text.lowercased()))})
            print (searchedArray)
            tableView.reloadData()
        }
        return true
    }
}
