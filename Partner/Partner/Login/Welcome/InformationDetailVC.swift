//
//  InformationDetailVC.swift
//  Partner
//
//  Created by LiuXinQiang on 2018/1/15.
//

import UIKit

class InformationDetailVC: UIViewController {
    var detailViewIsHidden : Bool?
    @IBOutlet weak var CompanyView: UIView!
    @IBOutlet weak var CommonUserView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        CompanyView.isHidden = detailViewIsHidden!
   
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
