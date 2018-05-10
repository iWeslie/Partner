//
//  NetworkTool+Feedback.swift
//  Partner
//
//  Created by YJ on 2018/3/8.
//

import UIKit

extension NetWorkTool {
    
    // MARK:- 意见反馈
    func sendFeedback(token: String, feedContent: String, finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/feedback/api/send.do"
        let parameters = ["token" : token, "feedContent" : feedContent]
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 审批意见
    func getApproveList(token: String, type: Int, id: Int, finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/approve/api/getApproveList.do"
        let parameters = ["token" : token, "type" : type, "id" : id] as [String : Any]
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 获取联系方式
    func getPhone(phoneType: Int, finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/phone/api/getPhone.do"
        let parameters = ["phoneType" : phoneType]
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
}
