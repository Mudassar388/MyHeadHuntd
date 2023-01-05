

import Foundation
import Alamofire
import UIKit

struct MessagesConstants {
    static let baseURL = "http://techsocialserver.space/api/"
    static let apiKey = "bVXR6UoK6eI3pN5ZXvWyN3ezGCB9m0fO"
    static let token =  UserDefaults.standard.string(forKey: "token")
//    static let token =
//    "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC90ZWNoc29jaWFsc2VydmVyLnNwYWNlXC9hcGlcL2xvZ2luIiwiaWF0IjoxNjYzODQ1MTU2LCJleHAiOjE2NjY0NzMxNTYsIm5iZiI6MTY2Mzg0NTE1NiwianRpIjoiYlYzbnZSdVNIZU8wbjZWaSIsInN1YiI6MzU2LCJwcnYiOiI4N2UwYWYxZWY5ZmQxNTgxMmZkZWM5NzE1M2ExNGUwYjA0NzU0NmFhIn0.XKp9e-BGBkFJIRK4l07p8piyDYfNucxr1VrzdJ3ISys"
}



class HTTPManager: APIHandler {
    
    static let shared: HTTPManager = HTTPManager()
    
    
    public func get<T: Codable>(_ apiName: String , completion: @escaping (_ response: T?) -> Void) {
        
        let url = "\(MessagesConstants.baseURL)\(apiName)"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(MessagesConstants.token ?? "")",
            "api-key": MessagesConstants.apiKey
        ]
        print(url)
        print(headers)
        AF.request(url, method: .get, encoding: URLEncoding.default, headers: headers).responseDecodable { [weak self] (response: DataResponse<T, AFError>) in
            
//            print(response.response?.statusCode)
            guard let weakSelf = self else { return }
            
            guard let response = weakSelf.handleResponse(response) as? T else {
                completion(nil)
                return
            }
            completion(response)
        }
    }
    
    
    public func post<T: Codable>(_ apiName: String, withparams parameters: [String:Any] = [:], noHeaders: Bool = false, completion: @escaping (_ response: T?) -> Void) {
        
        let url = "\(MessagesConstants.baseURL)\(apiName)"
        var headers: HTTPHeaders = [
            "Authorization": "Bearer \(MessagesConstants.token ?? "")",
            "api-key": MessagesConstants.apiKey
        ]
        if noHeaders {
            headers = [:]
        }
        
        print("URL: ",url)
        print("Headers: ",headers)
        print("Parameters: ",parameters)
        //URLEncoding.default
        AF.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseDecodable { [weak self] (response: DataResponse<T, AFError>) in

            guard let weakSelf = self else { return }
            
            guard let response = weakSelf.handleResponse(response) as? T else {
                completion(nil)
                return
            }
            completion(response)
        }
    }
    
    
    public func multipart<T: Codable>(_ apiName: String, image: UIImage? , file:URL? = nil, withName: String? = "", withparams parameters: [String:Any] = [:], completion: @escaping (_ response: T?) -> Void) {
        
        
        let url = "\(MessagesConstants.baseURL)\(apiName)"
        var headers: HTTPHeaders = [
            "Authorization": "Bearer \(MessagesConstants.token ?? "")",
            "api-key": MessagesConstants.apiKey
        ]
        print("URL: ", url)
        print("Headers: ", headers)
        print("Parameters: ", parameters)
        print("Image: ", image)
        
        AF.upload(multipartFormData: { multiPart in
        
            for p in parameters {
                multiPart.append("\(p.value)".data(using: String.Encoding.utf8)!, withName: p.key)
            }
            
            print(multiPart)
            if let imageData = image?.jpegData(compressionQuality: 0.5){
                multiPart.append(imageData, withName: "image", fileName: "\(Date().timeIntervalSinceNow)image.jpg", mimeType: "image/jpg")
            }
            
        }, to: url, method: .post, headers: headers).responseDecodable{ [weak self] (response: DataResponse<T, AFError>) in
            
            guard let weakSelf = self else { return }
            
            guard let response = weakSelf.handleResponse(response) as? T else {
                completion(nil)
                return
            }
            completion(response)
            print(response)
        }
    }
    
    
}
