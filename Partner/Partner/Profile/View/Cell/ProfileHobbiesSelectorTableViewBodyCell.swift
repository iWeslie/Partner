//
//  ProfileTagSelectorTableViewBodyCell.swift
//  Partner
//
//  Created by Weslie on 19/01/2018.
//

import UIKit

class ProfileHobbiesSelectorTableViewBodyCell: UITableViewCell {
    
    var hobbyString = ""
    
    var viewModel: ProfileInfoModel?
    
    var hobbyArray = [String]() {
        didSet {
            var str = ""
            for skill in hobbyArray {
                if skill == "+自定义" {
                    hobbyArray.remove(at: hobbyArray.index(of: skill)!)
                    continue
                }
                str += "\(skill),"
            }
            if !str.isEmptyString {
                str.removeLast(1)
            }
            hobbyString = str
            viewModel?.hobby = str
        }
    }
    
    @IBAction func staticBtnClicked(_ sender: ShadowButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            sender.backgroundColor = #colorLiteral(red: 0.5529412031, green: 0.6274510026, blue: 0.6941176653, alpha: 1)
            sender.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
            hobbyArray.append((sender.titleLabel?.text)!)

        } else {
            sender.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            sender.setTitleColor(#colorLiteral(red: 0.5529412031, green: 0.6274510026, blue: 0.6941176653, alpha: 1), for: .normal)
            hobbyArray.remove(at: hobbyArray.index(of: (sender.titleLabel?.text)!)!)

        }
    }
    
    @IBOutlet weak var customBtn1: ShadowButton!
    @IBOutlet weak var customBtn2: ShadowButton!
    @IBOutlet weak var customBtn3: ShadowButton!
    @IBOutlet weak var customBtn4: ShadowButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func customBtnClick(_ sender: ShadowButton) {
        guard let title = sender.titleLabel?.text else {
            return
        }
        if sender.isSelected {
            reverseTagClicked(sender)
            for hobby in hobbyArray {
                if hobby == title {
                    hobbyArray.remove(at: hobbyArray.index(of: hobby)!)
                }
            }
        } else {
            setTagClicked(sender)
            if title != "+自定义" {
                hobbyArray.append(title)
            }
        }
    }
    
    func setTagClicked(_ sender: ShadowButton) {
        sender.isSelected = true
        sender.backgroundColor = #colorLiteral(red: 0.5529412031, green: 0.6274510026, blue: 0.6941176653, alpha: 1)
        sender.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        
    }
    
    func reverseTagClicked(_ sender: ShadowButton) {
        sender.isSelected = false
        sender.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        sender.setTitleColor(#colorLiteral(red: 0.5529412031, green: 0.6274510026, blue: 0.6941176653, alpha: 1), for: .normal)
    }
    
}
