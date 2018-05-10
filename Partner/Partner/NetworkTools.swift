//
//  NetworkTools.swift
//
//  Created by Weslie on 2017/5/19.
//  Copyright © 2017年 Weslie. All rights reserved.
//

import AFNetworking
import NoticeBar

// MARK:- 定义枚举类型
enum RequestType : String {
    case GET = "GET"
    case POST = "POST"
}
//1投资商 2创业者 3普通用户
enum userCatrgory : Int {
    case investor = 1
    case entrepreneur = 2
    case ordinaryUser = 3
}
class NetWorkTool: AFHTTPSessionManager {
    
    static   var   canConnect : Bool = true
    //let 是线程安全的,创建单例
    static let shareInstance : NetWorkTool = {
        let  tools = NetWorkTool()
        tools.responseSerializer.acceptableContentTypes?.insert("text/html")
        return tools
    }()
    
}

extension NetWorkTool  {
    func startMonitoringNetwork() -> () {
        let mgr = AFNetworkReachabilityManager.shared()
        mgr.setReachabilityStatusChange { (Status) -> Void in
            switch(Status){
            case AFNetworkReachabilityStatus.notReachable:
                let config = NoticeBarConfig(title: "网络错误，请稍后再试", image: nil, textColor: UIColor.white, backgroundColor: UIColor.red, barStyle: NoticeBarStyle.onNavigationBar, animationType: NoticeBarAnimationType.top )
                let noticeBar = NoticeBar(config: config)
                noticeBar.show(duration: 2.0, completed: {
                    (finished) in
                    if finished {
                    }
                })
                NetWorkTool.canConnect = false
                break
            case AFNetworkReachabilityStatus.reachableViaWiFi:
                NetWorkTool.canConnect = true
                break
            case AFNetworkReachabilityStatus.reachableViaWWAN:
                NetWorkTool.canConnect = true
                break
            default:
                NetWorkTool.canConnect = true
                break
            }
        }
        
        mgr.startMonitoring()
    }
    
    func request(_ method: RequestType, urlString : String, parameters:[String :AnyObject]?, finished:@escaping (_ result : AnyObject?, _ error : Error?)->()){
        //网路监控
        startMonitoringNetwork()
        if(NetWorkTool.canConnect == true){
            //定义成功的回调闭包
            let successCallBack = {  (task: URLSessionDataTask?, result: Any?) -> Void in
                finished(result  as AnyObject, nil )
            }
            //定义失败的回调闭包
            let failureCallBack = { (task: URLSessionDataTask?, error: Error?) -> Void in
                finished(nil, error )
            }
            //发送网络请求
            if method == RequestType.GET {
                self.get(urlString, parameters: parameters, progress: nil, success: successCallBack, failure: failureCallBack)
            } else {
                self.post(urlString, parameters: parameters, progress: nil, success: successCallBack, failure: failureCallBack)
            }
        } else {
        }
    }
}

extension NetWorkTool {
    //用户登录
    func UserLogin( _ account:String, password:String  , finished:@escaping (_ result : [String : AnyObject]? ,_ error:Error?) ->()) {
        //1.获取请求的URLString
        let urlString = "http://47.100.167.109/qm/user/api/userLogin.do"
        //2.获取请求参数
        let parameters = ["phone" : account , "password": password]
        //3.发送请求参数
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            //获取字典数据
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            //将数组数据回调给外界控制器
            finished(resultDict, error)
        }
    }
    
    //用户注册
    func userRegister(phone:String , password : String , code : String , finished:@escaping (_ result : [String : AnyObject]? ,_ error:Error?) ->()) {
        //1.获取请求的URLString
        let urlString = "http://47.100.167.109/qm/user/api/ios/userRegister.do"
        //2.获取请求参数
        let parameters = ["phone" : phone , "password": password, "code" : code ]
        //3.发送请求参数
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            //获取字典数据
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            //将数组数据回调给外界控制器
            finished(resultDict, error)
        }
    }
//
    func userRegister1(phone:String , password : String , code : String? , finished:@escaping (_ result : [String : AnyObject]? ,_ error:Error?) ->()) {
        //1.获取请求的URLString
        let urlString = "http://47.100.167.109/qm/user/api/userRegister.do"
        //2.获取请求参数
        let parameters = ["phone" : phone , "password": password]
        //3.发送请求参数
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            //获取字典数据
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            //将数组数据回调给外界控制器
            finished(resultDict, error)
        }
    }
    
    //忘记密码
    func forgetPwd(phone:String , password : String , code : String , finished:@escaping (_ result : [String : AnyObject]? ,_ error:Error?) ->()) {
        //1.获取请求的URLString
        let urlString = "http://47.100.167.109/qm/user/api/ios/forgetPwd.do"
        //2.获取请求参数
        let parameters = ["phone" : phone , "newPwd": password, "code" : code ]
        //3.发送请求参数
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            //获取字典数据
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            //将数组数据回调给外界控制器
            finished(resultDict, error)
        }
    }
    
    //完善个人信息
//    token
//    image
//    realName
//    gender
//    companyName
//    jobName
//    communityId

    func perfectUserInfo(token:String , image : UIImage?, realName : String, gender : Int ,companyName : String?, jobName : String?, communityId : Int?,  finished:@escaping (_ result : [String : AnyObject]? ,_ error:Error?) ->()){
        //1.获取请求的URLString
        let urlString = "http://47.100.167.109/qm/user/api/perfectUserInfo.do"
        //2.获取请求参数
        let parameters =  ["token" : token , "realName" : realName , "gender" : gender , "companyName" : companyName, "jobName" : jobName , "communityId" : communityId ] as [String : Any]
        //3.发送请求参数
        post(urlString, parameters: parameters, constructingBodyWith: { [weak self](formData) in
            //upload avatar
            if image != nil {
                let cateName = "image"
                if let imageData = UIImageJPEGRepresentation(image!, 0.5){
                    let imageName =  self?.getNowTime()
                    formData.appendPart(withFileData: imageData, name: cateName, fileName: imageName! , mimeType: "image/png")
                }
            }
          }, progress: { (Progress) in 
            
        }, success: { (_, success) in
            guard let resultDict = success as? [String : AnyObject] else {
                return}
            finished(resultDict , nil)
        }) { (URLSessionDataTask, error) in
            finished(nil , error)
        }
    }
    
    
    // 验证码发送
    func getDynamicpw(phone:String , finished:@escaping (_ result : [String : AnyObject]? ,_ error:Error?) ->()) {
        //1.获取请求的URLString
        let urlString = "http://47.100.167.109/qm/user/api/sendDynamicpw.do"
        //2.获取请求参数
        let parameters = ["phone" : phone]
        //3.发送请求参数
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            //获取字典数据
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            //将数组数据回调给外界控制器
            finished(resultDict, error)
        }
    }
    
    
    //选择个人身份
    func updateUserIndentity(token:String ,idenId :userCatrgory , finished:@escaping (_ result : [String : AnyObject]? ,_ error:Error?) ->()) {
        //1.获取请求的URLString
        let urlString = "http://47.100.167.109/qm/user/api/updateUserIndentity.do"
        //2.获取请求参数
        let parameters = ["idenId" : idenId.rawValue ,"token" : token] as [String : Any]
        //3.发送请求参数
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            //获取字典数据
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            //将数组数据回调给外界控制器
            finished(resultDict, error)
        }
    }
    
    //获取城市列表 http://47.100.167.109/qm/community/api/getCityAndCommunityList.do
    func getCommunityCityList(token:String,finished:@escaping (_ result : [String : AnyObject]? ,_ error:Error?) ->()){
        //1.获取请求的URLString
        let urlString = "http://47.100.167.109/qm/community/api/getCityAndCommunityList.do"
        //2.获取请求参数
        let parameters = ["token" : token] as [String : Any]
        //3.发送请求参数
        request(.GET, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            //获取字典数据
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            //将数组数据回调给外界控制器
            finished(resultDict, error)
        }
    }
    //服务类型列表（type/getServiceTypeList）http://47.100.167.109/qm/type/api/getServiceTypeList.do
    func getServiceTypeList(finished:@escaping (_ result : [String : AnyObject]? ,_ error:Error?) ->()){
        //1.获取请求的URLString
        let urlString = "http://47.100.167.109/qm/type/api/getServiceTypeList.do"
        //2.获取请求参数
        let parameters = [:] as [String : Any]
        //3.发送请求参数
        request(.GET, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            //获取字典数据
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            //将数组数据回调给外界控制器
            finished(resultDict, error)
        }
    }
    
    
    //获取标签列表
    //http://47.100.167.109/qm/tag/api/getTagList.do  token type
    func getTagList(token:String , type : Int, finished:@escaping (_ result : [String : AnyObject]? ,_ error:Error?) ->()){
        //1.获取请求的URLString
        let urlString = "http://47.100.167.109/qm/tag/api/getTagList.do"
        //2.获取请求参数
        let parameters = ["token" : token , "type" : type] as [String : Any]
        //3.发送请求参数
        request(.GET, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            //获取字典数据
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            //将数组数据回调给外界控制器
            finished(resultDict, error)
        }
    }

    //完善标签信息
    func perfectUsertagInfo(token:String , type : Int, tagName : String, finished:@escaping (_ result : [String : AnyObject]? ,_ error:Error?) ->()){
        //1.获取请求的URLString
        let urlString = "http://47.100.167.109/qm/user/api/perfectUserTagInfo.do"
        //2.获取请求参数
        let parameters = ["token" : token , "type" : type ,"tagName" : tagName] as [String : Any]
        //3.发送请求参数
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            //获取字典数据
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            //将数组数据回调给外界控制器
            finished(resultDict, error)
        }
    }
    
    
    //完善合作需求http://47.100.167.109/qm/user/api/perfectUserRequireInfo.do
    func perfectUserRequireInfo(token:String ,  require : String, finished:@escaping (_ result : [String : AnyObject]? ,_ error:Error?) ->()){
        //1.获取请求的URLString
        let urlString = "http://47.100.167.109/qm/user/api/perfectUserRequireInfo.do"
        //2.获取请求参数
        let parameters = ["token" : token , "require" : require] as [String : Any]
        //3.发送请求参数
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            //获取字典数据
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            //将数组数据回调给外界控制器
            finished(resultDict, error)
        }
    }
    func getNowTime() -> (String){
        let date = NSDate.init(timeIntervalSinceNow: 0)
        let a  =  date.timeIntervalSince1970
        let timesString = "\(a).png"
        return  timesString
    }
    
    
    //热门投资人（user/getHotInvestorList）
    func getHotInvestorList(finished:@escaping (_ result : [String : AnyObject]? ,_ error:Error?) ->()){
        //1.获取请求的URLString
        let urlString = "http://47.100.167.109/qm/user/api/getHotInvestorList.do"
        //2.获取请求参数
        let parameters = [:] as [String : Any]
        //3.发送请求参数
        request(.GET, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            //获取字典数据
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            //将数组数据回调给外界控制器
            finished(resultDict, error)
        }
    }
    
    //校验是否可以投递项目（project/api/deliver/valid）
    //
    func deliverValid(token:String, userId : Int, projectId : Int,finished:@escaping (_ result : [String : AnyObject]? ,_ error:Error?) ->()){
        //1.获取请求的URLString
        let urlString = "http://47.100.167.109/qm/project/api/deliver/valid.do"
        //2.获取请求参数
        let parameters = ["token" : token , "userId" : userId ,"projectId" : projectId] as [String : Any]
        //3.发送请求参数
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            //获取字典数据
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            //将数组数据回调给外界控制器
            finished(resultDict, error)
        }
    }
    
    //1.17.投资人列表（user/getInvestorList）
    func getInvestorList( pageNum : Int, order : Int, type : Int? , id : Int? ,fuzzy : String?, finished:@escaping (_ result : [String : AnyObject]? ,_ error:Error?) ->()){
        //1.获取请求的URLString
        let urlString = "http://47.100.167.109/qm/user/api/getInvestorList.do"
        //2.获取请求参数
        let parameters = ["type" : type ?? 0, "order" : order, "id" : id ?? 0 ,  "fuzzy" : fuzzy as Any ,"pageNum" :pageNum , "pageSize" : 10]
        //3.发送请求参数
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            //获取字典数据
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            //将数组数据回调给外界控制器
            finished(resultDict, error)
        }
    }
    
    
    
    
    

    //项目列表（project/getProjectList）
    func getProjectList(token:String?, order : Int, type : Int? , id : Int? ,fuzzy : String?, pageNum : Int, finished:@escaping (_ result : [String : AnyObject]? ,_ error:Error?) ->()){
        //1.获取请求的URLString
        let urlString = "http://47.100.167.109/qm/project/api/getProjectList.do"
        //2.获取请求参数
        let parameters = ["token" : token ?? "", "type" : type ?? 0, "order" : order, "id" : id ?? 0 ,  "fuzzy" : fuzzy as Any ,"pageNum" :pageNum , "pageSize" : 10] 
        //3.发送请求参数
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            //获取字典数据
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            //将数组数据回调给外界控制器
            finished(resultDict, error)
        }
    }
    
    //资讯类型列表（info/type/list）
    func getTypeList(finished:@escaping (_ result : [String : AnyObject]? ,_ error:Error?) ->()){
        //1.获取请求的URLString
        let urlString = "http://47.100.167.109/qm/info/api/type/list.do"
        //2.获取请求参数
        let parameters = [:] as [String : Any]
        //3.发送请求参数
        request(.GET, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            //获取字典数据
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            //将数组数据回调给外界控制器
            finished(resultDict, error)
        }
    }
    
    
    //资讯列表（info/list）ss
    func getInfoList(type : Int? ,fuzzy : String?, pageNum : Int,finished:@escaping (_ result : [String : AnyObject]? ,_ error:Error?) ->()){
        //1.获取请求的URLString
        let urlString = "http://47.100.167.109/qm/info/api/list.do"
        //2.获取请求参数
        let parameters = ["type" : type ?? 0,  "fuzzy" : fuzzy  ,"pageNum" :pageNum , "pageSize" : 10] as [String : Any]
        //3.发送请求参数
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            //获取字典数据
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            //将数组数据回调给外界控制器
            finished(resultDict, error)
        }
    }
    
}

