//
//  ProfileAboutUsViewController.swift
//  Partner
//
//  Created by YJ on 2018/3/14.
//

import UIKit

class ProfileAboutUsViewController: UIViewController {
    
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
            } else {
                presentHintMessage(hintMessgae: "您已是最新版本", completion: nil)
            }
        }
    }
    
    @IBAction func popBtnClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var versionLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        versionLbl.text = "当前版本：\(localVersion)"

    }
    
    @IBAction func rateClicked(_ sender: UIButton) {
        // FIXME:- jump to app store
        
        NetWorkTool.shareInstance.getITunesVersion { (result, error) in
            if result != nil {
                let resultDict = result?["results"] as! NSArray
                let dict = resultDict.firstObject as! NSDictionary
                let model = VersionModel.mj_object(withKeyValues: dict)
                self.version = model?.version
            }
        }
        
    }
    

}
