//
//  ProfileSettingsViewController.swift
//  Partner
//
//  Created by Weslie on 17/01/2018.
//

import UIKit

class ProfileSettingsViewController: UIViewController {

    @IBAction func popBtnClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var phoneNumBindingLbl: UILabel!
    @IBOutlet weak var qqBindingStatus: UILabel!
    @IBOutlet weak var weiboBindingStatus: UILabel!
    
    @IBOutlet weak var cacheDataLbl: UILabel!
    
    var cacheSpace: Int = 0
    
    @IBAction func clearCacheClicked(_ sender: UIButton) {
        // 取出cache文件夹路径
        let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        
        // 取出文件夹下所有文件数组
        let files = FileManager.default.subpaths(atPath: cachePath!)
        
        let alert = UIAlertController(title: "提示", message: "是否清除缓存", preferredStyle: UIAlertControllerStyle.alert)
        
        let alertConfirm = UIAlertAction(title: "确定", style: UIAlertActionStyle.default) { (alertConfirm) -> Void in
            // 点击确定时开始删除
            for p in files!{
                // 拼接路径
                let path = cachePath!.appendingFormat("/\(p)")
                // 判断是否可以删除
                if(FileManager.default.fileExists(atPath: path)){
                    // 删除
                    try? FileManager.default.removeItem(atPath: path)
                }
            }
            //删除完重新计算
            self.cacheDataLbl.text = "\(self.calculateCache())M"
        }
        alert.addAction(alertConfirm)
        let cancle = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel) { (cancle) -> Void in
            
        }
        alert.addAction(cancle)
        // 提示框弹出
        present(alert, animated: true) { () -> Void in
            
        }
    }
    
    @IBAction func contactClicked(_ sender: UIButton) {
        
        NetWorkTool.shareInstance.getPhone(phoneType: 2) { [weak self](result, error) in
            if error != nil {
                print(error as AnyObject)
            }
            if let phone = result?["result"] as? String {
                self?.makePhoneCall(with: phone)
            }
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        cacheDataLbl.text = "\(calculateCache())M"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // hide tab bar
        self.tabBarController?.tabBar.isHidden = true
    }

    func calculateCache() -> Int {
        // 取出cache文件夹路径
        let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        // 取出文件夹下所有文件数组
        let files = FileManager.default.subpaths(atPath: cachePath!)
        // 用于统计文件夹内所有文件大小
        var big = Int()
        // 快速枚举取出所有文件名
        for p in files!{
            // 把文件名拼接到路径中
            let path = cachePath!.appendingFormat("/\(p)")
            // 取出文件属性
            let floder = try! FileManager.default.attributesOfItem(atPath: path)
            // 用元组取出文件大小属性
            for (abc,bcd) in floder {
                // 只去出文件大小进行拼接
                if abc == FileAttributeKey.size{
                    big += (bcd as AnyObject).integerValue
                }
            }
        }
        
        cacheSpace = big/(1024*1024)
        return cacheSpace
    }
    
    @IBAction func logOutClicked(_ sender: UIButton) {
        
        presentConfirmationAlert(hint: "确定退出登陆吗") { (_) in
            // clear user defaults
            UserDefaults.standard.removeObject(forKey: "token")
            UserDefaults.standard.removeObject(forKey: "uid")
            access_token = nil
            print("\(UserDefaults.standard.integer(forKey: "uid"))")
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}
