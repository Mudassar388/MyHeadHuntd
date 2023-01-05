//
//  UploadResumeViewController.swift
//  Rig
//
//  Created by Sajjad Malik on 09.01.22.
//  Copyright © 2022 Ale. All rights reserved.
//

import UIKit
import MobileCoreServices
import Alamofire
import Foundation
import UIKit
import SwiftyJSON
import SystemConfiguration

class UploadResumeViewController: UIViewController {
    
    @IBOutlet weak var nextBtnView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var lblFileSize: UILabel!
    
    var registrationViewModel = RegistrationViewModel()
    var pdfData = Data()
    var isUploaded:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateView()
        //        NotificationCenter.default.addObserver(self, selector: #selector(handleProgress), name: .downloadProgress, object: nil)
    }
    
    
    // MARK: - Action
    @IBAction func backBtnTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func uploadResumeTapped(_ sender: UIButton) {
        attachDocument() {[weak self] in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self?.progressView.setProgress(1, animated: true)
                self?.showAlert(title: RIGAlerts.RIG, message: "Resume uploaded Successfully")
            }
        }
    }
    
    @IBAction func nextBtnTapped(_ sender: UIButton) {
        if isUploaded {
            let vc = UIStoryboard(name: RIGStoryboards.MainStoryboard, bundle: nil).instantiateViewController(identifier: RIGViewControllers.AddSkillsViewController) as! AddSkillsViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            RIG.UIManager.showAlert(title: RIGAlerts.RIG, message:"Please Upload File First", okButton: true, viewController: self) { _ in }
        }
    }
    
    // MARK: - Custom Function
    
    @objc func handleProgress(notification: NSNotification) {
        let userinfo = notification.userInfo
        if let progress = userinfo?["progress"] as? Double {
            print("uploading Progress: \(progress)")
            if progress == 1 {
                self.showAlert(title: RIGAlerts.RIG, message: "Resume uploaded Successfully")
            }
            self.progressView.setProgress(Float(progress), animated: true)
        }
    }
    
    func updateView() {
        progressView.setProgress(0, animated: true)
        mainView.addRadius(10)
        nextBtnView.addRadius(25)
        mainView.addshadowColor()
        nextBtnView.addshadowColor()
    }
    
    private func attachDocument(completion: @escaping () -> Void) {
        let types = [kUTTypePDF, kUTTypeText, kUTTypeRTF, kUTTypeSpreadsheet]
        let importMenu = UIDocumentPickerViewController(documentTypes: types as [String], in: .import)
        
        if #available(iOS 11.0, *) {
            importMenu.allowsMultipleSelection = true
        }
        
        importMenu.delegate = self
        importMenu.modalPresentationStyle = .formSheet
        completion()
        present(importMenu, animated: true)
    }
    
    func uploadPdf(data: Data) {
        
        var semaphore = DispatchSemaphore (value: 0)
        
        let parameters = [
            [
                "key": "type",
                "value": "CV",
                "type": "text"
            ],
            [
                "key": "doc",
                "src": data,
                "type": "file"
            ]] as [[String : Any]]
        
        let boundary = "Boundary-\(UUID().uuidString)"
        var body = ""
        var error: Error? = nil
        for param in parameters {
            if param["disabled"] == nil {
                let paramName = param["key"]!
                body += "--\(boundary)\r\n"
                body += "Content-Disposition:form-data; name=\"\(paramName)\""
                if param["contentType"] != nil {
                    body += "\r\nContent-Type: \(param["contentType"] as! String)"
                }
                let paramType = param["type"] as! String
                if paramType == "text" {
                    let paramValue = param["value"] as! String
                    body += "\r\n\r\n\(paramValue)\r\n"
                } else {
                    let fileContent = String(decoding: data, as: UTF8.self)
                    body += "; filename=\"\("file.pdf")\"\r\n"
                    + "Content-Type: \"content-type header\"\r\n\r\n\(fileContent)\r\n"
                }
            }
        }
        body += "--\(boundary)--\r\n";
        let postData = body.data(using: .utf8)
        guard let loginToken =  UserDefaults.standard.string(forKey: "token") else { return }
        
        var request = URLRequest(url: URL(string: "http://techsocialserver.space/api/upload/doc")!,timeoutInterval: Double.infinity)
        request.addValue("bVXR6UoK6eI3pN5ZXvWyN3ezGCB9m0fO", forHTTPHeaderField: "api-key")
        request.addValue("Bearer \(loginToken)", forHTTPHeaderField: "Authorization")
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "POST"
        request.httpBody = postData
        
        let task = URLSession.shared.dataTask(with: request) { dataResponose, response, error in
            guard let dataRes = dataResponose else {
                // show Alert
                return
            }
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                RIG.UIManager.showAlert(title: RIGAlerts.RIG,message: "File uploaded successfully", okButton: true, viewController: self) { _ in
                    self.isUploaded =  true
                    
                }
            } else {
                let dictionary = try? JSONSerialization.jsonObject(with: dataRes, options: .allowFragments) as? [String: Any]
                let message = dictionary?["message"] as! String
                //show alert
                RIG.UIManager.showAlert(title: RIGAlerts.RIG, message: message, okButton: true, viewController: self) { _ in }
            }
            
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
    }
    
    
    //    func pdfUploadAPI(dataUrl: URL){
    //        if RIG.NetworkManager.isNetworkReachable(viewController: self)
    //        {
    //            RIG.UIManager.showCustomActivityIndicator(controller: self.tabBarController, withMessage: "")
    //            guard let data = try? Data(contentsOf: dataUrl) else {return}
    //            var params = PDFUplaodParams()
    //            params.DocTitle = "CV"
    //            params.Doc = data
    //            registrationViewModel.pdfUplaodAPI(PDFUplaodParams: params, Docdata:data, filename: dataUrl.lastPathComponent)  { (response) in
    //                RIG.UIManager.hideCustomActivityIndicator(controller: self)
    //                if response?.status == APIStatus.Success.rawValue
    //                {
    //                    RIG.UIManager.showAlert(title: RIGAlerts.RIG,message:response?.message, okButton: true, viewController: self) { _ in
    //
    //                        self.isUploaded =  true
    //                        let home : UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
    //                        DispatchQueue.main.async { DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
    //                            let homeVc = home.instantiateViewController(withIdentifier: "HomeVC") as? HomeVC
    //                            self.navigationController?.pushViewController(homeVc!, animated: true)
    //                            let popVc = home.instantiateViewController(withIdentifier: "PopUpViewController") as? PopUpViewController
    ////                            sleep(4)
    //                            self.present(popVc!, animated: true)
    //                          }
    //                        }
    //                    }
    //
    //                }else{
    //                    RIG.UIManager.showAlert(title: RIGAlerts.RIG, message:response?.message, okButton: true, viewController: self) { _ in }
    //                }
    //            } errorMessage: { message in
    //                RIG.UIManager.hideCustomActivityIndicator(controller: self)
    //                print (message ?? "")
    //
    //                RIG.UIManager.showAlert(title: RIGAlerts.RIG, message:message, okButton: true, viewController: self) { _ in }
    //            }
    //
    //
    //        }
    //
    //    }
    ///
    
    
    func Doc(docData: Data, parameters: [String : Any], fileName: String){
        let headers = APIManagerBase.sharedInstance.getUserMultiPartHeader()
        //        AF.uplo
        AF.upload(multipartFormData: { multipartFormData in
            
            multipartFormData.append(docData, withName: "file", fileName: fileName, mimeType:"application/pdf")
            
            
            
            multipartFormData.append(Data("one".utf8), withName: "one")
            multipartFormData.append(Data("two".utf8), withName: "two")
        }, to: "http://techsocialserver.space/api/upload/doc", headers: headers)
        .responseJSON { response in
            debugPrint(response)
        }
    }
    
    ///
    
}

extension UploadResumeViewController: UIDocumentPickerDelegate, UINavigationControllerDelegate {
    //    internal func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
    //        pdfData = NSData(contentsOf: (urls.first ?? URL(fileURLWithPath: "")) as URL) as! Data
    //        self.pdfUploadAPI()
    //       // API.uploadDocument(data! as Data, filename: , url: "upload/doc")
    //        print(urls)
    //    }
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        
        guard let myURL = urls.first else {
            return
        }
        
        guard let correctUrl = URL(string: myURL.description.replacingOccurrences(of: "///", with: "/", options: [])) else {return}
        
        print("import result : \(correctUrl)")
        let data = NSData(contentsOf: correctUrl)
        do {
            let resources = try correctUrl.resourceValues(forKeys:[.fileSizeKey])
            let fileSize = resources.fileSize!
            self.lblFileSize.text = "\(fileSize/1024) Kb"
            
            print ("\(fileSize)")
            //            self.pdfUploadAPI(dataUrl: correctUrl)
            self.uploadPdf(data: data as! Data)
            
            //            self.Doc(url: strUrl, docData: try Data(contentsOf: myURL), parameters: ["club_file": "file" as AnyObject], fileName: myURL.lastPathComponent, token: token)
            //            self.Doc(docData: try Data(contentsOf: myURL), parameters: ["club_file": "file" as AnyObject], fileName: myURL.lastPathComponent)
            //            self.titleLable.text = myURL.lastPathComponent
            
            //            uploadActionDocument(documentURLs: myURL, pdfName: myURL.lastPathComponent)
        } catch {
            print(error)
        }
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

extension UINavigationController {
    func popToViewController(ofClass: AnyClass, animated: Bool = true) {
        if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
            popToViewController(vc, animated: animated)
        }
    }
}
