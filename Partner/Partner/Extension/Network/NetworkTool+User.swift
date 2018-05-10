//
//  NetworkTool+Profile.swift
//  Partner
//
//  Created by Weslie on 23/02/2018.
//

import UIKit
extension NetWorkTool {

    // MARK:- 获取我的页面信息
    func getMyPageInfo(token: String, finished: @escaping(_ result :[String : AnyObject]? , _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/user/api/getMyPageInfo.do"
        let parameters = ["token" : token]
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 获取我的信息
    func getMyInfo(token: String, finished: @escaping(_ result :[String : AnyObject]? , _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/user/api/getMyInfo.do"
        let parameters = ["token" : token]
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
 // MARK:- 获取用户个人信息
    func getUserHomePageInfo(token: String, userId : Int,finished: @escaping(_ result :[String : AnyObject]? , _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/user/api/getUserHomePageInfo.do"
        let parameters = ["token" : token , "userId" : userId] as [String : Any]
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
                finished(resultDict, error)
                }
            }
    
    // MARK:- 用户编辑
    func editUser(token: String,
                  image: UIImage?,
                  userName: String,
                  userGender: Int,
                  userMail: String,
                  userCompanyName: String,
                  userJob: String,
                  communityId: Int,
                  identityId: Int,
                  userHobby: String,
                  userSkill: String,
                  userRequire: String,
                  userDesc: String?,
                  finished: @escaping(_ result :[String : AnyObject]? , _ error: Error?) ->()) {
        
        let urlString = "http://47.100.167.109/qm/user/api/editUser.do"
        var parameters = ["token"               : token,
                          "user.userName"       : userName,
                          "user.userGender"     : userGender,
                          "user.userMail"       : userMail,
                          "user.userCompanyName": userCompanyName,
                          "user.userJob"        : userJob,
                          "user.communityId"    : communityId,
                          "user.identityId"     : identityId,
                          "user.userHobby"      : userHobby,
                          "user.userSkill"      : userSkill,
                          "user.userRequire"    : userRequire
            ] as [String : Any]
        if userDesc != nil {
            parameters.updateValue(userDesc!, forKey: "user.userDesc")
        }
        if image != nil {
            parameters.updateValue(image!, forKey: "image")
        }
        post(urlString, parameters: parameters, constructingBodyWith: { [weak self](formData) in
            //upload image
            if image != nil {
                let cateName = "image"
                if let imageData = UIImageJPEGRepresentation(image!, 0.5){
                    let imageName = self?.getNowTime()
                    formData.appendPart(withFileData: imageData, name: cateName, fileName: imageName!, mimeType: "image/png")
                }
            }
            }, progress: { (Progress) in
        }, success: { (_, success) in
            guard let resultDict = success as? [String : AnyObject] else {
                return
            }
            finished(resultDict , nil)
        }) { (URLSessionDataTask, error) in
            finished(nil , error)
        }
    }
    
    // MARK:- 修改密码IOS
    func changePwd(token: String, phone: String, newPwd: String, code: String, finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/user/api/ios/changePwd.do"
        let parameters = ["token" : token, "phone" : phone, "newPwd" : newPwd, "code" : code]
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 1.13.校验用户手机
    func validUserPhone(token: String, projectId: String, type: Int, finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/user/api/validUserPhone.do"
        let parameters = ["token" : token, "projectId" : projectId, "type" : type] as [String : Any]
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }

    // MARK:- 1.15.项目投资人列表
    func getProjectInvestorList(token: String, phone: String, finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/user/api/getProjectInvestorList.do"
        let parameters = ["token" : token, "phone" : phone]
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    
    // MARK:- 1.20.我关注的（感兴趣）用户列表（个人主页-感兴趣）
    func getMyFocusUserList(token: String, finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/user/api/getMyFocusUserList.do"
        let parameters = ["token" : token]
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 1.21.关注用户（感兴趣）
    func focusUser(token: String, userId: Int, finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/user/api/focusUser.do"
        let parameters = ["token" : token, "userId" : userId] as [String : Any]
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 1.22.取消（删除）关注用户
    func cancelFocusUser(token: String, userId: Int, finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/user/api/cancelFocusUser.do"
        let parameters = ["token" : token, "userId" : userId] as [String : Any]
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 1.23.屏蔽用户
    func ignoreUser(token: String, userId: Int, finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/user/api/ignoreUser.do"
        let parameters = ["token" : token, "userId" : userId] as [String : Any]
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 1.23.添加创业经历（个人主页）
    func saveUserEntrepreneurship(token             : String,
                                  entrProjName      : String,
                                  entrRole          : String,
                                  entrIndustry      : String,
                                  entrArea          : String,
                                  entrDate          : String,
                                  beginDate         : String,
                                  entrDateEnd       : String,
                                  entrPartnership   : String,
                                  entrTeamNum       : String,
                                  entrFinancingScale: String,
                                  entrFullTime      : Int,
                                  entrDesc          : String?,
                                  finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        
        let urlString = "http://47.100.167.109/qm/user/api/saveUserEntrepreneurship.do"
        var parameters = ["token"               : token,
                          "entrProjName"        : entrProjName,
                          "entrRole"            : entrRole,
                          "entrIndustry"        : entrIndustry,
                          "entrArea"            : entrArea,
                          "entrDate"            : entrDate,
                          "beginDate"           : beginDate,
                          "entrDateEnd"         : entrDateEnd,
                          "entrPartnership"     : entrPartnership,
                          "entrTeamNum"         : entrTeamNum,
                          "entrFinancingScale"  : entrFinancingScale,
                          "entrFullTime"        : entrFullTime
            ] as [String : Any]
        
        if entrDesc != nil {
            parameters.updateValue(entrDesc as Any, forKey: "entrDesc")
        }
        
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 1.24.获取创业经历（个人主页）
    func getUserEntrepreneurshipInfo(token: String, id: Int, finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/user/api/getUserEntrepreneurshipInfo.do"
        let parameters = ["token" : token, "id" : id] as [String : Any]
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 1.25.编辑创业经历（个人主页）
    func updateUserEntrepreneurship(token             : String,
                                    id                : Int,
                                    entrProjName      : String,
                                    entrRole          : String,
                                    entrIndustry      : String,
                                    entrArea          : String,
                                    entrDate          : String,
                                    beginDate         : String,
                                    entrDateEnd       : String,
                                    entrPartnership   : String,
                                    entrTeamNum       : String,
                                    entrFinancingScale: String,
                                    entrFullTime      : Int,
                                    entrDesc          : String?,
                                    finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        
        let urlString = "http://47.100.167.109/qm/user/api/updateUserEntrepreneurship.do"
        var parameters = ["token"               : token,
                          "id"                  : id,
                          "entrProjName"        : entrProjName,
                          "entrRole"            : entrRole,
                          "entrIndustry"        : entrIndustry,
                          "entrArea"            : entrArea,
                          "entrDate"            : entrDate,
                          "beginDate"           : beginDate,
                          "entrDateEnd"         : entrDateEnd,
                          "entrPartnership"     : entrPartnership,
                          "entrTeamNum"         : entrTeamNum,
                          "entrFinancingScale"  : entrFinancingScale,
                          "entrFullTime"        : entrFullTime
            ] as [String : Any]
        
        if entrDesc != nil {
            parameters.updateValue(entrDesc as Any, forKey: "entrDesc")
        }
        
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 1.26.删除创业经历（个人主页）
    func deleteUserEntrepreneurship(token: String, id: Int, finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/user/api/deleteUserEntrepreneurship.do"
        let parameters = ["token" : token, "id" : id] as [String : Any]
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 1.27.添加工作经历（个人主页）
    func saveUserJob(token          : String,
                     jobCompName    : String,
                     jobName        : String,
                     jobOnTime      : String,
                     beginDate      : String,
                     jobOnTimeEnd   : String,
                     jobDesc        : String?,
                     finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {

        let urlString = "http://47.100.167.109/qm/user/api/saveUserJob.do"
        var parameters = ["token"          : token,
                          "jobCompName"    : jobCompName,
                          "jobName"        : jobName,
                          "jobOnTime"      : jobOnTime,
                          "beginDate"      : beginDate,
                          "jobOnTimeEnd"   : jobOnTimeEnd
            ] as [String : Any]
        
        if jobDesc != nil {
            parameters.updateValue(jobDesc as Any, forKey: "jobDesc")
        }
        
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 1.28.获取工作经历（个人主页）
    func getUserJobInfo(token: String, id: Int, finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/user/api/getUserJobInfo.do"
        let parameters = ["token" : token, "id" : id] as [String : Any]
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 1.29.编辑工作经历（个人主页）
    func editUserJob(token          : String,
                                    id             : Int,
                                    jobCompName    : String,
                                    jobName        : String,
                                    jobOnTime      : String,
                                    beginDate      : String,
                                    jobOnTimeEnd   : String,
                                    jobDesc        : String?,
                                    finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        
        let urlString = "http://47.100.167.109/qm/user/api/updateUserEntrepreneurship.do"
        var parameters = ["token"          : token,
                          "id"             : id,
                          "jobCompName"    : jobCompName,
                          "jobName"        : jobName,
                          "jobOnTime"      : jobOnTime,
                          "beginDate"      : beginDate,
                          "jobOnTimeEnd"   : jobOnTimeEnd
            ] as [String : Any]
        
        if jobDesc != nil {
            parameters.updateValue(jobDesc as Any, forKey: "jobDesc")
        }
        
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 1.30 删除工作经历（个人主页）
    func deleteUserJob(token: String, id: Int, finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/user/api/deleteUserJob.do"
        let parameters = ["token" : token, "id" : id] as [String : Any]
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 1.31.添加教育经历（个人主页）
    func saveUserEdu(token          : String,
                     eduSchool      : String,
                     eduDegree      : String?,
                     eduSpecialty   : String,
                     eduDate        : String,
                     beginDate      : String,
                     eduDateEnd     : String,
                     eduDesc        : String?,
                     finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        
        let urlString = "http://47.100.167.109/qm/user/api/saveUserEdu.do"
        var parameters = ["token"            : token,
                          "eduSchool"        : eduSchool,
                          "eduSpecialty"     : eduSpecialty,
                          "eduDate"          : eduDate,
                          "beginDate"        : beginDate,
                          "eduDateEnd"       : eduDateEnd
            ] as [String : Any]
        
        if eduDegree != nil {
            parameters.updateValue(eduDegree as Any, forKey: "eduDegree")
        }
        if eduDesc != nil {
            parameters.updateValue(eduDesc as Any, forKey: "eduDesc")
        }
        
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 1.32.获取教育经历（个人主页）
    func getUserEduInfo(token: String, id: Int, finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/user/api/getUserEduInfo.do"
        let parameters = ["token" : token, "id" : id] as [String : Any]
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 1.33.编辑教育经历（个人主页）
    func editUserEdu(token          : String,
                     id             : Int,
                     eduSchool      : String,
                     eduDegree      : String?,
                     eduSpecialty   : String,
                     eduDate        : String,
                     beginDate      : String,
                     eduDateEnd     : String,
                     eduDesc        : String?,
                     finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        
        let urlString = "http://47.100.167.109/qm/user/api/editUserEdu.do"
        var parameters = ["token"            : token,
                          "id"               : id,
                          "eduSchool"        : eduSchool,
                          "eduSpecialty"     : eduSpecialty,
                          "eduDate"          : eduDate,
                          "beginDate"        : beginDate,
                          "eduDateEnd"       : eduDateEnd
            ] as [String : Any]
        
        if eduDegree != nil {
            parameters.updateValue(eduDegree as Any, forKey: "eduDegree")
        }
        if eduDesc != nil {
            parameters.updateValue(eduDesc as Any, forKey: "eduDesc")
        }
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 1.34 删除教育经历（个人主页）
    func deleteUserEdu(token: String, id: Int, finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/user/api/deleteUserEdu.do"
        let parameters = ["token" : token, "id" : id] as [String : Any]
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 1.36.获取我的个人主页信息（个人主页页面）
    func getMyHomePageInfo(token: String, finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/user/api/getMyHomePageInfo.do"
        let parameters = ["token" : token]
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }

    // MARK:- 1.37.获取用户个人主页信息（非本人 - 个人主页页面）
//    func getUserHomePageInfo(token: String, userId: Int, finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
//        let urlString = "http://47.100.167.109/qm/user/api/deleteUserEdu.do"
//        let parameters = ["token" : token, "userId" : userId] as [String : Any]
//        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
//            guard let resultDict = result as? [String : AnyObject] else {
//                finished(nil, error)
//                return
//            }
//            finished(resultDict, error)
//        }
    //}

}
