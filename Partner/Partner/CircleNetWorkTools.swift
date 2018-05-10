//
//  CircleNetWorkTools.swift
//  Partner
//
//  Created by LiuXinQiang on 2018/3/1.
//

//
//  UnionNetWorkTool.swift
//  Partner
//
//  Created by LiuXinQiang on 2018/1/31.
//

import UIKit

extension NetWorkTool {
    //发布动态（moment/send）
    func momentSend(token:String , circleIds : String? , momeContent : String , momePublic : Int?, image : [UIImage]? , finished:@escaping (_ result : [String : AnyObject]? ,_ error:Error?) ->()){
        //1.获取请求的URLString
        let urlString = "http://47.100.167.109/qm/moment/api/send.do"
        //2.获取请求参数
        var parameters = ["token" : token , "moment.momeContent" : momeContent ,"moment.momePublic" : momePublic ?? 1 ,"moment.socialCircleId" : circleIds] as [String : Any]
        //"circleIds" : circleIds ,
//        if momePublic == 2 {
//            parameters.updateValue(circleIds ?? "", forKey: "circleIds")
//        }
        //3.发送请求参数
        post(urlString, parameters: parameters, constructingBodyWith: { [weak self](formData) in
            //upload avatar
            if image != nil {
                let cateName = "images"
                let count = image!.count as Int
                guard count != 1 else{
                    return
                }
                for i in 0..<count-1 {
                    let  pic = image![i]
                    let  img  = (self?.resizeImage(originalImg: pic))!
                    if let imageData = UIImageJPEGRepresentation(img, 0.5){
                        print(img.size.height)
                        print(img.size.width)

                        let imageName =  self?.getNowTime()
                        formData.appendPart(withFileData: imageData, name: cateName, fileName: imageName! , mimeType: "image/png")
                    }
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
    
    
    private func resizeImage(originalImg:UIImage) -> UIImage{
        
        //prepare constants
        let width = originalImg.size.width
        let height = originalImg.size.height

        let scale = width/height
        
        var sizeChange = CGSize()
        
        if width <= 1280 && height <= 1280{ //a，图片宽或者高均小于或等于1280时图片尺寸保持不变，不改变图片大小
            return originalImg
        }else if width > 1280 || height > 1280 {//b,宽或者高大于1280，但是图片宽度高度比小于或等于2，则将图片宽或者高取大的等比压缩至1280
            
            if scale <= 2 && scale >= 1 {
                let changedWidth:CGFloat = 1280
                let changedheight:CGFloat = changedWidth / scale
                sizeChange = CGSize(width: changedWidth, height: changedheight)
                
            }else if scale >= 0.5 && scale <= 1 {
                
                let changedheight:CGFloat = 1280
                let changedWidth:CGFloat = changedheight * scale
                sizeChange = CGSize(width: changedWidth, height: changedheight)
                
            }else if width > 1280 && height > 1280 {//宽以及高均大于1280，但是图片宽高比大于2时，则宽或者高取小的等比压缩至1280
                
                if scale > 2 {//高的值比较小
                    
                    let changedheight:CGFloat = 1280
                    let changedWidth:CGFloat = changedheight * scale
                    sizeChange = CGSize(width: changedWidth, height: changedheight)
                    
                }else if scale < 0.5{//宽的值比较小
                    
                    let changedWidth:CGFloat = 1280
                    let changedheight:CGFloat = changedWidth / scale
                    sizeChange = CGSize(width: changedWidth, height: changedheight)
                    
                }
            }else {//d, 宽或者高，只有一个大于1280，并且宽高比超过2，不改变图片大小
                return originalImg
            }
        }
        
        UIGraphicsBeginImageContext(sizeChange)
        
        //draw resized image on Context
        originalImg.draw(in: CGRect.init(x: 0, y: 0, width: sizeChange.width, height: sizeChange.height))
        //create UIImage
        let resizedImg = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return resizedImg!
        
    }
    
    
    
    
    
    
    
    //我的圈子列表（发布动态接口使用）（circle/getMyCircleEntityList）
    func getMyCircleEntityList(token:String ,finished:@escaping (_ result : [String : AnyObject]? ,_ error:Error?) ->()){
        //1.获取请求的URLString
        let urlString = "http://47.100.167.109/qm/circle/api/getMyCircleEntityList.do"
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
    
    //轮播图列表（carousel/list）
    func getCarouselList(finished:@escaping (_ result : [String : AnyObject]? ,_ error:Error?) ->()){
        //1.获取请求的URLString
        let urlString = "http://47.100.167.109/qm/carousel/api/list.do"
        //2.获取请求参数
        let parameters = ["type" : 1] as [String : Any]
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
    
    
    func getSocialCircleMomentList(token:String , type : Int , pageNum : Int, finished:@escaping (_ result : [String : AnyObject]? ,_ error:Error?) ->()){
        //1.获取请求的URLString
        let urlString = "http://47.100.167.109/qm/moment/api/getSocialConnMomentList.do"
        //2.获取请求参数
        let parameters = ["token" : token , "type" : type, "pageNum" : pageNum] as [String : Any]
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
    
    //8.8.社圈页面动态列表（moment/getSocialCircleMomentList）
    func getCircleMomentList(token:String , type : Int , pageNum : Int, finished:@escaping (_ result : [String : AnyObject]? ,_ error:Error?) ->()){
        //1.获取请求的URLString
        let urlString = "http://47.100.167.109/qm/moment/api/getSocialCircleMomentList.do"
        //2.获取请求参数
        let parameters = ["token" : token , "circleId" : type, "pageNum" : pageNum] as [String : Any]
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
    //用户个人主页动态列表（moment/getMyHomePageMomentList）
    func getMyHomePageMomentList(token:String , userId : Int , pageNum : Int, finished:@escaping (_ result : [String : AnyObject]? ,_ error:Error?) ->()){
        //1.获取请求的URLString
        let urlString = "http://47.100.167.109/qm/moment/api/getMyHomePageMomentList.do"
        //2.获取请求参数
        let parameters = ["token" : token , "pageSize" : 10, "pageNum" : pageNum] as [String : Any]
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
    
    //
    func getUserHomePageMomentList(token:String , userId : Int , pageNum : Int, finished:@escaping (_ result : [String : AnyObject]? ,_ error:Error?) ->()){
        //1.获取请求的URLString
        let urlString = "http://47.100.167.109/qm/moment/api/getUserHomePageMomentList.do"
        //2.获取请求参数
        let parameters = ["token" : token , "userId" : userId, "pageNum" : pageNum] as [String : Any]
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
    
    
    
    //http://47.100.167.109/qm/circle/api/getMyCircleList.do
    //我的圈子列表（circle/getMyCircleList）
    func getMyCircleList(token:String ,finished:@escaping (_ result : [String : AnyObject]? ,_ error:Error?) ->()){
        //1.获取请求的URLString
        let urlString = "http://47.100.167.109/qm/circle/api/getMyCircleList.do"
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
    
    //其他圈子列表（circle/getOtherCircleList）
    func getOtherCircleList(token:String , pageNum : Int , pageSize : Int, finished:@escaping (_ result : [String : AnyObject]? ,_ error:Error?) ->()){
        //1.获取请求的URLString
        let urlString = "http://47.100.167.109/qm/circle/api/getOtherCircleList.do"
        //2.获取请求参数
        let parameters = ["token" : token ,"pageNum" : pageNum, "pageSize" : pageSize] as [String : Any]
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
    
    
    // 创建圈子
    func circleCreated(token:String , membIds : String , circName : String, circDesc : String? , image : UIImage? , finished:@escaping (_ result : [String : AnyObject]? ,_ error:Error?) ->()){
        //1.获取请求的URLString
        let urlString = "http://47.100.167.109/qm/circle/api/create.do"
        //2.获取请求参数
        let parameters = ["token" : token ,"circle.circName" : circName, "circle.circDesc" : circDesc ,"membIds" : membIds] as [String : Any]
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
    
    
    // 获取成员 搜索用户
    func searchUserList(token:String , type : Int , fuzzy : String, circleId : Int?,finished:@escaping (_ result : [String : AnyObject]? ,_ error:Error?) ->()){
        //1.获取请求的URLString
        let urlString = "http://47.100.167.109/qm/user/api/circle/searchUserList.do"
        //2.获取请求参数
        let parameters = ["token" : token ,"type" : type, "circleId" : circleId , "fuzzy" : fuzzy] as [String : Any]
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
    
    
    //获取圈详情 getCircleDetailInfo
    func getCircleDetailInfo(token:String , id : Int ,finished:@escaping (_ result : [String : AnyObject]? ,_ error:Error?) ->()){
        //1.获取请求的URLString
        let urlString = "http://47.100.167.109/qm/circle/api/getCircleDetailInfo.do"
        //2.获取请求参数
        let parameters = ["token" : token ,"id" : id] as [String : Any]
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
    
    
    //getCircleSetInfo
    func getCircleSetInfo(token:String , id : Int ,finished:@escaping (_ result : [String : AnyObject]? ,_ error:Error?) ->()){
        //1.获取请求的URLString
        let urlString = "http://47.100.167.109/qm/circle/api/getCircleSetInfo.do"
        //2.获取请求参数
        let parameters = ["token" : token ,"id" : id] as [String : Any]
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
    
    
    
    // 修改圈子基本信息（圈子设置页面）（circle/updateSocialCircle）
    //type
    //类型，1修改圈子名称 2封面 3描述
    
    func updateSocialCircle(token : String , circleId : Int , type : Int, circleName : String?, image : UIImage?, desc : String?, finished:@escaping (_ result : [String : AnyObject]? ,_ error:Error?) ->()){
        //1.获取请求的URLString
        let urlString = "http://47.100.167.109/qm/circle/api/updateSocialCircle.do"
        //2.获取请求参数
        let parameters = ["token" : token ,"circleId" : circleId ,"type" : type , "circleName" : circleName ?? "", "desc" :desc ?? "" ] as [String : Any]
        //3.发送请求参数
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
    
    
    //解散圈子（circle/dissolveCircle）
    func dissolveCircle(token:String , id : Int ,finished:@escaping (_ result : [String : AnyObject]? ,_ error:Error?) ->()){
        //1.获取请求的URLString
        let urlString = "http://47.100.167.109/qm/circle/api/dissolveCircle.do"
        //2.获取请求参数
        let parameters = ["token" : token ,"id" : id] as [String : Any]
        //3.发送请求参数
        request(.POST , urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            //获取字典数据
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            //将数组数据回调给外界控制器
            finished(resultDict, error)
        }
    }
    
    //    退出圈子（circle/withdrawCircle）
    func withdrawCircle(token:String , id : Int ,finished:@escaping (_ result : [String : AnyObject]? ,_ error:Error?) ->()){
        //1.获取请求的URLString
        let urlString = "http://47.100.167.109/qm/circle/api/withdrawCircle.do"
        //2.获取请求参数
        let parameters = ["token" : token ,"id" : id] as [String : Any]
        //3.发送请求参数
        request(.POST , urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            //获取字典数据
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            //将数组数据回调给外界控制器
            finished(resultDict, error)
        }
    }
    
    
    
    //获取圈子成员列表（circle/getCircleMemberList）
    func getCircleMemberList(token:String , id : Int ,finished:@escaping (_ result : [String : AnyObject]? ,_ error:Error?) ->()){
        //1.获取请求的URLString
        let urlString = "http://47.100.167.109/qm/circle/api/getCircleMemberList.do"
        //2.获取请求参数
        let parameters = ["token" : token ,"id" : id] as [String : Any]
        //3.发送请求参数
        request(.POST , urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            //获取字典数据
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            //将数组数据回调给外界控制器
            finished(resultDict, error)
        }
    }
    
    
    //邀请加入圈子 – 圈子创建者（circle/inviteJoin）
    func inviteJoin(token:String , id : Int , userId : Int, finished:@escaping (_ result : [String : AnyObject]? ,_ error:Error?) ->()){
        //1.获取请求的URLString
        let urlString = "http://47.100.167.109/qm/circle/api/inviteJoin.do"
        //2.获取请求参数
        let parameters = ["token" : token ,"id" : id , "userId" : userId] as [String : Any]
        //3.发送请求参数
        request(.POST , urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            //获取字典数据
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            //将数组数据回调给外界控制器
            finished(resultDict, error)
        }
    }
    
    
    //9.10.申请加入圈子 – 非圈子创建者（circle/applyJoin）
    func applyJoin(token:String , id : Int , finished:@escaping (_ result : [String : AnyObject]? ,_ error:Error?) ->()){
        //1.获取请求的URLString
        let urlString = "http://47.100.167.109/qm/circle/api/applyJoin.do"
        //2.获取请求参数
        let parameters = ["token" : token ,"id" : id] as [String : Any]
        //3.发送请求参数
        request(.POST , urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            //获取字典数据
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            //将数组数据回调给外界控制器
            finished(resultDict, error)
        }
    }
    
    
    //举报原因列表（report/getReportReasonList）
    func getReportReasonListinviteJoin(finished:@escaping (_ result : [String : AnyObject]? ,_ error:Error?) ->()){
        //1.获取请求的URLString
        let urlString = "http://47.100.167.109/qm/report/api/getReportReasonList.do"
        //2.获取请求参数
        let parameters = [:] as [String : Any]
        //3.发送请求参数
        request(.POST , urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            //获取字典数据
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            //将数组数据回调给外界控制器
            finished(resultDict, error)
        }
    }
    
    // 举报（report/report）
    func report(token:String , repoType : Int , reaId : Int, id :Int, finished:@escaping (_ result : [String : AnyObject]? ,_ error:Error?) ->()){
        //1.获取请求的URLString
        let urlString = "http://47.100.167.109/qm/report/api/report.do"
        //2.获取请求参数
        let parameters = ["token" : token ,"repoType" : repoType, "reaId" : reaId, "id" :id] as [String : Any]
        //3.发送请求参数
        request(.POST , urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            //获取字典数据
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            //将数组数据回调给外界控制器
            finished(resultDict, error)
        }
    }
    
    
    //通知列表（notice/api/list）
    func getNoticeApiList(token:String ,finished:@escaping (_ result : [String : AnyObject]? ,_ error:Error?) ->()){
        //1.获取请求的URLString
        let urlString = "http://47.100.167.109/qm/notice/api/list.do"
        //2.获取请求参数
        let parameters = ["token" : token] as [String : Any]
        //3.发送请求参数
        request(.POST , urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            //获取字典数据
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            //将数组数据回调给外界控制器
            finished(resultDict, error)
        }
    }
    
    //设置通知已读（notice/api/read）
    func noticeRead(token:String , type : Int ,finished:@escaping (_ result : [String : AnyObject]? ,_ error:Error?) ->()){
        //1.获取请求的URLString
        let urlString = "http://47.100.167.109/qm/notice/api/read.do"
        //类型，1服务动态通知 2社联消息通知 3合伙人客服通知 4合伙人小助手通知
        //2.获取请求参数
        let parameters = ["token" : token, "type" : type] as [String : Any]
        //3.发送请求参数
        request(.POST , urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            //获取字典数据
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            //将数组数据回调给外界控制器
            finished(resultDict, error)
        }
    }
    
    //社联通知列表（notice/api/socialconn/list）
    func getNoticeSocialConnList(token:String ,pageNum : Int,finished:@escaping (_ result : [String : AnyObject]? ,_ error:Error?) ->()){
        //1.获取请求的URLString
        let urlString = "http://47.100.167.109/qm/notice/api/socialconn/list.do"
        //2.获取请求参数
        let parameters = ["token" : token ,"pageNum" : pageNum] as [String : Any]
        //3.发送请求参数
        request(.POST , urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            //获取字典数据
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            //将数组数据回调给外界控制器
            finished(resultDict, error)
        }
    }
    
    //.服务通知列表（notice/api/service/list）http://47.100.167.109/qm/notice/api/service/list.do
    func getSeriviceList(token:String ,pageNum : Int,finished:@escaping (_ result : [String : AnyObject]? ,_ error:Error?) ->()){
        //1.获取请求的URLString
        let urlString = "http://47.100.167.109/qm/notice/api/service/list.do"
        //2.获取请求参数
        let parameters = ["token" : token ,"pageNum" : pageNum] as [String : Any]
        //3.发送请求参数
        request(.POST , urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            //获取字典数据
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            //将数组数据回调给外界控制器
            finished(resultDict, error)
        }
    }
    
    //13.7.小助手通知列表（notice/api/helper/list）
    func gethelperList(token:String ,pageNum : Int,finished:@escaping (_ result : [String : AnyObject]? ,_ error:Error?) ->()){
        //1.获取请求的URLString
        let urlString = "http://47.100.167.109/qm/notice/api/helper/list.do"
        //2.获取请求参数
        let parameters = ["token" : token ,"pageNum" : pageNum] as [String : Any]
        //3.发送请求参数
        request(.POST , urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            //获取字典数据
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            //将数组数据回调给外界控制器
            finished(resultDict, error)
        }
    }


    
    //审核圈子成员 - 申请/受邀请（circle/api/member/approve）
    func getCircleMemberApprove(token:String ,circleMembId:Int, type:Int, op : Int, userId : Int,finished:@escaping (_ result : [String : AnyObject]? ,_ error:Error?) ->()){
        //1.获取请求的URLString
        let urlString = "http://47.100.167.109/qm/circle/api/member/approve.do"
        //2.获取请求参数
        let parameters = ["token" : token ,"circleMembId" : circleMembId,"type" : type ,"op":op, "userId":userId] as [String : Any]
        //3.发送请求参数
        request(.POST , urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
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

