//
//  EntrepreneurshipTimePicker.swift
//  Partner
//
//  Created by Weslie on 05/02/2018.
//

import UIKit
import SCLAlertView

class EntrepreneurshipTimePicker: UIView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var years: [Int] = [Int]()
    var months: [String] = [String]()
    
    var fromYear = "1980" {
        didSet {
            beginDate = "\(fromYear)年/\(fromMonth)"
        }
    }
    var fromMonth = "1" {
        didSet {
            beginDate = "\(fromYear)年/\(fromMonth)"
        }
    }
    var toYear = "2018" {
        didSet {
            endDate = "\(toYear)年/\(toMonth)"
        }
    }
    var toMonth = "1" {
        didSet {
            endDate = "\(toYear)年/\(toMonth)"
        }
    }
    
    var beginDate: String = "1980年/1月" {
        didSet {
            time = "\(beginDate) - \(endDate)"
        }
    }
    var endDate: String = "2018年/1月" {
        didSet {
            time = "\(beginDate) - \(endDate)"
        }
    }
    var time: String?
    var saveDataClosure: ((_ from: String, _ to: String, _ time: String) -> Void)?
    
    let currentDate = Date()
    var current = ""
    
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var backView: UIView!
    @IBAction func cancelBtnClicked(_ sender: UIButton) {
        if let superView = self.superview {
            superView.endEditing(true)
        }
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.backView.alpha = 0
            self.picContainerView.transform = CGAffineTransform(translationX: 0, y: 276)
        }) { (_) in
            self.removeFromSuperview()
        }
    }
    
    @IBAction func confirmBtnClicked(_ sender: UIButton) {
        if let superView = self.superview {
            superView.endEditing(true)
        }
        
        if Int(fromYear)! > Int(toYear)! {
            SCLAlertView().showWarning("请选择正确的时间", subTitle: "")
            return
        } else if Int(fromYear)! == Int(toYear)! && Int(fromMonth.replacingOccurrences(of: "月", with: ""))! > Int(toMonth.replacingOccurrences(of: "月", with: ""))! {
            SCLAlertView().showWarning("请选择正确的时间", subTitle: "")
            return
        }
        
        if saveDataClosure != nil {
            saveDataClosure!("\(fromYear)/\(fromMonth)", "\(toYear)/\(toMonth)", "\(fromYear)/\(fromMonth) - \(toYear)/\(toMonth)")
        }
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.backView.alpha = 0
            self.picContainerView.transform = CGAffineTransform(translationX: 0, y: 276)
        }) { (_) in
            self.removeFromSuperview()
        }
    }
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var picContainerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if let superView = self.superview {
            superView.endEditing(true)
        }
        // get the curret year an create an array
        let yaer = currentDate.year()
        current = "\(yaer)/\(currentDate.month())月"
        // set the placeholder picker title
        timeLbl.text = "\(current) - \(current)"
        for i in 1968...yaer {
            years.append(i)
        }
        // reverse the element in the array
        years.reverse()
        for j in 1...12 {
            months.append("\(j)月")
        }

        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.backView.alpha = 0.3
            self.picContainerView.transform = CGAffineTransform(translationX: 0, y: -276)
        }, completion: nil)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(cancelBtnClicked(_:)))
        backView.addGestureRecognizer(tap)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 5
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0, 3: return years.count         //year
        case 1, 4: return 12                  //momth
        case 2   : return 1                   //
        default  : return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 38
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        // set seperate line's color
        for singleLine in pickerView.subviews {
            if singleLine.frame.size.height < 2 {
                singleLine.backgroundColor = #colorLiteral(red: 0.8432456255, green: 0.8734833598, blue: 0.8959761262, alpha: 1)
            }
        }
        
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2313725501, green: 0.2941176593, blue: 0.3411764801, alpha: 1)
        label.sizeToFit()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = NSTextAlignment.center
        
        switch component {
        case 0: label.text = "\(years[row])"
        case 1: label.text = months[row]
        case 2: label.text = "至"
        case 3: label.text = "\(years[row])"
        case 4: label.text = months[row]
        default :break
        }
        
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch component {
        case 0:
            if let fromYear = pickerView.view(forRow: row, forComponent: 0) as? UILabel {
                self.fromYear = fromYear.text!
            }
        case 1:
            if let fromMonth = pickerView.view(forRow: row, forComponent: 1) as? UILabel {
                self.fromMonth = fromMonth.text!
            }
        case 3:
            if let toYear = pickerView.view(forRow: row, forComponent: 3) as? UILabel {
                self.toYear = toYear.text!
            }
        case 4:
            if let toMonth = pickerView.view(forRow: row, forComponent: 4) as? UILabel {
                self.toMonth = toMonth.text!
            }
        default: break
        }
        
        timeLbl.text = time
        
    }
    
}

