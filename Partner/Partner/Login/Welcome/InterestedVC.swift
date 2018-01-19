//
//  InterestedVC.swift
//  Partner
//
//  Created by LiuXinQiang on 2018/1/15.
//

import UIKit
import Masonry
class InterestedVC: UIViewController {

    var flowButtonView : CFFlowButtonView?
    var buttonList     : NSMutableArray?
    var scrollview     : UIScrollView?
    override func viewDidLoad() {
        super.viewDidLoad()
        addButton()
       

    }
    
    
//     添加背景scroll
    func addScrollView(){
//        let backScrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: 100, width: , height: <#T##CGFloat#>))
    }

    /*
     * 添加按钮
     */
    func addButton(){
        let buttonArr = NSMutableArray.init()
        for i in 0..<100{
            let button = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 20, height: 30))
            button.backgroundColor = UIColor.white
            var  frame = button.frame;
            frame.size.width = CGFloat(10 * i + 10);
            button.frame = frame;
//          button.backgroundColor = UIColor.blue
            buttonArr.add(button)
        }
         self.buttonList = buttonArr
         addFlowButtonView()
    }
    
    
    
 /**
 *  设置FlowButtonView
 */
    func addFlowButtonView() -> () {
        //实例化一个FlowView对象
       let  tempFlowButtonView = CFFlowButtonView.init(initWithButtonList: (buttonList)! )
//        let tempFlowButtonView = CFFlowButtonView.init(buttonList: buttonList)
        self.view.addSubview(tempFlowButtonView)
        self.flowButtonView?.backgroundColor = UIColor.red
        self.flowButtonView = tempFlowButtonView
//设置约束，不需要设置高度相关的约束
        self.flowButtonView?.mas_makeConstraints({ (make) in
            make?.top.equalTo()(self.view.mas_top)?.offset()(100);
            make?.left.equalTo()(self.view.mas_left);
            make?.right.equalTo()(self.view.mas_right);
        })
        self.flowButtonView?.backgroundColor = UIColor.red
    }
}
