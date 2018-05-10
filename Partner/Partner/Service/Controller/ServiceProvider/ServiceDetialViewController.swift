//
//  ServiceDetialViewController.swift
//  Partner
//
//  Created by Weslie on 23/02/2018.
//

import UIKit
import SCLAlertView

class ServiceDetialViewController: UIViewController {
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var companyNameLab: UILabel!
    @IBOutlet weak var scanBtn: UIButton!
    @IBOutlet weak var type: StrokeLabel!
    @IBOutlet weak var serviceCommunityLab: UILabel!
    @IBOutlet weak var summaryLab: UILabel!
    
    @IBOutlet weak var namelab: UILabel!
    @IBOutlet weak var phoneLab: UILabel!
    @IBOutlet weak var locationLab: UILabel!
    @IBOutlet weak var officialwebsiteLab: UILabel!
    
    var   id  : Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        getDetailService()
    }

    @IBAction func popBtnClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getDetailService(){
        guard id != nil else {
            return
        }
        NetWorkTool.shareInstance.getProviderInfo(id: id!) { [weak self](result, error) in
            guard error == nil else {
                return
            }
            if  result?["code"] as? Int == 200  {
                guard   result != nil else{
                    return
                }
                if  let dict  =   result!["result"] as? NSDictionary{
                if  let statusViewModel = ProviderDetailModel.mj_object(withKeyValues: dict){
                    if let url = statusViewModel.imgUrl {
                        self?.detailImage.setImageWith(URL.init(string: url)!, placeholderImage: #imageLiteral(resourceName: "partner_img_placeholder"))
                    }
                    
                    if let  companytext = statusViewModel.provName {
                        self?.companyNameLab.text = companytext
                    }
                    
                    if let scanNum = statusViewModel.scanNum {
                        self?.scanBtn.setTitle(" 浏览  \(scanNum)", for: .normal)
                    }
                    
                    if let type = statusViewModel.provType {
                        self?.type.text = type
                    }
                    
                    if let serviceCommunity = statusViewModel.provComm{
                        self?.serviceCommunityLab.text =  serviceCommunity
                    }
                    
                    if let detail = statusViewModel.desc {
                       self?.summaryLab.text = detail
                    }
                    
                    if let name = statusViewModel.connName {
                        self?.namelab.text = name
                    }
                    
                    if let addr = statusViewModel.addr {
                        self?.locationLab.text = addr
                    }
                    
                    if let phone = statusViewModel.phone {
                        self?.phoneLab.text = phone
                    }
                    
                    if let officialwebsiteLab = statusViewModel.site{
                        self?.officialwebsiteLab.text = officialwebsiteLab
                    }
                    
                  }
                }
                
            }else{
                SCLAlertView().showError("post request failed, code: \(String(describing: result!["code"]!))", subTitle: "reason: \(String(describing: result!["msg"]!))")
            }
        
        }
    }
}
