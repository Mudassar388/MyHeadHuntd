//
//  SocializerViewModel.swift
//  Rig
//
//  Created by Mac on 10/04/2022.
//  Copyright © 2022 Ale. All rights reserved.
//

import Foundation
class SocializerViewModel{

        typealias RIGSocializeDataClosure = (SocializeDataModel?) -> ()
        typealias ErrorMessage = (String?) -> ()


        var socializeDataModel : SocializeDataModel?

        var socializeData : [SocializeData] = []



        func getSocializers(SocializersParams : SocializerParams, RIGSocializers : @escaping RIGSocializeDataClosure, errorMessage:@escaping ErrorMessage)
        {
            let paramsDic = try? SocializersParams.asDictionary()
            guard let params = paramsDic else
            {
                return
            }

            APIManager.sharedInstance.getSocializerAPI(parameters: params, success:
                                                                    { (result) in
                let decoder = JSONDecoder()
                do
                {
                    let SocializersData = try decoder.decode(SocializeDataModel.self, from: result!)
                    DispatchQueue.main.async {
                        RIGSocializers(SocializersData)
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




        // MARK: - SocializeDataModel
        struct SocializeDataModel: Codable {
            let status: Int?
            let message : String?
            let data: [SocializeData]
            enum CodingKeys: String, CodingKey {
               case status ,message,data
            }

        }






    }
