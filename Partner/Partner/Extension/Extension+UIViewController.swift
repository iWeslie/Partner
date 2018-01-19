//
//  Extension+UIView.swift
//  Neighbourhoods
//
//  Created by Weslie on 21/10/2017.
//  Copyright © 2017 NJQL. All rights reserved.
//

import UIKit

extension UIViewController {
    
    // MARK:- set round rect of a UIView
    func setRoundRect(targets: [UIView]) {
        for target in targets {
            target.layer.cornerRadius = target.frame.height / 2
            target.layer.masksToBounds = true
        }
    }
    
    // MARK:- set nav bar title
    func setNavBarTitle(title navTitle: String) {
        let titleLbl = UILabel()
        titleLbl.text = navTitle
        titleLbl.font = UIFont.systemFont(ofSize: 20)
        self.navigationItem.titleView = titleLbl
    }
    
    // MARK:- convenience alert with hint message and completion
    func presentHintMessage(hintMessgae: String, completion: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: "提示", message: hintMessgae, preferredStyle: .alert)
        let ok = UIAlertAction(title: "好的", style: .default, handler: completion)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    func setNavBarBackBtn() {
        let back = UIBarButtonItem(image: #imageLiteral(resourceName: "back"), style: .done, target: self, action: #selector(popopop))
        self.navigationItem.setLeftBarButton(back, animated: true)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    @objc func popopop() {
        self.navigationController?.popViewController(animated: true)
    }


}
