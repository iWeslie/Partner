//
//  NetworkTool+Project.swift
//  Partner
//
//  Created by Weslie on 01/03/2018.
//

import UIKit
extension NetWorkTool {
    
    // MARK:- 6.1.创建项目
    func createProject(token        : String,
                       logo         : UIImage,
                       fields       : String,
                       projName     : String,
                       projCompName : String,
                       projConnName : String,
                       projPhone    : String,
                       projMail     : String,
                       idenId       : Int,
                       areaId       : Int,
                       roundId      : Int,
                       finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {

        let urlString = "http://47.100.167.109/qm/project/api/create.do"
        let parameters = ["token"                 : token,
                          "fields"                : fields,
                          "project.projName"      : projName,
                          "project.projCompName"  : projCompName,
                          "project.projConnName"  : projConnName,
                          "project.projPhone"     : projPhone,
                          "project.projMail"      : projMail,
                          "project.idenId"        : idenId,
                          "project.areaId"        : areaId,
                          "project.roundId"       : roundId
            ] as [String : Any]
        post(urlString, parameters: parameters, constructingBodyWith: { [weak self](formData) in
            //upload image
            let cateName = "logo"
            if let imageData = UIImageJPEGRepresentation(logo, 0.5){
                let imageName = self?.getNowTime()
                formData.appendPart(withFileData: imageData, name: cateName, fileName: imageName!, mimeType: "image/png")
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
    
    // MARK:- 6.2.修改项目介绍
    func updateProjectDesc(token: String, id: Int, projDesc: String, projHighlights: String, finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/project/api/updateProjectDesc.do"
        let parameters = ["token" : token, "id" : id, "projDesc" : projDesc, "projHighlights" : projHighlights] as [String : Any]
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 6.3.修改市场分析
    func updateMarketAnalysis(token             : String,
                              id                : Int,
                              projUserGroup     : String,
                              projProfitModel   : String,
                              projCompetitor    : String,
                              projResources     : String,
                              finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/project/api/updateMarketAnalysis.do"
        let parameters = ["token"           : token,
                          "id"              : id,
                          "projUserGroup"   : projUserGroup,
                          "projProfitModel" : projProfitModel,
                          "projCompetitor"  : projCompetitor,
                          "projResources"   : projResources
                        ] as [String : Any]
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 6.4.修改市场分析
    func updateOperationState(token             : String,
                              id                : Int,
                              projMonthIncome   : Int,
                              projMonthUser     : Int,
                              projTotalUser     : Int,
                              projDataRemark    : String,
                              finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/project/api/updateOperationState.do"
        let parameters = ["token"           : token,
                          "id"              : id,
                          "projMonthIncome" : projMonthIncome,
                          "projMonthUser"   : projMonthUser,
                          "projTotalUser"   : projTotalUser,
                          "projDataRemark"  : projDataRemark
            ] as [String : Any]
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 6.5.修改融资需求
    func updateFinancingNeeds(token             : String,
                              id                : Int,
                              currencyId        : Int?,
                              projFinancing     : Int,
                              projShare         : Int,
                              projValue         : Int,
                              projFundPlan      : String,
                              finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/project/api/updateFinancingNeeds.do"
        var parameters = ["token"          : token,
                          "id"             : id,
                          "projFinancing"  : projFinancing,
                          "projShare"      : projShare,
                          "projValue"      : projValue,
                          "projFundPlan"   : projFundPlan
            ] as [String : Any]
        
        if currencyId != nil {
            parameters.updateValue(currencyId!, forKey: "currencyId")
        }
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 6.6.上传项目计划书
    func uploadProjectPlan(token             : String,
                           id                : Int,
                           businessPlan      : UIImage,
                           finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/project/api/uploadProjectPlan.do"
        let parameters = ["token"          : token,
                          "id"             : id
                        ] as [String : Any]
        post(urlString, parameters: parameters, constructingBodyWith: { [weak self](formData) in
            //upload image
            let cateName = "businessPlan"
            if let imageData = UIImageJPEGRepresentation(businessPlan, 0.5){
                let imageName = self?.getNowTime()
                formData.appendPart(withFileData: imageData, name: cateName, fileName: imageName!, mimeType: "image/png")
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
    
    // MARK:- 6.7.删除项目计划书
    func deleteProjectPlan(token: String, id: Int, finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/project/api/deleteProjectPlan.do"
        let parameters = ["token" : token, "id" : id] as [String : Any]
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 6.8.开始融资
    func beginProject(token: String, id: Int, finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/project/api/begin.do"
        let parameters = ["token" : token, "id" : id] as [String : Any]
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 6.9.选择公司规模
    func selectScale(token: String, id: Int, scaleId: Int, finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/project/api/selectScale.do"
        let parameters = ["token" : token, "id" : id, "scaleId" : scaleId] as [String : Any]
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 6.10.项目基本信息
    func getProjectBasicInfo(token: String, id: Int, finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/project/api/getProjectBasicInfo.do"
        let parameters = ["token" : token, "id" : id] as [String : Any]
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 6.11.我的项目详情（个人中心页面）
    func getMyProjectDetailInfo(token: String, id: Int, finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/project/api/getMyProjectDetailInfo.do"
        let parameters = ["token" : token, "id" : id] as [String : Any]
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 6.12.项目预览
    func previewProject(token: String, id: Int, finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/project/api/preview.do"
        let parameters = ["token" : token, "id" : id] as [String : Any]
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 6.13.项目编辑页面信息
    func getProjectEditInfo(token: String, id: Int, finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/project/api/getProjectEditInfo.do"
        let parameters = ["token" : token, "id" : id] as [String : Any]
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 6.14编辑项目
    func editProject(token        : String,
                     logo         : UIImage,
                     fields       : String,
                     id           : Int,
                     projName     : String,
                     projCompName : String,
                     projConnName : String,
                     projPhone    : String,
                     projMail     : String,
                     idenId       : Int,
                     areaId       : Int,
                     roundId      : Int,
                     finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        
        let urlString = "http://47.100.167.109/qm/project/api/edit.do"
        let parameters = ["token"               : token,
                          "fields"              : fields,
                          "project.id"          : id,
                          "project.projName"    : projName,
                          "project.projCompName": projCompName,
                          "project.projConnName": projConnName,
                          "project.projPhone"   : projPhone,
                          "project.projMail"    : projMail,
                          "project.idenId"      : idenId,
                          "project.areaId"      : areaId,
                          "project.roundId"     : roundId
                         ] as [String : Any]
        
        post(urlString, parameters: parameters, constructingBodyWith: { [weak self](formData) in
            //upload image
            let cateName = "logo"
            if let imageData = UIImageJPEGRepresentation(logo, 0.5){
                let imageName = self?.getNowTime()
                formData.appendPart(withFileData: imageData, name: cateName, fileName: imageName!, mimeType: "image/png")
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
    
    // MARK:- 6.15.我的项目列表
    func getMyProjectList(token: String, pageNum: Int, pageSize: Int, finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/project/api/getMyProjectList.do"
        let parameters = ["token" : token, "pageNum" : pageNum, "pageSize" : pageSize] as [String : Any]
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
 
    
    // MARK:- 6.16.我投资的项目列表
    func getMyInvestProjectList(token: String, pageNum: Int, pageSize: Int, finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/project/api/getMyInvestProjectList.do"
        let parameters = ["token" : token, "pageNum" : pageNum, "pageSize" : pageSize] as [String : Any]
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 6.17.获取项目简介和亮点
    func getProjectDesc(token: String, id: Int, finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/project/api/getProjectDesc.do"
        let parameters = ["token" : token, "id" : id] as [String : Any]
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 6.18.获取项目市场分析信息
    func getMarketInfo(token: String, id: Int, finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/project/api/getMarketInfo.do"
        let parameters = ["token" : token, "id" : id] as [String : Any]
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 6.19.获取项目运营状况
    func getOperationInfo(token: String, id: Int, finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/project/api/getOperationInfo.do"
        let parameters = ["token" : token, "id" : id] as [String : Any]
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 6.20.获取项目融资需求
    func getProjectValue(token: String, id: Int, finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/project/api/getProjectValue.do"
        let parameters = ["token" : token, "id" : id] as [String : Any]
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 6.21.设置项目公开状态
    // MARK:- 6.32.项目设置
    func setProject(token: String, id: Int, projPublic: Int,finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/project/api/setProject.do"
        let parameters = ["token" : token, "id" : id, "projPublic" : projPublic] as [String : Any]
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 6.22.获取项目公开状态
    func getProjectPublic(token: String, id: Int, finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/project/api/getProjectPublic.do"
        let parameters = ["token" : token, "id" : id] as [String : Any]
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 6.23.添加项目成员
    func addMember(token        : String,
                   image        : UIImage?,
                   membName     : String,
                   membJobName  : String,
                   membMail     : String,
                   membDesc     : String?,
                   idenId       : Int,
                   projectId    : Int,
                   finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/project/api/addMember.do"
        var parameters = ["token"               : token,
                          "member.membName"     : membName,
                          "member.membJobName"  : membJobName,
                          "member.membMail"     : membMail,
                          "member.idenId"       : idenId,
                          "member.projectId"    : projectId,
            ] as [String : Any]
        
        if membDesc != nil {
            parameters.updateValue(membDesc as Any, forKey: "member.membDesc")
        }
        
        post(urlString, parameters: parameters, constructingBodyWith: { [weak self](formData) in
            //upload image
            let cateName = "image"
            if image != nil {
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
    
    // MARK:- 6.24.删除项目成员
    func deleteMember(token: String, id: Int, memberId: Int, finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/project/api/deleteMember.do"
        let parameters = ["token" : token, "id" : id, "memberId" : memberId] as [String : Any]
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 6.25.编辑项目成员
    func editMember(token       : String,
                   image        : UIImage?,
                   id           : Int,
                   membName     : String,
                   membJobName  : String,
                   membMail     : String,
                   membDesc     : String?,
                   idenId       : Int,
                   finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/project/api/editMember.do"
        var parameters = ["token"               : token,
                          "member.id"           : id,
                          "member.membName"     : membName,
                          "member.membJobName"  : membJobName,
                          "member.membMail"     : membMail,
                          "member.idenId"       : idenId
                          ] as [String : Any]
        
        if membDesc != nil {
            parameters.updateValue(membDesc as Any, forKey: "member.membDesc")
        }
        
        post(urlString, parameters: parameters, constructingBodyWith: { [weak self](formData) in
            //upload image
            let cateName = "image"
            if image != nil {
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
    
    // MARK:- 6.26.项目成员列表
    func getMemberList(token: String, projectId: Int, finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/project/api/getMemberList.do"
        let parameters = ["token" : token, "projectId" : projectId] as [String : Any]
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 6.27.获取项目成员信息
    func getMemberInfo(token: String, memberId: Int, finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/project/api/getMemberInfo.do"
        let parameters = ["token" : token, "memberId" : memberId] as [String : Any]
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 6.28.项目列表
    func getProjectList(token       : String?,
                        order       : Int,
                        type        : Int?,
                        id          : Int?,
                        fuzzy       : String?,
                        pageNum     : Int,
                        pageSize    : Int,
                        finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/project/api/getProjectList.do"
        var parameters = ["order"           : order,
                          "pageNum"         : pageNum,
                          "pageSize"        : pageSize
                        ] as [String : Any]
        
        if type         != nil { parameters.updateValue(type            as Any, forKey: "type"  ) }
        if token        != nil { parameters.updateValue(token           as Any, forKey: "token" ) }
        if id           != nil { parameters.updateValue(id              as Any, forKey: "id"    ) }
        if fuzzy        != nil { parameters.updateValue(fuzzy           as Any, forKey: "fuzzy" ) }

        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 6.29.收藏项目/取消收藏
    func updateFocusProject(token: String, id: Int, type: Int, finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/project/api/updateFocusProject.do"
        let parameters = ["token" : token, "id" : id, "type" : type] as [String : Any]
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 6.30.浏览项目
    func scanProject(token: String, id: Int, finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/project/api/scanProject.do"
        let parameters = ["token" : token, "id" : id] as [String : Any]
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 6.31.我收藏的项目列表
    func getMyFocusProjectList(token : String, pageNum : Int, pageSize : Int, finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/project/api/getMyFocusProjectList.do"
        let parameters = ["token" : token, "pageNum" : pageNum, "pageSize" : pageSize] as [String : Any]
        
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 6.33.删除项目
    func deleteProject(token: String, id: Int, finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/project/api/deleteProject.do"
        let parameters = ["token" : token, "id" : id] as [String : Any]
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 6.34.精选项目
    func getSelectedProjectList(token: String?, finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/project/api/getSelectedProjectList.do"
        let parameters = ["token" : token] as [String : Any]
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 6.35.项目详情
    func getProjectDetailInfo(token: String, id: Int, finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/project/api/getProjectDetailInfo.do"
        let parameters = ["token" : token, "id" : id] as [String : Any]
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 6.36.投资申请
    func applyFinancing(token: String, id: Int, finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/project/api/applyFinancing.do"
        let parameters = ["token" : token, "id" : id] as [String : Any]
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 6.37.同意投资申请
    func agreeFinancingApply(token: String, userId: Int, projectId: Int, finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/project/api/agreeApplyFinancing.do"
        let parameters = ["token" : token, "userId" : userId, "projectId" : projectId] as [String : Any]
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 6.38.拒绝投资申请
    func rejectFinancingApply(token: String, userId: Int, projectId: Int, finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/project/api/rejectFinancingApply.do"
        let parameters = ["token" : token, "userId" : userId, "projectId" : projectId] as [String : Any]
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 6.39.删除投资申请
    func deleteFinancingApply(token: String, userId: Int, projectId: Int, finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/project/api/deleteFinancingApply.do"
        let parameters = ["token" : token, "userId" : userId, "projectId" : projectId] as [String : Any]
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 6.40.校验是否可以投递项目
    func judgeDelierValid(token: String, userId: Int, projectId: Int, finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/project/api/deliver/valid.do"
        let parameters = ["token" : token, "userId" : userId, "projectId" : projectId] as [String : Any]
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 6.40.投递项目
    func deliverProject(token: String, userId: Int, projectIds: String, finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/project/api/deliverProject.do"
        let parameters = ["token" : token, "userId" : userId, "projectIds" : projectIds] as [String : Any]
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 6.41.投资意向项目
    func investIntendedProject(token: String, projectId: Int, finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/project/api/investIntendedProject.do"
        let parameters = ["token" : token, "projectId" : projectId] as [String : Any]
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 6.42.拒绝意向项目
    func rejectIntendedProject(token: String, projectId: Int, finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/project/api/rejectIntendedProject.do"
        let parameters = ["token" : token, "projectId" : projectId] as [String : Any]
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 6.43.删除意向项目
    func deleteIntendedProject(token: String, projectId: Int, finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/project/api/deleteIntendedProject.do"
        let parameters = ["token" : token, "projectId" : projectId] as [String : Any]
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 6.44.获取我的投递项目列表
    func getMyDeliverProjectList(token: String, finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/project/api/getMyDeliverProjectList.do"
        let parameters = ["token" : token]
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 6.45.获取意向项目列表
    func getIntendedProjectList(token : String, pageNum : Int, pageSize : Int, finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/project/api/getIntendedProjectList.do"
        let parameters = ["token" : token, "pageNum" : pageNum, "pageSize" : pageSize] as [String : Any]
        
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 6.46.获取意向项目数
    func getIntendedProjectNum(token: String, finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/project/api/getIntendedProjectNum.do"
        let parameters = ["token" : token]
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
}
