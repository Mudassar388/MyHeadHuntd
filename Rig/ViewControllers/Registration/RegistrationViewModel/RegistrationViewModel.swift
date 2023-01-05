//
//  RegiestrationViewModel.swift
//  Rig
//
//  Created by Mac on 24/04/2022.
//  Copyright © 2022 Ale. All rights reserved.
//

import Foundation
class RegistrationViewModel {
    typealias RIGCompanyModelClosure = (CompanyRegisterpModel?) -> ()
    typealias RIGUserModelClosure = (UserRegisterpModel?) -> ()
    typealias RIGDocUploadModelClosure = (DocUploadModel?) -> ()
    typealias RIGSkillUserModelClosure = (SkillUserModel?) -> ()
    typealias RIGForgetPasswordModelClosure = (ForgetPasswordModel?) -> ()
    typealias RIGIndustrySkillModelClosure = (IndustrySkillModel?) -> ()

    typealias ErrorMessage = (String?) -> ()

    var companySignUpModel : CompanyRegisterpModel?
    var companyRegisterData  : CompanyModel?
    var userSignUpModel : UserRegisterpModel?
    var userRegisterData  : UserModel?
    var docUploadModel  : DocUploadModel?
    var skillUserModel: SkillUserModel?
    var forgetPasswordModel: ForgetPasswordModel?
    var industrySkillModel: IndustrySkillModel?

    //MARK: - getJobFeeds api calling
    func getSkillIndustryApi(industrySkillParams : IndustrySkillParams, RIGindustrySkill : @escaping RIGIndustrySkillModelClosure, errorMessage:@escaping ErrorMessage)
    {
        let paramsDic = try? industrySkillParams.asDictionary()
        guard let params = paramsDic else
        {
            return
        }

        APIManager.sharedInstance.getSkillIndustryApi(parameters: params, success:
                                                                { (result) in
            let decoder = JSONDecoder()
            do
            {
                let RIGindustrySkilldata = try decoder.decode(IndustrySkillModel.self, from: result!)
                DispatchQueue.main.async {
                    RIGindustrySkill(RIGindustrySkilldata)
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
    //MARK: - Forget Password api calling post request
    func forgetPasswordAPI(ForgetPasswordParams : ForgetPasswordParams, RIGForgetPasswordModelClosure : @escaping RIGForgetPasswordModelClosure, errorMessage:@escaping ErrorMessage)
    {
        let paramsDic = try? ForgetPasswordParams.asDictionary()
        guard let params = paramsDic else
        {
            return
        }
        APIManager.sharedInstance.forgetpasswordAPI(parameters: params, success:
                                                    { (result) in
            let decoder = JSONDecoder()
            do
            {
                let  data = try decoder.decode(ForgetPasswordModel.self, from: result!)
                DispatchQueue.main.async {
                    RIGForgetPasswordModelClosure(data)
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
    //MARK: - DOC PdfUpload api calling post request
//    func pdfUplaodAPI(PDFUplaodParams : PDFUplaodParams,Docdata:Data,filename:String, RIGDocUploadModelClosure : @escaping RIGDocUploadModelClosure, errorMessage:@escaping ErrorMessage)
//    {
//        let paramsDic = try? PDFUplaodParams.asDictionary()
//        guard let params = paramsDic else
//        {
//            return
//        }
//        APIManager.sharedInstance.postPDFUploadingAPI(parameters: params,Docdata: Docdata,filename: filename, success:
//                                                    { (result) in
//            let decoder = JSONDecoder()
//            do
//            {
//                let  data = try decoder.decode(DocUploadModel.self, from: result!)
//                DispatchQueue.main.async {
//                    RIGDocUploadModelClosure(data)
//                }
//            }
//            catch let error
//            {
//                print(error)
//                DispatchQueue.main.async {
//                    errorMessage(error.localizedDescription)
//                }
//            }
//        }) { (error:NSError) in
//            DispatchQueue.main.async {
//                errorMessage(error.localizedDescription)
//            }
//
//        }
//    }
    func sendUserSkillsAPI(userSkillArray :[Int] , RIGSkillUserModelClosure : @escaping RIGSkillUserModelClosure, errorMessage:@escaping ErrorMessage)
    {
//        let paramsDic = try? userSkillArray.asDictionaryVar()
//        guard let params = paramsDic else
//        {
//            return
//        }
        var paramsVar : [String: Any] = [:]

        var animDictionary: [String: Any] = [:]
        let count  = userSkillArray.count
        (0...count - 1).forEach { animDictionary["skill[\($0)]"] = userSkillArray[$0] }
        for (key, value) in animDictionary {
            paramsVar[key] = value
        }

        APIManager.sharedInstance.saveUserSkillsAPI(parameters: paramsVar, success:
                                                                { (result) in
            let decoder = JSONDecoder()
            do
            {
                let data = try decoder.decode(SkillUserModel.self, from: result!)
                DispatchQueue.main.async {
                    RIGSkillUserModelClosure(data)
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

    //MARK: - UserLogin api calling post request
    func UserLoginAPI(UserLoginParams : LoginParams, RIGUserModelClosure : @escaping RIGUserModelClosure, errorMessage:@escaping ErrorMessage)
    {
        let paramsDic = try? UserLoginParams.asDictionary()
        guard let params = paramsDic else
        {
            return
        }
        APIManager.sharedInstance.LoginAPICall(parameters: params, success:
                                                    { (result) in
            let decoder = JSONDecoder()
            do
            {
                let  data = try decoder.decode(UserRegisterpModel.self, from: result!)
                DispatchQueue.main.async {
                    RIGUserModelClosure(data)
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
    //MARK: - companyLogin api calling post request
    func CompanyLoginAPI(companyLoginParams : LoginParams, RIGCompanyModelClosure : @escaping RIGCompanyModelClosure, errorMessage:@escaping ErrorMessage)
    {
        let paramsDic = try? companyLoginParams.asDictionary()
        guard let params = paramsDic else
        {
            return
        }
        APIManager.sharedInstance.LoginAPICall(parameters: params, success:
                                                    { (result) in
            let decoder = JSONDecoder()
            do
            {
                let data = try decoder.decode(CompanyRegisterpModel.self, from: result!)
                DispatchQueue.main.async {
                    RIGCompanyModelClosure(data)
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

    //MARK: - UserSignUp api calling post request
    func UserSignUp(userSignUpParams : UserSignUpParams, RIGUserModelClosure : @escaping RIGUserModelClosure, errorMessage:@escaping ErrorMessage)
    {
        let paramsDic = try? userSignUpParams.asDictionary()
        guard let params = paramsDic else
        {
            return
        }
        APIManager.sharedInstance.SignUpAPICall(parameters: params, success:
                                                            { (result) in
            let decoder = JSONDecoder()
            do
            {
                let data = try decoder.decode(UserRegisterpModel.self, from: result!)
                DispatchQueue.main.async {
                    RIGUserModelClosure(data)
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

    //MARK: - CompanySignUp api calling post request
    func companySignUp(companySignUpParams : CompanySignUpParams, RIGCompanyModelClosure : @escaping RIGCompanyModelClosure, errorMessage:@escaping ErrorMessage)
    {
        let paramsDic = try? companySignUpParams.asDictionary()
        guard let params = paramsDic else
        {
            return
        }
        APIManager.sharedInstance.SignUpAPICall(parameters: params, success:
                                                            { (result) in
            let decoder = JSONDecoder()
            do
            {
                let data = try decoder.decode(CompanyRegisterpModel.self, from: result!)
                DispatchQueue.main.async {
                    RIGCompanyModelClosure(data)
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


    // MARK: - CompanySignUpModel
    struct CompanyRegisterpModel: Codable {
        let status: Int?
        let message:String?
        let data: CompanyModel?
        enum CodingKeys: String , CodingKey {
        case status,message,data
        
        }
    }
    // MARK: - UserRegisterpModel
    struct UserRegisterpModel: Codable {
        let status: Int?
        let message:String?
        let data: UserModel?
        enum CodingKeys: String , CodingKey {
        case status,message,data
        }
    }
    // MARK: - DocUploadModel
    struct DocUploadModel: Codable {
        let status: Int?
        let message:String?
        enum CodingKeys: String , CodingKey {
        case status,message
        }
    }
    // MARK: - SkillUserModel
    struct SkillUserModel: Codable {
        let status: Int?
        let message: String?
        enum CodingKeys:String,CodingKey{
            case status,message
        }
    }

    // MARK: - ForgetPasswordModel
    struct ForgetPasswordModel: Codable {
        let status: Int?
        let message: String?
        enum CodingKeys:String,CodingKey{
            case status,message
        }
    }


    // MARK: - IndustrySkillModel
    struct IndustrySkillModel: Codable {
        let status: Int?
        let message: String?
        let data: [IndustrySkillsData]?

        enum CodingKeys: String, CodingKey {
           case status,message,data
        }
    }
}
