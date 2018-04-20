//
//  ProfileEditInfomationInputDetialViewController.swift
//  Partner
//
//  Created by Weslie on 24/02/2018.
//

import UIKit

class ProfileEditInfomationInputDetialViewController: UIViewController {

    @IBAction func popBtnClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    var showLabel: UILabel?
    var profileModel: ProfileInfoModel?
    
    var previousIndexPath: IndexPath?
    var segue: UIStoryboardSegue?
    
    var navTitle: String?
    var inputPlaceholder: String?
    @IBOutlet weak var limitLbl: UILabel!
    
    @IBOutlet weak var navTitleLbl: UILabel!
    @IBOutlet weak var inputTF: UITextField!
    
    var inputText: String? {
        didSet {
//            if previousIndexPath?.row == 0 {
//                limitLbl.text = "\(String(describing: inputText!.count))/6"
//                if let text = inputTF.text, text.count > 6 {
//                    presentHintMessage(hintMessgae: "字数不能超过6个", completion: nil)
//                }
//            }
            // change the button's state
            if inputText == nil || inputText!.isEmptyString {
                saveBtn.isEnabled = false
            } else {
                saveBtn.isEnabled = true
            }
        }
    }
    
    @IBAction func inputTextChanged(_ sender: UITextField) {
        inputText = inputTF.text
    }
    
    @IBOutlet weak var saveBtn: UIButton!
    @IBAction func saveBtnClicked(_ sender: UIButton) {
        guard let segue = segue else { return }
        // MARK:- modify the edit profile infomation
        let source = segue.source as! ProfileEditInfomationViewController
        guard inputText != nil else { return }
        // modify detial info
        if segue.identifier == "PEIInputDetialSegue" {
            if let row = previousIndexPath?.row {
                switch row {
                case 0: profileModel?.userName = inputText
                case 3:
                    if inputText!.isValidEmail == false {
                        presentHintMessage(hintMessgae: "请输入正确的邮箱", completion: nil)
                        return
                    }
                    profileModel?.mail = inputText
                case 4: profileModel?.compName = inputText
                case 5: profileModel?.jobName = inputText
                default: break
                }
            }
            showLabel?.text = inputText
        }
        
        // if is the hobby tag selector
        if segue.identifier!.hasPrefix("PEICustomHobbyTagSegue") {
            if let text = inputTF.text, text.count > 4 {
                presentHintMessage(hintMessgae: "字数不能超过4个", completion: { (_) in
                    return
                })
                return
            }
            
            let hobbyCell = source.profileInfoTableView.cellForRow(at: IndexPath.init(row: 0, section: 2)) as! ProfileHobbiesSelectorTableViewBodyCell
            
            hobbyCell.hobbyArray.append(inputText!)
            
            switch segue.identifier! {
            case "PEICustomHobbyTagSegue1" :
                hobbyCell.customBtn1.setTitle(inputText, for: .normal)
                hobbyCell.customBtn1.backgroundColor = #colorLiteral(red: 0.5529412031, green: 0.6274510026, blue: 0.6941176653, alpha: 1)
                hobbyCell.customBtn1.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
                hobbyCell.customBtn2.isHidden = false
            case "PEICustomHobbyTagSegue2" :
                hobbyCell.customBtn2.setTitle(inputText, for: .normal)
                hobbyCell.customBtn2.backgroundColor = #colorLiteral(red: 0.5529412031, green: 0.6274510026, blue: 0.6941176653, alpha: 1)
                hobbyCell.customBtn2.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
                hobbyCell.customBtn3.isHidden = false
            case "PEICustomHobbyTagSegue3" :
                hobbyCell.customBtn3.setTitle(inputText, for: .normal)
                hobbyCell.customBtn3.backgroundColor = #colorLiteral(red: 0.5529412031, green: 0.6274510026, blue: 0.6941176653, alpha: 1)
                hobbyCell.customBtn3.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
                hobbyCell.customBtn4.isHidden = false
            case "PEICustomHobbyTagSegue4" :
                hobbyCell.customBtn4.setTitle(inputText, for: .normal)
                hobbyCell.customBtn4.backgroundColor = #colorLiteral(red: 0.5529412031, green: 0.6274510026, blue: 0.6941176653, alpha: 1)
                hobbyCell.customBtn4.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
            default: break
            }
            self.navigationController?.popViewController(animated: true)
        }
        if segue.identifier!.hasPrefix("PEICustomSkillTagSegue") {
            if let text = inputTF.text, text.count > 4 {
                presentHintMessage(hintMessgae: "字数不能超过4个", completion: { (_) in
                    return
                })
                return
            }
            let skillCell = source.profileInfoTableView.cellForRow(at: IndexPath.init(row: 0, section: 3)) as! ProfileSkillsSelectorTableViewBodyCell
            skillCell.skillArray.append(inputText!)
            switch segue.identifier! {
            case "PEICustomSkillTagSegue1" :
                skillCell.customBtn5.setTitle(inputText, for: .normal)
                skillCell.customBtn5.backgroundColor = #colorLiteral(red: 0.5529412031, green: 0.6274510026, blue: 0.6941176653, alpha: 1)
                skillCell.customBtn5.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
                skillCell.customBtn6.isHidden = false
            case "PEICustomSkillTagSegue2" :
                skillCell.customBtn6.setTitle(inputText, for: .normal)
                skillCell.customBtn6.backgroundColor = #colorLiteral(red: 0.5529412031, green: 0.6274510026, blue: 0.6941176653, alpha: 1)
                skillCell.customBtn6.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
                skillCell.customBtn7.isHidden = false
            case "PEICustomSkillTagSegue3" :
                skillCell.customBtn7.setTitle(inputText, for: .normal)
                skillCell.customBtn7.backgroundColor = #colorLiteral(red: 0.5529412031, green: 0.6274510026, blue: 0.6941176653, alpha: 1)
                skillCell.customBtn7.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
                skillCell.customBtn8.isHidden = false
            case "PEICustomSkillTagSegue4" :
                skillCell.customBtn8.setTitle(inputText, for: .normal)
                skillCell.customBtn8.backgroundColor = #colorLiteral(red: 0.5529412031, green: 0.6274510026, blue: 0.6941176653, alpha: 1)
                skillCell.customBtn8.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
                default: break
            }
            self.navigationController?.popViewController(animated: true)
        }
        // get the cell at index path
        guard let indexPath = previousIndexPath else { return }
        if let text = inputTF.text, text.count > 6 && indexPath.row == 0 {
            presentHintMessage(hintMessgae: "字数不能超过6个", completion: { (_) in
                return
            })
            return
        }
        let cell = source.profileInfoTableView.cellForRow(at: indexPath)
        if indexPath.section == 1 {
            switch indexPath.row {
            case 0: source.viewModel?.userName = inputText
            case 3: source.viewModel?.mail     = inputText
            case 4: source.viewModel?.compName = inputText
            case 5: source.viewModel?.jobName  = inputText
            default: break
            }
        }
        cell?.detailTextLabel?.text = inputText
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        inputTF.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navTitleLbl.text = navTitle
        inputTF.placeholder = inputPlaceholder

    }
    


}
