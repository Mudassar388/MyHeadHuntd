//
//  AboutUs.swift
//  Rig
//
//  Created by Mac on 09/05/2022.
//  Copyright © 2022 Ale. All rights reserved.
//

import Foundation
class AboutUsViewModel{
    typealias RIGPageModelClosure = (PageModel?) -> ()
    typealias ErrorMessage = (String?) -> ()
    var pageModel :PageModel?
    //MARK: - getJobFeeds api calling
    func getpageAPi(PagesParam : PagesParam, RIGPageModelClosure : @escaping RIGPageModelClosure, errorMessage:@escaping ErrorMessage)
    {
        let paramsDic = try? PagesParam.asDictionary()
        guard let params = paramsDic else
        {
            return
        }

        APIManager.sharedInstance.getpageAPi(parameters: params, success:
                                                                { (result) in
            let decoder = JSONDecoder()
            do
            {
                let Data = try decoder.decode(PageModel.self, from: result!)
                DispatchQueue.main.async {
                    RIGPageModelClosure(Data)
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

    // MARK: - PageModel
    struct PageModel: Codable {
        let status: Int?
        let message :String?
        let data: PageModelData?
        enum CodingKeys: String, CodingKey {
           case status ,message,data
        }
    }

    // MARK: - PageModelData
    struct PageModelData: Codable {
        let title, dataDescription: String

        enum CodingKeys: String, CodingKey {
            case title
            case dataDescription = "description"
        }
    }

}
