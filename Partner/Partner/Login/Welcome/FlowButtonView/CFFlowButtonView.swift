//
//  CFFlowButtonView.swift
//  Partner
//
//  Created by LiuXinQiang on 2018/1/16.
//

import UIKit

class CFFlowButtonView: UIView {

    /**
     *  存放需要显示的button
     */
 var  buttonList : NSMutableArray?
var  rowFirstButtons = [UIButton]()
 var  row = 0

    
convenience init(initWithButtonList : NSMutableArray) {
    self.init()
    self.buttonList = initWithButtonList
    for button in initWithButtonList{
        self.addSubview(button as! UIButton)
      }
    }
    override func layoutSubviews() {
       
        let  margin = 10;
        row  = 0
        rowFirstButtons = [UIButton]()
        // 存放每行的第一个Button
//        let rowFirstButtons = NSMutableArray.init()
        
        // 对第一个Button进行设置
        let  button0 = self.buttonList![0] as! UIButton;
        button0.x = CGFloat(margin);
        button0.y = CGFloat(margin);
        self.rowFirstButtons.append(self.buttonList![0] as! UIButton)
        // 对其他Button进行设置
        for  i in  1..<(self.buttonList?.count)!{
          
            let button = self.buttonList![i] as! UIButton

            var  sumWidth = 0;
            let  btn =  rowFirstButtons[row]
            let start = self.buttonList!.index(of: btn)
            
            for  j in  start ..< i+1 {
                let button = self.buttonList![j] as! UIButton
                 sumWidth += Int(button.width + CGFloat(margin));
            }
            
            sumWidth += 10
            
             let lastButton = self.buttonList![i - 1] as! UIButton
            if (CGFloat(sumWidth) >= self.width) {
                button.x = CGFloat(margin);
                button.y = lastButton.y  +  CGFloat(margin) + (button.height)
                rowFirstButtons.append(button)
                row  = row + 1
            } else {
                button.x = CGFloat(sumWidth) - CGFloat(margin) - button.width;
                button.y = lastButton.y;
            }
        }
        let lastButton = self.buttonList?.lastObject as! UIButton;
        self.height = lastButton.frame.maxY + 10
        
    }
}
