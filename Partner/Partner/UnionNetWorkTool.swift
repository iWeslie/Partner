//
//  UnionNetWorkTool.swift
//  Partner
//
//  Created by LiuXinQiang on 2018/1/31.
//

import UIKit

extension NetWorkTool {
    //删除通知（notice/api/delete）
    //http://47.100.167.109/qm/notice/api/delete.do
    func apiDelete(token:String , type:Int , id : Int,finished:@escaping (_ result : [String : AnyObject]? ,_ error:Error?) ->()){
        //1.获取请求的URLString
        let urlString = "http://47.100.167.109/qm/notice/api/delete.do"
        //2.获取请求参数
        let parameters = ["token" : token ,"id" : id , "type" :type] as [String : Any]
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
    
    //清空通知（notice/api/clear）
    func apiClear(token:String , type:Int ,finished:@escaping (_ result : [String : AnyObject]? ,_ error:Error?) ->()){
        //1.获取请求的URLString
        let urlString = "http://47.100.167.109/qm/notice/api/clear.do"
        //2.获取请求参数
        let parameters = ["token" : token , "type" :type] as [String : Any]
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
    
    //删除圈子成员（圈子创建者）
    func memberDelete(token:String , circleId:Int , userId :Int , finished:@escaping (_ result : [String : AnyObject]? ,_ error:Error?) ->()){
        //1.获取请求的URLString
        let urlString = "http://47.100.167.109/qm/circle/api/member/delete.do"
        //2.获取请求参数
        let parameters = ["token" : token , "circleId" :circleId , "userId":userId] as [String : Any]
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
    
    
    
    // MARK:- 屏蔽动态（moment/ignore）
    func momentIgnore(token:String ,id : Int,finished:@escaping (_ result : [String : AnyObject]? ,_ error:Error?) ->()){
        //1.获取请求的URLString
        let urlString = "http://47.100.167.109/qm/moment/api/ignore.do"
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

    
   //MARK: -点赞动态（moment/thumb）
    func getNmomentThumb(token:String ,id : Int,finished:@escaping (_ result : [String : AnyObject]? ,_ error:Error?) ->()){
        //1.获取请求的URLString
        let urlString = "http://47.100.167.109/qm/moment/api/thumb.do"
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
    
    // MARK:- 点赞评论（moment/comment/thumb）
    func commentThumb(token:String ,id : Int,finished:@escaping (_ result : [String : AnyObject]? ,_ error:Error?) ->()){
        //1.获取请求的URLString
        let urlString = "http://47.100.167.109/qm/moment/api/comment/thumb.do"
        //2.获取请求参数
        let parameters = ["token" : token ,"commentId" : id] as [String : Any]
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
    
    //MARK: - 取消点赞动态（moment/cancelThumb）
    func cancelThumb(token:String ,id : Int,finished:@escaping (_ result : [String : AnyObject]? ,_ error:Error?) ->()){
        //1.获取请求的URLString
        let urlString = "http://47.100.167.109/qm/moment/api/cancelThumb.do"
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
    
    //8.13.取消点赞评论（moment/cancelThumb）
    func cancelCommentThumb(token:String ,id : Int,finished:@escaping (_ result : [String : AnyObject]? ,_ error:Error?) ->()){
        //1.获取请求的URLString
        let urlString = "http://47.100.167.109/qm/moment/api/comment/cancelThumb.do"
        //2.获取请求参数
        let parameters = ["token" : token ,"commentId" : id] as [String : Any]
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
    
    //MARK: - 8.6.动态详情（moment/detail）
    func momentDetail(token:String ,id : Int,finished:@escaping (_ result : [String : AnyObject]? ,_ error:Error?) ->()){
        //1.获取请求的URLString
        let urlString = "http://47.100.167.109/qm/moment/api/detail.do"
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
    
    // MARK:- 删除评论（moment/deleteComment）
    func deleteComment(token:String ,commentId : Int,finished:@escaping (_ result : [String : AnyObject]? ,_ error:Error?) ->()){
        //1.获取请求的URLString
        let urlString = "http://47.100.167.109/qm/moment/api/deleteComment.do"
        //2.获取请求参数
        let parameters = ["token" : token ,"commentId" : commentId] as [String : Any]
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
    
    
   // 删除动态（moment/delete）
    func deleteMoment(token:String ,id : Int,finished:@escaping (_ result : [String : AnyObject]? ,_ error:Error?) ->()){
        //1.获取请求的URLString
        let urlString = "http://47.100.167.109/qm/moment/api/delete.do"
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
    
  //评论（moment/comment）
    func momentComment(token:String ,  type : Int ,  momentId : Int , parentId : Int?, commContent : String, socialCircleId : Int?,  finished:@escaping (_ result : [String : AnyObject]? ,_ error:Error?) ->()){
        //1.获取请求的URLString
        let urlString = "http://47.100.167.109/qm/moment/api/comment.do"
        //2.获取请求参数
        let parameters = ["token" : token ,"type" : type , "momentId" : momentId , "parentId" : parentId,"commContent" : commContent , "socialCircleId" : socialCircleId] as [String : Any]
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
