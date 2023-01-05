//
//  API.swift
//  MyResumeCloud
//
//  Created by Ale on 8/21/20.
//  Copyright © 2020 M.Ali Zafar. All rights reserved.
//

import Alamofire
import Foundation
import UIKit
import SwiftyJSON
import SystemConfiguration
import MobileCoreServices

public enum HTTPMethods: String {
    case options = "OPTIONS"
    case get = "GET"
    case head = "HEAD"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
    case trace = "TRACE"
    case connect = "CONNECT"
}

struct File {
    var data: Data?
    var url: URL?
    var name: String?
}
let baseURL = "http://techsocialserver.space/api/"


class API {
    //    let baseURL = ""
    let header: HTTPHeaders = ["Content-Type": "application/form-data", "api-key": "bVXR6UoK6eI3pN5ZXvWyN3ezGCB9m0fO"]
    var alamoFireManager : Session!
    class func netWorkCall<T: Codable>(urlString: String, method: HTTPMethod, objectType: T.Type,  parameters: [String: Any], attachment: [UIImage]? = nil, attachmentKey: String, completion: @escaping ((_ data: T?) -> Void)) {
        let finalUrlString = URL(string: baseURL + urlString)
        let header: HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded"]

        let URLSTR = try! URLRequest(url:  finalUrlString!, method: HTTPMethod.post, headers: header)

        AF.upload(multipartFormData: { multipartFormData in

            var subParameters = Dictionary<String, AnyObject>()
            let keys: Array<String> = Array(parameters.keys)
            let values = Array(parameters.values)

            for i in 0..<keys.count
            {
                subParameters[keys[i]] = values[i] as AnyObject
            }


            for (key, value) in subParameters
            {
                if let data:Data = value as? Data
                {
                    multipartFormData.append(data, withName: "file", fileName: "file", mimeType: "audio/m4a")
                }
                else
                {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key)
                }
            }

        }, with: URLSTR)
        .uploadProgress(queue: .main, closure: { progress in
                    //Current upload progress of file
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
                .responseJSON(completionHandler: {response in


                            guard response.error == nil else{
                                print("👹 Error in calling post request")

                                 completion(nil)

                                return
                            }

                            if let value = response.value {
                                print (value)
                                let decoder = JSONDecoder()
                                do {
                                    let user = try decoder.decode(T.self, from: response.data ?? Data())
                                    completion(user)
                                } catch {
                                    print("Call Error: ", error.localizedDescription)
                                    completion(nil)
                                }

//                                if let jsonResponse = response.value as? Dictionary<String, AnyObject>{
//                                    success(jsonResponse)
//                                } else {
                               // let jsonData = try? JSONSerialization.data(withJSONObject: value, options: [])
                               // success((jsonData!))

                             //   }

                            }
                    else
                            {
                                 completion(nil)
                            }

                    })





//        AF.upload(multipartFormData: { multipartFormData in
//
//            attachment.let { _ in
//                for (index, image) in attachment!.enumerated() {
//                    let imageData = image.jpegData(compressionQuality: 0.5)
//                    multipartFormData.append(imageData ?? Data(), withName: String(attachmentKey + "[" + String(index) + "]"), fileName: String(attachmentKey + String(index) + ".png"), mimeType: "image/png")
//                }
//            }
//
//            for (key, value) in parameters {
//                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
//            }
//        }, to: finalUrlString!, usingThreshold: UInt64() , method: .post, headers: header) { result in
//            switch result {
//            case let  (upload, _, _):
//                upload.responseJSON { response in
//                    let jsonString = response
//                    print("Print: \(jsonString )")
//                    //                    let jsonData = jsonString.data(using: .utf8, allowLossyConversion: false)
//                    //                    let jsonData = jsonString.data(using: .utf8, allowLossyConversion: false)
//                    let decoder = JSONDecoder()
//                    do {
//                        let user = try decoder.decode(T.self, from: response.data ?? Data())
//                        completion(user)
//                    } catch {
//                        print("Call Error: ", error.localizedDescription)
//                        completion(nil)
//                    }
//                }
//            case let .failure(error):
//                completion(nil)
//                print("Error in upload: \(error.localizedDescription)")
//                break
//            }
//        }
    }

    // MARK: - Network Functions
    class func sendData<T: Codable>(url: String, params: [String: AnyObject], objectType: T.Type, tokenStatus: Bool = false, networkStatus: Bool = false, completion: @escaping ((_ data: T?) -> Void)) {
        let myURL = baseURL  + url
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        var header: HTTPHeaders = [:]
        if tokenStatus {
        header = ["Content-Type": "application/x-www-form-urlencoded", "api-key": "bVXR6UoK6eI3pN5ZXvWyN3ezGCB9m0fO", "Authorization": "Bearer \(AppSingleton.shared.loginTocken)"]
        } else {
            header = ["Content-Type": "application/x-www-form-urlencoded", "api-key": "bVXR6UoK6eI3pN5ZXvWyN3ezGCB9m0fO"]
        }
        AF.request(URL(string: myURL)!, method: .post, parameters: params, headers: header).responseString { response in
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }

            switch response.result {
            case .success:
                let jsonData = response.data
                let decoder = JSONDecoder()
                do {
                    let user = try decoder.decode(T.self, from: jsonData!)
                    completion(user)
                } catch DecodingError.dataCorrupted(let context) {
                    print(context)
                    completion(nil)
                } catch DecodingError.keyNotFound(let key, let context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                    completion(nil)
                } catch DecodingError.valueNotFound(let value, let context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                    completion(nil)
                } catch DecodingError.typeMismatch(let type, let context) {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                    completion(nil)
                } catch {
                    print("error: ", error)
                    completion(nil)
                }
            case let .failure(error):
                print("Err", error)
                completion(nil)
                if !networkStatus {
                    APIError.shared.handleNetworkErrors(error: error)
                }
                break
            }
        }
    }

    class func uploadDocument(_ file: Data,filename : String, url: String) {
        let parameters = ["type" : "CV"] as [String : Any]
        let fileData = file

        guard let URL2 = try? URLRequest(url: "\(baseURL + url)", method: .post, headers: ["Content-Type": "application/x-www-form-urlencoded", "api-key": "bVXR6UoK6eI3pN5ZXvWyN3ezGCB9m0fO", "Authorization": "Bearer \(AppSingleton.shared.loginTocken)"]) else {
            return
        }

        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(fileData, withName: "doc",fileName: filename, mimeType: "application/pdf")

            for (key, value) in parameters {
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            } //Optional for extra parameters
        },with: URL2)
        .uploadProgress(queue: .main, closure: { progress in
            //Current upload progress of file
            let Progress = ["progress": progress.fractionCompleted]
            NotificationCenter.default.post(name: .downloadProgress, object: nil, userInfo: Progress)

        })
        .responseJSON(completionHandler: { data in
            //Do what ever you want to do with response
            if let JSON = data as? [String : Any]{
                let messageString = JSON["message"] as? String
//                            let newJSON = JSON(["message": "upload Successfully"])
//                            completion(false, newJSON)
                // use the JSON
            }else {
                //error hanlding
            }

        })
    }
    class func requestDta<T: Codable>(url: String, objectType: T.Type, tokenStatus: Bool = false, networkStatus: Bool = false, completion: @escaping ((_ data: T?) -> Void)) {
        let myURL = baseURL  + url
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        var header: HTTPHeaders = [:]
        if tokenStatus {
        header = ["Content-Type": "application/x-www-form-urlencoded", "api-key": "bVXR6UoK6eI3pN5ZXvWyN3ezGCB9m0fO", "Authorization": "Bearer \(AppSingleton.shared.loginTocken)"]
        } else {
            header = ["Content-Type": "application/x-www-form-urlencoded", "api-key": "bVXR6UoK6eI3pN5ZXvWyN3ezGCB9m0fO"]
        }
        AF.request(URL(string: myURL)!, method: .get, headers: header).responseString { response in
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }

            switch response.result {
            case .success:
                let jsonData = response.data
                let decoder = JSONDecoder()
                do {
                    let user = try decoder.decode(T.self, from: jsonData!)
                    completion(user)
                } catch DecodingError.dataCorrupted(let context) {
                    print(context)
                    completion(nil)
                } catch DecodingError.keyNotFound(let key, let context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                    completion(nil)
                } catch DecodingError.valueNotFound(let value, let context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                    completion(nil)
                } catch DecodingError.typeMismatch(let type, let context) {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                    completion(nil)
                } catch {
                    print("error: ", error)
                    completion(nil)
                }
            case let .failure(error):
                print("Err", error)
                completion(nil)
                if !networkStatus {
                    APIError.shared.handleNetworkErrors(error: error)
                }
                break
            }
        }
    }
    
}


extension Optional {
    func `let`(_ do: (Wrapped) -> Void) {
        guard let v = self else { return }
        `do`(v)
    }
}
