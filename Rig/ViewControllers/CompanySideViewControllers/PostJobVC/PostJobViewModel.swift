//
//  PostJobViewModel.swift
//  Rig
//
//  Created by Mac on 20/04/2022.
//  Copyright © 2022 Ale. All rights reserved.
//

import Foundation
import Alamofire
class PostJobViewModel{

    typealias RIGPostJobClosure = (PostJobModel?) -> ()
    typealias ErrorMessage = (String?) -> ()
    var skillsForParams = [Int]()
    var postJob : PostJobModel?


    //MARK: - postJobsApi api calling
    func postJobsApi(postJobParams :PostJobParams , PostJobClosure : @escaping RIGPostJobClosure, errorMessage:@escaping ErrorMessage)
    {
        let paramsDic = try? postJobParams.asDictionaryVar()
        guard let params = paramsDic else
        {
            return
        }
        var paramsVar : [String: Any] = [:]
        paramsVar = params
        var animDictionary: [String: Any] = [:]
        let count  = skillsForParams.count
        (0...count - 1).forEach { animDictionary["skills[\($0)]"] = skillsForParams[$0] }
        for (key, value) in animDictionary {
            paramsVar[key] = value
        }


        APIManager.sharedInstance.postJobAPI(parameters: paramsVar, success:
                                                                { (result) in
            let decoder = JSONDecoder()
            do
            {
                let postJob = try decoder.decode(PostJobModel.self, from: result!)
                DispatchQueue.main.async {
                    PostJobClosure(postJob)
                }
            }
            catch let error
            {
                print(error)
                DispatchQueue.main.async {
                    errorMessage(error.localizedDescription)
                }
            }
        }) { (error:NSError) in
            DispatchQueue.main.async {
                errorMessage(error.localizedDescription)
        }

    }
    }

    // MARK: - PostJobModel
    struct PostJobModel: Codable {
        let status: Int?
        let message: String?
    enum Codingkeys :String,CodingKey {
        case status,message

        }
    }

}

