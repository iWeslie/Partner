//
//  HomeViewController.swift
//  Partner
//
//  Created by Weslie on 19/01/2018.
//

import UIKit
import MJExtension

class VersionModel: NSObject {
    @objc var version: String?
}

class HomeViewController: UIViewController {
    
    var version: String? {
        didSet {
            if version! > localVersion {
                let alert = UIAlertController(title: "提示", message: "有新版本可供下载，确定更新吗？", preferredStyle: .alert)
                
                let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
                let confirm = UIAlertAction(title: "确定", style: .default) { (_) in
                    let url = URL(string: "https://itunes.apple.com/us/app/id1360096509?ls=1&mt=8")!
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
                alert.addAction(cancel)
                alert.addAction(confirm)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }

    @IBOutlet weak var topContentView: UIView!
    var   sliderView : UIView?
    //滚动视图
    var   scrollView : UIScrollView?
    
    @IBOutlet weak var loopView: LoopView!
    //滑动Btn数组
    var   sliderBtnArr  = [UIButton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationController?.isNavigationBarHidden = true
        addTopViewChildsBtn()
        addChildScroll()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        NetWorkTool.shareInstance.getITunesVersion { (result, error) in
            if result != nil {
                let resultDict = result?["results"] as! NSArray
                let dict = resultDict.firstObject as! NSDictionary
                let model = VersionModel.mj_object(withKeyValues: dict)
                self.version = model?.version
            }
        }
    }
    
    //初始化头部按钮
    func addTopViewChildsBtn(){
        let  btnArr = ["广场","资讯"]
        let  width  = (screenWidth) / CGFloat(btnArr.count)
        for i in 0..<btnArr.count {
            let  btnStr  = btnArr[i]
            let  x       = CGFloat(i)  * width
            let btn = UIButton.init(frame: CGRect.init(x: x, y: 0, width: width, height: 60))
            btn.contentHorizontalAlignment = .center
            btn.contentVerticalAlignment   = .bottom
            btn.setTitle(btnStr, for: .normal)
            btn.setTitleColor(#colorLiteral(red: 0.7771913409, green: 0.7979340553, blue: 0.8144465089, alpha: 1), for: .normal)
            btn.setTitleColor( #colorLiteral(red: 0.3028550148, green: 0.4081297517, blue: 0.4641876817, alpha: 1),for: .selected)
            btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
            btn.tag = i+1212
            btn.addTarget(self, action: #selector(addOffSetX(btn:)), for: UIControlEvents.touchUpInside)
            sliderBtnArr.append(btn)
            self.topContentView.addSubview(btn)
            if  i == 0 {
                sliderView =  UIView.init()
                sliderView?.center.x = btn.center.x - 6
                sliderView?.frame.origin.y = btn.frame.maxY + 2
                sliderView?.frame.size = CGSize.init(width: 12, height: 3)
                sliderView?.backgroundColor = #colorLiteral(red: 0.2524492443, green: 0.3666573763, blue: 0.4243661463, alpha: 1)
                btn.isSelected = true
                self.topContentView.addSubview(sliderView!)
            }
        }
    }
    
    //添加偏移量功能
    @objc  func   addBtnScroll(btn : UIButton){
        UIView.animate(withDuration: 0.3) {
            weak var weakSelf = self
            weakSelf?.sliderView?.center.x = btn.center.x
        }
        for tempBtn  in topContentView.subviews{
            if  let   btn = tempBtn as? UIButton {
                btn.isSelected = false
            }
        }
        
        btn.isSelected = !btn.isSelected
    }
    
    
    //添加偏移量功能
    @objc  func   addOffSetX(btn : UIButton){
        UIView.animate(withDuration: 0.3) {
            weak var weakSelf = self
            weakSelf?.sliderView?.center.x = btn.center.x
            let  index = CGFloat(btn.tag - 1212)
            weakSelf?.scrollView?.contentOffset.x = index * screenWidth
        }
        for tempBtn  in topContentView.subviews{
            if  let   btn = tempBtn as? UIButton {
                btn.isSelected = false
            }
        }
        btn.isSelected = !btn.isSelected
    }
    
    
    //添加子控制器的ScrollView
    func addChildScroll(){
        //添加滚动控件
        let  scrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: 64, width:screenWidth, height: screenHeight - 104))
        scrollView.backgroundColor = UIColor.red
        scrollView.contentSize = CGSize.init(width: screenWidth  *  2, height: screenHeight - 104)
        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        self.view.addSubview(scrollView)
        self.scrollView = scrollView
        self.scrollView?.delegate = self
        //添加子控制器
        
        let homeVC  = AppDelegate.homeVC
        let  informationVC = AppDelegate.informationVC
        self.addChildViewController(homeVC)
        homeVC.view.frame = CGRect.init(x: 0, y: 0, width: screenWidth, height: screenHeight - 104)
        homeVC.sliderClouse = {(type) in
            informationVC.type = type
            informationVC.newsModelArr.removeAll()
            informationVC.setdeafultStatus()
            informationVC.getInfoList(type: type, fuzzy: nil)
            UIView.animate(withDuration: 0.25, animations: {
                self.scrollView?.contentOffset.x = screenWidth
            })
        }
        self.scrollView?.addSubview(homeVC.view)
        
//        //InformationVC 子控制器
        self.addChildViewController(informationVC)
        informationVC.view.frame = CGRect.init(x: screenWidth, y: 0, width: screenWidth, height: screenHeight - 104)
        self.scrollView?.addSubview(informationVC.view)
        
//        cricleVC.view.frame = CGRect.init(x: screenWidth, y: 0, width: screenWidth, height: screenHeight - 104)
//        self.scrollView?.addSubview(cricleVC.view)
        
        
    }
}


extension   HomeViewController  : UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let   page = Int(scrollView.contentOffset.x / screenWidth)
        let   tempBtn  = self.sliderBtnArr[page]
        addBtnScroll(btn: tempBtn)
        
    }
 
}


