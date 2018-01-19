//
//  Extension+UIView.swift
//  Partner
//
//  Created by LiuXinQiang on 2018/1/16.
//

import UIKit

extension UIView{
    var x :  CGFloat {
        set{
            self.frame.origin.x = newValue
        }
        get{
           return self.frame.origin.x
        }
    }
    
    var y :  CGFloat {
        set{
            self.frame.origin.y = newValue
        }
        get{
           return self.frame.origin.y;
        }
    }
    
    
    var centerX :  CGFloat {
        set{
             self.center.x = newValue
        }
        get{
            return  self.center.x;
        }
    }
    
    
    
    var centerY :  CGFloat {
        set{
          self.center.x = newValue
        }
        get{
            return self.center.y;
        }
    }
    
    
    var width :  CGFloat {
        set{
            self.frame.size.width = newValue
        }
        get{
           return self.frame.size.width;
        }
    }
   
    var height :  CGFloat {
        set{
            self.frame.size.height = newValue
        }
        get{
           return self.frame.size.height;
        }
    }
    
    var size :  CGSize {
        set{
            self.frame.size = newValue
        }
        get{
            return self.frame.size;
        }
    }
    
    var origin :  CGPoint {
        set{
            self.frame.origin = newValue
        }
        get{
           return self.frame.origin;
        }
    }

}
