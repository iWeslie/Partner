//
//  NetworkTool+Dictionary-Related.swift
//  Partner
//
//  Created by YJ on 2018/3/9.
//

import UIKit

extension NetWorkTool {
    
    // MARK:- 获取版本号
    func getITunesVersion(finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) -> Void) {
        let urlString = "http://itunes.apple.com/lookup?id=1360096509"
        request(.POST, urlString: urlString, parameters: nil) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 身份列表
    func getIndentityList(token: String, type: Int, finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/identity/api/getIndentityList.do"
        let parameters = ["token" : token, "type" : type] as [String : Any]
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 投资行业列表
    func getInvestIndustryList(finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/industry/api/getInvestIndustryList.do"
        request(.POST, urlString: urlString, parameters: nil) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 获取省份和城市列表
    func getProvinceAndCityList(finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/area/api/getProvinceAndCityList.do"
        request(.POST, urlString: urlString, parameters: nil) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 企业类型列表
    func getCompanyTypeList(token: String, finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/type/api/getCompanyTypeList.do"
        let parameters = ["token" : token]
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 投资轮次列表
    func getJobList(token: String, finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/job/api/getJobList.do"
        let parameters = ["token" : token]
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }

    // MARK:- 投资轮次列表
    func getRoundList(finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/round/api/getRoundList.do"
        request(.POST, urlString: urlString, parameters: nil) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    //MARK: - 获取项目城市列表（area/getProjectCityList）
    func getProjectCityList(finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/area/api/getProjectCityList.do"
        request(.POST, urlString: urlString, parameters: nil) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    
    // MARK:- 行业领域列表
    func getFieldList(finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/field/api/getFieldList.do"
        request(.POST, urlString: urlString, parameters: nil) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 公司规模列表
    func getScaleList(finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/scale/api/getScaleList.do"
        request(.POST, urlString: urlString, parameters: nil) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
    // MARK:- 币种列表
    func getCurrencyList(finished: @escaping(_ result: [String : AnyObject]?, _ error: Error?) ->()) {
        let urlString = "http://47.100.167.109/qm/currency/api/getCurrencyList.do"
        request(.POST, urlString: urlString, parameters: nil) { (result, error) -> () in
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            finished(resultDict, error)
        }
    }
    
}

