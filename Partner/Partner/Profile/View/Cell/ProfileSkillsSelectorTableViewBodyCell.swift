//
//  ProfileSkillsSelectorTableViewBodyCell.swift
//  Partner
//
//  Created by Weslie on 19/01/2018.
//

import UIKit

class ProfileSkillsSelectorTableViewBodyCell: UITableViewCell {
    
    var skillString = ""
    
    var viewModel: ProfileInfoModel?
    
    var skillArray = [String]() {
        didSet {
            var str = ""
            for skill in skillArray {
                if skill == "+自定义" {
                    skillArray.remove(at: skillArray.index(of: skill)!)
                    continue
                }
                str += "\(skill),"
            }
            if !str.isEmptyString {
                str.removeLast(1)
            }
            skillString = str
            viewModel?.skill = str
        }
    }
    
    @IBAction func staticBtnClicked(_ sender: ShadowButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            sender.backgroundColor = #colorLiteral(red: 0.5529412031, green: 0.6274510026, blue: 0.6941176653, alpha: 1)
            sender.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
            skillArray.append((sender.titleLabel?.text)!)
            
        } else {
            sender.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            sender.setTitleColor(#colorLiteral(red: 0.5529412031, green: 0.6274510026, blue: 0.6941176653, alpha: 1), for: .normal)
            skillArray.remove(at: skillArray.index(of: (sender.titleLabel?.text)!)!)
        }
    }
    
    @IBOutlet weak var customBtn5: ShadowButton!
    @IBOutlet weak var customBtn6: ShadowButton!
    @IBOutlet weak var customBtn7: ShadowButton!
    @IBOutlet weak var customBtn8: ShadowButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func customBtnClick(_ sender: ShadowButton) {
        guard let title = sender.titleLabel?.text else {
            return
        }
        if sender.isSelected {
            reverseTagClicked(sender)
            for var hobby in skillArray {
                if hobby == title {
                    hobby = skillArray.remove(at: skillArray.index(of: hobby)!)
                }
            }
        } else {
            setTagClicked(sender)
            if title != "+自定义" {
                skillArray.append(title)
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
