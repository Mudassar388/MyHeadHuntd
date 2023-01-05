//
//  MessagesVC.swift
//  Rig
//
//  Created by Ale on 1/26/21.
//  Copyright © 2021 Ale. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import MessageKit
// dev created
class MessagesVC: UIViewController{
 
    //MARK:- Variables -
    var theData: [MyMessage] = []
    var userMessages: [GetUserChat] = []
    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle?
    var refresh: RefreshTime?
    
    var friendID = 0
    var friendName = ""
    var allIDs:Dictionary<String, AnyObject>.Keys?
    
    var userName: String?
    var userID: Int?
    var refreshTimeStarted: String? = ""
    
    var thatsIam : Bool = true
    //MARK:- IBOutlets -
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var imgSender: UIImageView!
    @IBOutlet weak var lblSender: UILabel!
    @IBOutlet weak var btnOptions: UIButton!
    
    
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var btnEmoji: UIButton!
    @IBOutlet weak var btnMic: UIButton!
    @IBOutlet weak var btnCamera: UIButton!
    @IBOutlet weak var btnGallery: UIButton!
    
    @IBOutlet weak var newMessage: UILabel!
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var lblContactName: UILabel!
    @IBOutlet weak var messageTextViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var messageTextViewHeightConstraint: NSLayoutConstraint!
    

    
    //MARK:- View Controller Life Cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatTableView.delegate = self
        chatTableView.dataSource = self
      
        
    }
    override func viewWillAppear(_ animated: Bool) {
        SharedModel.sharedInstance.setStatusBarColor()
        
        addObservers()
        setLayout()
//        getConverstaion()
        getUserChat()
//        getrefresh()
        //
        self.tableViewSettings()
        messageTextView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 30)
    }
    
    func getUserChat() {
        lblSender.text = userName
        MessageViewModel.shared.UserChat(id: userID ?? 0) { userChat in
            self.userMessages = userChat
            
               
            
            
            self.chatTableView.reloadData()
        }
    }
    
    func getrefresh() {
        MessageViewModel.shared.refreshTime { ref in
            self.refreshTimeStarted = ref?.refresh_time ?? ""
//            UserDefaults.standard.set(ref?.refresh_time, forKey: "refresh_time")
        }
    }
    
    func tableViewSettings(){
        self.chatTableView.rowHeight = UITableView.automaticDimension
        self.chatTableView.estimatedRowHeight = 140
        self.chatTableView.delegate = self
        self.chatTableView.dataSource = self
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK:- Custom Methods -
    private func setLayout(){
        messageTextView.delegate = self
        //lblContactName.text = friendName
        chatTableView.register(ChatCell.self, forCellReuseIdentifier: "ChatCell")
//        chatTableView.scrollToBottom()
    }
    
//    private func getDetails(){
//
//        for id in self.allIDs!{
//            let cId = id.components(separatedBy: "-")
//            if (Int(cId[0]) == self.friendID && Int(cId[1]) == (AppSingleton.shared.currentUser?.data?.id ?? 0)){
//                databaseHandle = ref?.child("chats").child("\(self.friendID)-\(AppSingleton.shared.currentUser?.data?.id ?? 0)").queryOrderedByKey().observe(.childAdded, with: { (snapshot) in
//                    if let dict = snapshot.value as? [String: AnyObject]
//                            {
//                                let textMessage = dict["body"] as? String ?? ""
//                                let senderId = dict["fromId"] as? String ?? ""
//                        if senderId == "\(self.friendID)"{
//                            self.theData.append(MyMessage(incoming: true, message: textMessage))
//                        }else{
//                            self.theData.append(MyMessage(incoming: false, message: textMessage))
//                        }
//                    }
//                    self.chatTableView.reloadData()
//                })
//                break
//            }else if (Int(cId[0]) == (AppSingleton.shared.currentUser?.data?.id ?? 0) && Int(cId[1]) == self.friendID){
//                databaseHandle = ref?.child("chats").child("\(AppSingleton.shared.currentUser?.data?.id ?? 0)-\(self.friendID)").queryOrderedByKey().observe(.childAdded, with: { (snapshot) in
//                    if let dict = snapshot.value as? [String: AnyObject]
//                            {
//                                let textMessage = dict["body"] as? String ?? ""
//                                let senderId = dict["fromId"] as? String ?? ""
//                        if senderId == "\(self.friendID)"{
//                            self.theData.append(MyMessage(incoming: true, message: textMessage))
//                        }else{
//                            self.theData.append(MyMessage(incoming: false, message: textMessage))
//                        }
//                    }
//                    self.chatTableView.reloadData()
//                })
//                break
//            } else {
//                databaseHandle = ref?.child("chats").child("\(AppSingleton.shared.currentUser?.data?.user?.id ?? 0)-\(self.friendID)").queryOrderedByKey().observe(.childAdded, with: { (snapshot) in
//                    if let dict = snapshot.value as? [String: AnyObject]
//                            {
//                                let textMessage = dict["body"] as? String ?? ""
//                                let senderId = dict["fromId"] as? String ?? ""
//                        if senderId == "\(self.friendID)"{
//                            self.theData.append(MyMessage(incoming: true, message: textMessage))
//                        }else{
//                            self.theData.append(MyMessage(incoming: false, message: textMessage))
//                        }
//                    }
//                    self.chatTableView.reloadData()
//                })
//                break
//            }
//        }
//    }
    
    private func getConverstaion(){
        ref = Database.database().reference()
        //reterive the posts and listen for changes
        databaseHandle = ref?.child("chats").observe(.value, with: { (snapshot) in
            let chat = snapshot.value as? [String: AnyObject] ?? [:]
            print("Chat: \(chat)")
            self.allIDs = chat.keys
            //self.getDetails()
        })
//        ref?.keepSynced(true)
    }
    
//    private func sendMessage(message: String , completion: @escaping (( _ message: [String:String] ,_ isFound: Bool) -> Void)){
//
//       // let messages = ["body": message, "fromId": "\(Singleton.shared.currentUser?.data?.id ?? 0)", "fromName": Singleton.shared.currentUser?.data?.firstName ?? "", "status":"1", "timestamp":"\(getCurrentTimeStamp())","toId":"\(self.friendID)", "toName": "\(self.friendName)"]
//        let messages = ["body": message, "fromId": "\(AppSingleton.shared.currentUser?.data?.id ?? 0)", "fromName": AppSingleton.shared.currentUser?.data?.firstName ?? "", "status":"1", "timestamp":"\(getCurrentTimeStamp())","toId":"3", "toName": "Muhammad"]
//        ref = Database.database().reference()
//
//        for id in self.allIDs!{
//            let cId = id.components(separatedBy: "-")
//            if (Int(cId[0]) == self.friendID && Int(cId[1]) == (AppSingleton.shared.currentUser?.data?.id ?? 0)){
//                ref?.child("chats").child("\(self.friendID)-\(AppSingleton.shared.currentUser?.data?.id ?? 0)").updateChildValues(["\(ref?.childByAutoId().key ?? "")": messages], withCompletionBlock: { (error, dbRef) in
//                    if error != nil{
//                        print("Unable to send message")
//                    }else{
//                        print("1 Successfully send message")
////                        self.theData.append(MyMessage(incoming: false, message: message))
////                        self.messageTextView.text = ""
////                        self.messageTextView.resignFirstResponder()
////                        messages.removeAll()
//                        completion(messages, true)
//                    }
//                })
//                break
//            }else if (Int(cId[0]) == (AppSingleton.shared.currentUser?.data?.id ?? 0) && Int(cId[1]) == 3){
//                ref?.child("chats").child("\(AppSingleton.shared.currentUser?.data?.id ?? 0)-\(3)").updateChildValues(["\(ref?.childByAutoId().key ?? "")": messages], withCompletionBlock: { (error, dbRef) in
//                    if error != nil{
//                        print("Unable to send message")
//                    }else{
//                        print("2 Successfully send message")
////                        self.theData.append(MyMessage(incoming: false, message: message))
////                        self.messageTextView.text = ""
////                        self.messageTextView.resignFirstResponder()
////                        messages.removeAll()
//                        completion(messages, true)
//                    }
//                })
//                break
//            }
//        }
////        completion(messages, false)
//    }
//
    func addObservers() {
        // keyboard observers
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillAppear(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            messageTextViewBottomConstraint.constant = keyboardSize.height
            self.view.layoutIfNeeded()
        }
    }

    @objc func keyboardWillHide(notification: Notification) {
        messageTextViewBottomConstraint.constant = 0
    }
    
    func getCurrentTimeStamp() -> String {
            return "\(Int(NSDate().timeIntervalSince1970))"
    }
    
    //MARK:- IBActions -
    
    @IBAction func btnActionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnActionSendMessage(_ sender: UIButton) {
        
//        guard let refresh = UserDefaults.standard.string(forKey: "refresh_time") else {return}
        
        let messageCount = userMessages.count
        
        if (messageTextView.text.isEmpty) && messageTextView.text == "" {
            let alert = UIAlertController(title: "Alert", message: "Please write something here", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            MessageViewModel.shared.saveChatToServer(rec_id: 1, message: messageTextView.text) {[weak self] saveChat in
                guard let self = self else {return}
                
                
                if messageCount == 0 {
                    
                }
                
//                if messageCount > 6 {
//                    self.getrefresh()
//                    for msgCount in userMessages {
//                        msgCount.sender
//                    }
//                }
                
                
                let premium = UserDefaults.standard.bool(forKey: "isPremium")
                if premium == true {
                    self.userMessages.append(contentsOf: saveChat)
                } else {
                    if messageCount > 6 {
                        let alert = UIAlertController(title: "Alert", message: "u need to become premium", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    } else {
                        self.userMessages.append(contentsOf: saveChat)
                        print("my chat is \(saveChat)")
                        self.chatTableView.reloadData()
                        self.chatTableView.scroll(to: .bottom, animated: true)
                        self.messageTextView.text = ""
                    }
                }
                

                if self.refreshTimeStarted != nil {
                    self.messageTextView.text = nil
                    self.userMessages.removeAll()
                    let alert = UIAlertController(title: "Alert", message: "Please wait for refresh time", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)

                } else {
                    print("count ??",messageCount)
                    if messageCount > 6 {
                        let alert = UIAlertController(title: "Alert", message: "u need to become premium", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    } else {
                        self.userMessages.append(contentsOf: saveChat)
                        print("my chat is \(saveChat)")
                        self.chatTableView.reloadData()
                        self.chatTableView.scroll(to: .bottom, animated: true)
                        self.messageTextView.text = ""
                    }
                }
                
    
//                if self.refreshTimeStarted != nil {
//                    self.messageTextView.text = nil
//                    self.userMessages.removeAll()
//                    let alert = UIAlertController(title: "Alert", message: "Please wait for refresh time", preferredStyle: UIAlertController.Style.alert)
//                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
//                    self.present(alert, animated: true, completion: nil)
//                } else {
//                    if messageCount <= 5 {
//                        for _ in self.userMessages {
//                            self.userMessages.append(contentsOf: saveChat)
//                        }
//                    }
//                }
                
                
//                print("my chat is \(saveChat)")
//                self.chatTableView.reloadData()
//                self.chatTableView.scroll(to: .bottom, animated: true)
//                self.messageTextView.text = ""
            }
        }
        
//        if !(messageTextView.text.isEmpty) && messageTextView.text != " "{
//            sendMessage(message: messageTextView.text) { (message, isFound) in
//
//                if isFound{
////                    self.theData.append(MyMessage(incoming: false, message: self.messageTextView.text))
//                    self.messageTextView.text = ""
//                    self.messageTextView.resignFirstResponder()
////                    messages.removeAll()
//                }
//
//                if !isFound {
//                    //otherwise create new thread for these two IDs
//                    self.ref?.child("chats").child("\(AppSingleton.shared.currentUser?.data?.id ?? 0)-\(self.friendID)").updateChildValues(["\(self.ref?.childByAutoId().key ?? "")": message], withCompletionBlock: { (error, dbRef) in
//                        if error != nil{
//                            print("Unable to send message")
//                        }else{
//                            print("3 Successfully send message")
//                            self.theData.append(MyMessage(incoming: false, message: self.messageTextView.text))
//                            self.messageTextView.text = ""
//                            self.messageTextView.resignFirstResponder()
//                        }
//                    })
//                }
//            }
//        }else{
//            print("Please enter some text to send")
//        }
    }
}

//MARK:- Textview delegate methods
extension MessagesVC: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Message..."{
            textView.text = ""
//            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty{
            textView.textColor = UIColor(red: 0.47, green: 0.47, blue: 0.47, alpha: 1.00)
            textView.text = "Message..."
        }
    }
    
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
//        let numberOfChars = newText.count
//        if numberOfChars > 40 && numberOfChars < 70{
//            messageTextViewHeightConstraint.constant = 70
//        }else if numberOfChars > 70 && numberOfChars < 100{
//            messageTextViewHeightConstraint.constant = 90
//        }
//        else if numberOfChars == 0{
//            messageTextViewHeightConstraint.constant = 40
//        }
//        return true
//    }
}

//MARK:- Tableview delegate methods
//extension MessagesVC: UITableViewDelegate, UITableViewDataSource{
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return theData.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
//        cell.setData(theData[indexPath.row])
//        cell.selectionStyle = .none
//        return cell
//    }
//}



extension MessagesVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return userMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{

        self.thatsIam = indexPath.row == 1 ? false : true
        let msgs = userMessages[indexPath.row]
        
        let formatter = DateFormatter()
        let currentDateTime = Date()
        let time = msgs.created_at ?? ""
        formatter.dateFormat = "HH:mm"
        formatter.string(from: currentDateTime)
        let someDateTime = formatter.date(from: time)
        
        if self.thatsIam {
            let cell = tableView.dequeueReusableCell(withIdentifier: "senderCell") as! SenderTableViewCell
            cell.senderMessageTextView.layer.cornerRadius = 8
            cell.senderMessageTextView.text = msgs.message ?? ""
            cell.sentTime.text = "Send at \(String(formatter.string(from: someDateTime ?? Date() )))"
            
//            cell.senderImageView.image = UIImage(named: "user")
           // cell.senderMessageTextView.text = "Thank you for understanding. I will be free at 2 pm, lets meet at cafeteria."
            //cell.sentTime.text = "Send at 02:30"
            return cell
        }else {
     
            let cell = tableView.dequeueReusableCell(withIdentifier: "receiverCell", for: indexPath) as! ReceiverTableViewCell

            cell.receiverMessageTextView.layer.cornerRadius = 8
            cell.receiverMessageTextView.text = msgs.message ?? ""
            cell.sentTime.text = "Send at \(String(formatter.string(from: someDateTime ?? Date() )))"
            
            return cell
        }
    }
    
}


extension UITableView {
  
  func scroll(to: Position, animated: Bool) {
    let sections = numberOfSections
    let rows = numberOfRows(inSection: numberOfSections - 1)
    switch to {
    case .top:
      if rows > 0 {
        let indexPath = IndexPath(row: 0, section: 0)
        self.scrollToRow(at: indexPath, at: .top, animated: animated)
      }
      break
    case .bottom:
      if rows > 0 {
        let indexPath = IndexPath(row: rows - 1, section: sections - 1)
        self.scrollToRow(at: indexPath, at: .bottom, animated: animated)
      }
      break
    }
  }
  
  enum Position {
    case top
    case bottom
  }
}
