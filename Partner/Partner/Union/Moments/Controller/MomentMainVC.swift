//
//  MomentMainVC.swift
//  Partner
//
//  Created by LiuXinQiang on 2018/1/31.
//

import UIKit
import SDWebImage
import JXPhotoBrowser
import MJRefresh
import NVActivityIndicatorView

var tabBarHeight: CGFloat {
    set {
        
    }
    get {
        if isIPHONEX {
            return 83
        } else {
            return 49
        }
    }
}

class MomentMainVC: UIViewController , UITableViewDelegate, UITableViewDataSource ,PhotoBrowserDelegate {
    @IBOutlet weak var momentTableView: UITableView!
    var  modelView =  [UnionListModel]()
    var  statusViewModelArr = StatusViewModel()
    var   browser : PhotoBrowser?
    var   picStrsArr : [String]?
    var   collectionView : UICollectionView?
    var   type  =  1 {
        didSet{
        self.pageNum = 1
        self.nextPage = 1
        self.modelView.removeAll()
        loadStatuses()
        }
    } //全部动态 2 感兴趣的人
    //初始化pageNums
    var   pageNum  = 1
    //标记nextPage 是否为空
    var   nextPage = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        momentTableView.rowHeight = UITableViewAutomaticDimension
        momentTableView.estimatedRowHeight = 200
        momentTableView.separatorStyle = .none
        //加载动画
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(AppDelegate.activityData)
        loadRefreshComponet(tableView: momentTableView)
        loadStatuses()
        
        //添加按钮
        self.addPushBtn()
    }
    @IBAction func fliterDymaticClick(_ sender: Any) {
        let alert = UIAlertController(title: "请选择筛选类型", message: "", preferredStyle: .actionSheet)
        let allDaymatic = UIAlertAction(title: "全部动态", style: .default) { [weak self](_) in
            self?.type = 1
        }
        let intrestedDaymatic = UIAlertAction(title: "我感兴趣", style: .default) { [weak self](_) in
            self?.type = 2
        }
        let cancelBtn = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alert.addAction(allDaymatic)
        alert.addAction(intrestedDaymatic)
        alert.addAction(cancelBtn)
        self.present(alert, animated: true, completion: nil)
        
        
    }
    //生成照片控制器
    func addPictrueVC(){
        // 创建实例，传入present发起者，和delegate实现者
        browser = PhotoBrowser(showByViewController: self, delegate: self as PhotoBrowserDelegate)
        browser?.pageControlDelegate = PhotoBrowserNumberPageControlDelegate(numberOfPages: (self.picStrsArr?.count)!)
    }
    
        // 作为delegate必须实现的协议方法
        /// 图片总数
        func numberOfPhotos(in photoBrowser: PhotoBrowser) -> Int {
            return (picStrsArr?.count)!
        }
        /// 缩放起始视图
        func photoBrowser(_ photoBrowser: PhotoBrowser, thumbnailViewForIndex index: Int) -> UIView? {
            return collectionView?.cellForItem(at: IndexPath(item: index, section: 0))
        }
        /// 图片加载前的placeholder
        func photoBrowser(_ photoBrowser: PhotoBrowser, thumbnailImageForIndex index: Int) -> UIImage? {
            let cell = collectionView?.cellForItem(at: IndexPath(item: index, section: 0)) as?  PicCollectionViewCell
            // 取thumbnailImage
            return cell?.pictureCellView.image
        }
        /// 高清图
        func photoBrowser(_ photoBrowser: PhotoBrowser, highQualityUrlForIndex index: Int) -> URL? {
            return nil
        }
}


//初始化加载控件
extension  MomentMainVC {
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
          self.modelView.removeAll()
          loadStatuses()
//          momentTableView.mj_header.endRefreshing()
    }
    @objc func  endrefresh() -> (){
          loadStatuses()
    }
    
}





extension MomentMainVC {
  fileprivate   func loadStatuses() {
        if  self.nextPage == 0 {
            self.momentTableView.mj_footer.endRefreshingWithNoMoreData()
            return
        }
        guard let access_token = UserDefaults.standard.string(forKey: "token") else{
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            self.presentAlert(title: "您还未登录", hint: "", confirmTitle: "登录", cancelTitle: "取消", confirmation: { (action) in
                let  navRegistAndLoginVC = UINavigationController.init(rootViewController: AppDelegate.RegisterAndLoginVC)
                self.present(navRegistAndLoginVC, animated: true, completion: nil)
            }, cancel: nil)
            return
        }
        NetWorkTool.shareInstance.getSocialCircleMomentList(token: access_token, type: type, pageNum: pageNum) { [weak self](result, error) in
            if error != nil {
                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                return }
            if  result?["code"] as? Int == 200  {
            guard let resultArray = result else{
                return
            }
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()

            self?.momentTableView.mj_header.endRefreshing()
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
                    let model =  UnionListModel.mj_object(withKeyValues: dict)
                    self?.modelView.append(model!)
                }
                self?.momentTableView.mj_footer.endRefreshing()
                self?.momentTableView.reloadData()
            }
            self?.cacheImages((self?.modelView)!)
           }else{
                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                let  errorShow  =  result!["msg"] as! String
                self?.presentHintMessage(hintMessgae: errorShow, completion: nil)
            }
         }
    }
    
    fileprivate func cacheImages(_ viewModels: [UnionListModel]) {
        let group = DispatchGroup()
        for viewModel in viewModels {
            if let urls = viewModel.imgUrls {
                for picStr in urls {
                    group.enter()
                    let picURL = URL(string: picStr as String)
                    SDWebImageManager.shared().imageDownloader?.downloadImage(with: picURL, options: [], progress: nil, completed: { (_, _, _, _) in
                        group.leave()
                    })
                }
            }
        }
        
        group.notify(queue: DispatchQueue.main) {
            self.momentTableView.reloadData()
        }
    }
}

extension MomentMainVC {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.modelView.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StatusViewCell") as!  StatusViewCell
        cell.showVCClouse = {(momentId) in
            //DynamicDetailVCID
              let dynamicDetailVC  = AppDelegate.dynamicDetailVC
            dynamicDetailVC.momentId = momentId
            dynamicDetailVC.refresh()

            self.navigationController?.pushViewController(dynamicDetailVC, animated: true)
        }
        cell.pushVC = {(id) in
            let  uid = UserDefaults.standard.integer(forKey: "uid")
            if id == uid {
                let  showProviderVC = UIStoryboard.init(name: "MyHomePage", bundle: nil).instantiateViewController(withIdentifier: "MyHomePageViewControllerID") as! MyHomePageViewController
                self.navigationController?.pushViewController(showProviderVC, animated: true)
            }else{
                let  showProviderVC = UIStoryboard.init(name: "InvestFinance", bundle: nil).instantiateViewController(withIdentifier: "ServiceInvestorProfileViewControllerID") as! ServiceInvestorProfileViewController
                showProviderVC.id = id
                self.navigationController?.pushViewController(showProviderVC, animated: true)
            }
        }
        if  modelView.count > 0  { cell.viewModel = modelView[indexPath.row]}
    
        // 显示，并指定打开第几张图
        cell.pictureView.pushImageClouse = {[weak self](tempPictureView ,index , strArr) in
            self?.picStrsArr  =  strArr
            self?.addPictrueVC()
            self?.collectionView = tempPictureView
            self?.browser?.show(index: index.row)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dynamicDetailVC  = AppDelegate.dynamicDetailVC
        if  modelView.count > 0  {
           let viewModel = modelView[indexPath.row]
            dynamicDetailVC.momentId = viewModel.momentId as? Int
            dynamicDetailVC.refresh()
            self.navigationController?.pushViewController(dynamicDetailVC, animated: true)
        }
    }

}


extension  MomentMainVC{
//添加发布按钮
func   addPushBtn(){
//    print(self.tabBarController?.tabBar.frame.height)
  
    let  btn = UIButton.init(frame: CGRect.init(x: screenWidth - 58 , y: screenHeight - 64 - (self.tabBarController?.tabBar.frame.height)! - 76, width: 46, height: 46))
    btn.addTarget(self, action: #selector(pushSendOutVC), for: .touchUpInside)
    btn.setImage(UIImage.init(named: "pushBtn"), for: .normal)
    self.view.addSubview(btn)
    
}
    
    @objc func pushSendOutVC(){
        
        let statusPushVC  = UIStoryboard(name: "Union", bundle: nil).instantiateViewController(withIdentifier: "StatusPushVCID") as!  StatusPushVC
        self.navigationController?.pushViewController(statusPushVC, animated: true)
    }

}







