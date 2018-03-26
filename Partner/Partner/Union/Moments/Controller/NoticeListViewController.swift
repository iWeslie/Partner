//
//  NoticeListViewController.swift
//  Partner
//
//  Created by LiuXinQiang on 2018/2/28.
//

import UIKit
import SDWebImage
import JXPhotoBrowser
import MJRefresh
import NVActivityIndicatorView
class NoticeListViewController: UIViewController ,UITableViewDelegate ,UITableViewDataSource{
    //初始化pageNums
    var   pageNum  = 1
    //标记nextPage 是否为空
    var   nextPage = 1
    var  type : Int?
    @IBOutlet weak var noticeTableView: UITableView!
    @IBOutlet weak var topTitleLab: UIButton!
    var  modelArr = [NoticeSocialConnListModel]()
    var  statusViewModelArr = StatusViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        noticeTableView.delegate = self
        noticeTableView.dataSource = self
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(AppDelegate.activityData)
        loadRefreshComponet(tableView: noticeTableView)
        
        if type == 0 {
           loadNotice()
            topTitleLab.setTitle("社联通知", for: .normal)
        }else if type == 1{
            loadServiceNotice()
            topTitleLab.setTitle("服务动态消息", for: .normal)
        }else if type  == 2 {
            topTitleLab.setTitle("合伙人小助手", for: .normal)
            loadHelperNotice()
        }
    }
    
    @IBAction func dismissAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
    fileprivate   func loadNotice() {
        if  self.nextPage == 0 {
            self.noticeTableView.mj_footer.endRefreshingWithNoMoreData()
            return
        }
        guard let access_token = UserDefaults.standard.string(forKey: "token") else{
            self.presentHintMessage(hintMessgae: "您尚未登录", completion: nil)
            return
        }
        NetWorkTool.shareInstance.getNoticeSocialConnList(token: access_token, pageNum: pageNum) { [weak self](result, error) in
            if error != nil {
                return }
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            if  result?["code"] as? Int == 200  {
                guard let resultArray = result else{
                    return
                }
                self?.noticeTableView.mj_header.endRefreshing()
                let dict  =   resultArray["result"] as? NSDictionary
                if  let statusViewModel = StatusViewModel.mj_object(withKeyValues: dict)
                {
                    self?.statusViewModelArr =  statusViewModel
                    if self?.statusViewModelArr.nextPage == 0 {
                        self?.nextPage = 0
                    }else{
                        self?.nextPage = self?.statusViewModelArr.nextPage as! Int
                    }
                    self?.pageNum += 1
                }
                
                if  let listDict = dict!["list"] as? [NSDictionary]  {
                    for dict in listDict{
                        let model =  NoticeSocialConnListModel.mj_object(withKeyValues: dict)
                        self?.modelArr.append(model!)
                    }
                    self?.noticeTableView.mj_footer.endRefreshing()
                    NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                    self?.noticeTableView.reloadData()
                }
            }else{
                let  errorShow  =  result!["msg"] as! String
                self?.presentHintMessage(hintMessgae: errorShow, completion: nil)
            }
        }
    }
    
    
    fileprivate  func loadServiceNotice() {
        if  self.nextPage == 0 {
            self.noticeTableView.mj_footer.endRefreshingWithNoMoreData()
            return
        }
        guard let access_token = UserDefaults.standard.string(forKey: "token") else{
            self.presentHintMessage(hintMessgae: "您尚未登录", completion: nil)
            return
        }
        NetWorkTool.shareInstance.getSeriviceList(token: access_token, pageNum: pageNum) { [weak self](result, error) in
            if error != nil {
                return }
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            if  result?["code"] as? Int == 200  {
                guard let resultArray = result else{
                    return
                }
                self?.noticeTableView.mj_header.endRefreshing()
                let dict  =   resultArray["result"] as? NSDictionary
                if  let statusViewModel = StatusViewModel.mj_object(withKeyValues: dict)
                {
                    self?.statusViewModelArr =  statusViewModel
                    if self?.statusViewModelArr.nextPage == 0 {
                        self?.nextPage = 0
                    }else{
                        self?.nextPage = self?.statusViewModelArr.nextPage as! Int
                    }
                    self?.pageNum += 1
                }
                
                if  let listDict = dict!["list"] as? [NSDictionary]  {
                    for dict in listDict{
                        let model =  NoticeSocialConnListModel.mj_object(withKeyValues: dict)
                        self?.modelArr.append(model!)
                    }
                    self?.noticeTableView.mj_footer.endRefreshing()
                    NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                    self?.noticeTableView.reloadData()
                }
            }else{
                let  errorShow  =  result!["msg"] as! String
                self?.presentHintMessage(hintMessgae: errorShow, completion: nil)
            }
        }
    }
    
    //小助手通知列表（notice/api/helper/list）
    fileprivate  func loadHelperNotice() {
        if  self.nextPage == 0 {
            self.noticeTableView.mj_footer.endRefreshingWithNoMoreData()
            return
        }
        guard let access_token = UserDefaults.standard.string(forKey: "token") else{
            self.presentHintMessage(hintMessgae: "您尚未登录", completion: nil)
            return
        }
        NetWorkTool.shareInstance.gethelperList(token: access_token, pageNum: pageNum) { [weak self](result, error) in
            if error != nil {
                return }
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            if  result?["code"] as? Int == 200  {
                guard let resultArray = result else{
                    return
                }
                self?.noticeTableView.mj_header.endRefreshing()
                let dict  =   resultArray["result"] as? NSDictionary
                if  let statusViewModel = StatusViewModel.mj_object(withKeyValues: dict)
                {
                    self?.statusViewModelArr =  statusViewModel
                    if self?.statusViewModelArr.nextPage == 0 {
                        self?.nextPage = 0
                    }else{
                        self?.nextPage = self?.statusViewModelArr.nextPage as! Int
                    }
                    self?.pageNum += 1
                }
                
                if  let listDict = dict!["list"] as? [NSDictionary]  {
                    for dict in listDict{
                        let model =  NoticeSocialConnListModel.mj_object(withKeyValues: dict)
                        self?.modelArr.append(model!)
                    }
                    self?.noticeTableView.mj_footer.endRefreshing()
                    NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                    self?.noticeTableView.reloadData()
                }
            }else{
                let  errorShow  =  result!["msg"] as! String
                self?.presentHintMessage(hintMessgae: errorShow, completion: nil)
            }
        }
    }
}


extension NoticeListViewController {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return modelArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if type == 0 {
      
        }else if type == 1{
            let destVC = UIStoryboard.init(name: "MyProject", bundle: nil).instantiateViewController(withIdentifier: "MyProjectReview") as! MyProjectReviewViewController
            if modelArr.count > 0 {
                let model = modelArr[indexPath.row]
                destVC.projID = model.projectId as? Int
                self.navigationController?.pushViewController(destVC, animated: true)
            }
        }else if type  == 2 {
            let destVC = UIStoryboard.init(name: "Auth", bundle: nil).instantiateViewController(withIdentifier: "AuthApplyUploadViewControllerID") as!  AuthApplyUploadViewController
                self.navigationController?.pushViewController(destVC, animated: true)
        }
     
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell.init()
        if type == 0 {
           let  tempCell = tableView.dequeueReusableCell(withIdentifier: "NoticeSocialConnListCellID", for: indexPath) as! NoticeSocialConnListCell
            if  modelArr.count > 0 {
            tempCell.viewModel = modelArr[indexPath.row]
            }
            cell = tempCell
        }else {
              let  tempCell = tableView.dequeueReusableCell(withIdentifier: "ServiceListCellID", for: indexPath) as! ServiceListCell
            if type == 2 {
                tempCell.imageHeaderView?.image = #imageLiteral(resourceName: "noticeFile")
            }
            if  modelArr.count > 0 {
                tempCell.viewModel = modelArr[indexPath.row]
            }
           cell = tempCell
        }
        return cell
    }
}

//初始化加载控件
extension  NoticeListViewController {
    func loadRefreshComponet(tableView : UITableView) -> () {
        //默认下拉刷新
        tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(refresh))
        //上拉刷新
        tableView.mj_footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: #selector(endrefresh))
        //自动根据有无数据来显示和隐藏
        tableView.mj_footer.isAutomaticallyHidden = true
        // 设置自动切换透明度(在导航栏下面自动隐藏)
        tableView.mj_header.isAutomaticallyChangeAlpha = true
    }
    
    @objc func refresh() -> () {
        self.pageNum = 1
        self.nextPage = 1
        self.modelArr.removeAll()
        if type == 0 {
            loadNotice()
        }else if type == 1{
            loadServiceNotice()
        }else if type  == 2 {
            loadHelperNotice()
        }
    }
    @objc func  endrefresh() -> (){
        if type == 0 {
            loadNotice()
        }else if type == 1{
            loadServiceNotice()
        }else if type  == 2 {
            loadHelperNotice()
        }
    }
    
}
