//
//  ProfileEditInfomationViewController.swift
//  Partner
//
//  Created by Weslie on 19/01/2018.
//

import UIKit
import ImagePicker
import Lightbox

class ProfileEditInfomationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ImagePickerDelegate {
    
    var communityData = [[String : AnyObject]]()
    
    var viewModel: ProfileInfoModel? {
        didSet {
            if let avatar = viewModel?.userImgUrl {
                let cell = profileInfoTableView.cellForRow(at: IndexPath.init(row: 0, section: 0))
                // MARK:- judge the cell, in case it is invisible and be reused
                if cell is ProfileEditChooseAvatarTableViewCell {
                    let avatarCell = cell as! ProfileEditChooseAvatarTableViewCell
                    avatarCell.avatar.sd_setImage(with: URL.init(string: avatar), placeholderImage: #imageLiteral(resourceName: "partner_img_placeholder"), options: .continueInBackground, completed: nil)
                }
            }
            if let name = viewModel?.userName {
                profileInfoTableView.cellForRow(at: IndexPath.init(row: 0, section: 1))?.detailTextLabel?.text = name
            } else {
                profileInfoTableView.cellForRow(at: IndexPath.init(row: 0, section: 1))?.detailTextLabel?.text = "请输入"
            }
            if let gender = viewModel?.gender {
                let cell = profileInfoTableView.cellForRow(at: IndexPath.init(row: 1, section: 1))
                switch gender {
                case 0: cell?.detailTextLabel?.text = "保密"
                case 1: cell?.detailTextLabel?.text = "男"
                case 2: cell?.detailTextLabel?.text = "女"
                default: break
                }
            } else {
                profileInfoTableView.cellForRow(at: IndexPath.init(row: 1, section: 1))?.detailTextLabel?.text = "请选择"
            }
            if let phone = viewModel?.phone {
                let cell = profileInfoTableView.cellForRow(at: IndexPath.init(row: 2, section: 1))
                cell?.detailTextLabel?.text = phone
            } else {
                profileInfoTableView.cellForRow(at: IndexPath.init(row: 2, section: 1))?.detailTextLabel?.text = "请绑定"
            }
            if let mail = viewModel?.mail {
                let cell = profileInfoTableView.cellForRow(at: IndexPath.init(row: 3, section: 1))
                cell?.detailTextLabel?.text = mail
            } else {
                profileInfoTableView.cellForRow(at: IndexPath.init(row: 3, section: 1))?.detailTextLabel?.text = "请输入"
            }
            if let company = viewModel?.compName {
                let cell = profileInfoTableView.cellForRow(at: IndexPath.init(row: 4, section: 1))
                cell?.detailTextLabel?.text = company
            } else {
                profileInfoTableView.cellForRow(at: IndexPath.init(row: 4, section: 1))?.detailTextLabel?.text = "请输入"
            }
            if let job = viewModel?.jobName {
                let cell = profileInfoTableView.cellForRow(at: IndexPath.init(row: 5, section: 1))
                cell?.detailTextLabel?.text = job
            } else {
                profileInfoTableView.cellForRow(at: IndexPath.init(row: 5, section: 1))?.detailTextLabel?.text = "请输入"
            }
            // TODO:- post request to get community name
            if let community = viewModel?.commName {
                let cell = profileInfoTableView.cellForRow(at: IndexPath.init(row: 6, section: 1))
                cell?.detailTextLabel?.text = "\(community)"
            } else {
                profileInfoTableView.cellForRow(at: IndexPath.init(row: 6, section: 1))?.detailTextLabel?.text = "请选择"
            }
            if let id = viewModel?.idenId {
                let cell = profileInfoTableView.cellForRow(at: IndexPath.init(row: 7, section: 1))
                switch id {
                case 1: cell?.detailTextLabel?.text = "投资商"
                case 2: cell?.detailTextLabel?.text = "创业者"
                case 3: cell?.detailTextLabel?.text = "普通用户"
                default: break
                }
            }
            
        }
    }
    
    func checkEditInfoCompleted() -> Bool {
        if viewModel?.userName != nil && viewModel?.gender != nil && viewModel?.mail != nil && viewModel?.compName != nil && viewModel?.communityId != nil && viewModel?.idenId != nil && viewModel?.jobName != nil && viewModel?.hobby != nil && viewModel?.skill != nil && viewModel?.require != nil {
            return true
        } else {
            return false
        }
    }
    
    var isExpandedArray = [true, true, false, false, false, false]
    
    var destnationVC: ProfileEditInfomationInputDetialViewController?
    
    var rows = [1, 8, 1, 1, 1, 1]
    
    var avatarCell: ProfileEditChooseAvatarTableViewCell?
    var hobbyCell: ProfileHobbiesSelectorTableViewBodyCell?
    var skillCell: ProfileSkillsSelectorTableViewBodyCell?
    var requireCell: ProfileTextInputTableViewBodyCell?
    var descCell: ProfileTextInputTableViewBodyCell?
    
    @IBAction func popBtnClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveEditClicked(_ sender: UIButton) {
        presentConfirmationAlert(hint: "确认保存修改？") { [weak self](_) in
            // TODO:- save data
            guard UserDefaults.standard.string(forKey: "token") != nil else {
                self?.presentLoginController()
                return
            }
            
            if self?.checkEditInfoCompleted() == false {
                self?.presentHintMessage(hintMessgae: "请完善信息后再提交", completion: { (_) in
                    return
                })
                return
            }
            
            // save require and desc
            if self?.viewModel?.require == nil {
                self?.presentHintMessage(hintMessgae: "请完善信息后再提交", completion: { (_) in
                    return
                })
                return
            }
            // infomation completed
            self?.saveInfomarion()
            
        self?.navigationController?.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func foldExpandHeader(_ tap : UITapGestureRecognizer) {
        let tag = tap.view!.foldTag
        if isExpandedArray[tag] == false {
            // expand section
            isExpandedArray.remove(at: tag)
            isExpandedArray.insert(true, at: tag)
        } else {
            // fold section
            isExpandedArray.remove(at: tag)
            isExpandedArray.insert(false, at: tag)
        }
        let index = IndexPath(item: 0, section: tag)
        let range = Range.init(NSRange.init(location: index.section, length: 1))
        guard range != nil else { return }
        let set = IndexSet.init(integersIn: range!)
        profileInfoTableView.reloadSections(set, with: .automatic)
        
        // MARK:- if the section equals
    }
    
    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var profileInfoTableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        
        if let hobbyCell = hobbyCell {
            if hobbyCell.customBtn1.titleLabel?.text == "+自定义" { hobbyCell.reverseTagClicked(hobbyCell.customBtn1) }
            if hobbyCell.customBtn2.titleLabel?.text == "+自定义" { hobbyCell.reverseTagClicked(hobbyCell.customBtn2) }
            if hobbyCell.customBtn3.titleLabel?.text == "+自定义" { hobbyCell.reverseTagClicked(hobbyCell.customBtn3) }
            if hobbyCell.customBtn4.titleLabel?.text == "+自定义" { hobbyCell.reverseTagClicked(hobbyCell.customBtn4) }
        } else if let skillCell = skillCell {
            if skillCell.customBtn5.titleLabel?.text == "+自定义" { skillCell.reverseTagClicked(skillCell.customBtn5) }
            if skillCell.customBtn6.titleLabel?.text == "+自定义" { skillCell.reverseTagClicked(skillCell.customBtn6) }
            if skillCell.customBtn7.titleLabel?.text == "+自定义" { skillCell.reverseTagClicked(skillCell.customBtn7) }
            if skillCell.customBtn8.titleLabel?.text == "+自定义" { skillCell.reverseTagClicked(skillCell.customBtn8) }
        }
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {

        // save section 1 infomation
        if let cell = profileInfoTableView.cellForRow(at: IndexPath.init(row: 0, section: 1)) {
            viewModel?.userName = cell.detailTextLabel?.text
        }
        if let cell = profileInfoTableView.cellForRow(at: IndexPath.init(row: 3, section: 1)) {
            viewModel?.mail = cell.detailTextLabel?.text
        }
        if let cell = profileInfoTableView.cellForRow(at: IndexPath.init(row: 4, section: 1)) {
            viewModel?.compName = cell.detailTextLabel?.text
        }
        if let cell = profileInfoTableView.cellForRow(at: IndexPath.init(row: 5, section: 1)) {
            viewModel?.jobName = cell.detailTextLabel?.text
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileInfoTableView.delegate = self
        profileInfoTableView.dataSource = self
        
        notificationAddKeyboardObserver()
        
        loadData()
        
        
        // load data
        guard UserDefaults.standard.string(forKey: "token") != nil else {
            presentLoginController()
            return
        }
        NetWorkTool.shareInstance.getMyInfo(token: access_token!) { [weak self](result, error) in
            if error != nil {
                self?.presentConfirmationAlert(hint: "\(error as AnyObject)", completion: nil)
                print(error as AnyObject)
                return
            }
            if result!["code"] as! Int == 200 {
                let model = ProfileInfoModel.mj_object(withKeyValues: result!["result"])
                self?.viewModel = model
            } else {
                self?.presentConfirmationAlert(hint: "post request failed with exit code: \(String(describing: result!["code"])), reason: \(String(describing: result!["msg"]!))", completion: nil)
            }
        }
        
    }
    
    func saveInfomarion() {
        guard UserDefaults.standard.string(forKey: "token") != nil else {
            presentLoginController()
            return
        }
        guard let avatar = avatarCell?.avatar.image else { return }
        // all info nonnull then post request
        NetWorkTool.shareInstance.editUser(token            : access_token!,
                                           image            : avatar,
                                           userName         :(viewModel?.userName)!,
                                           userGender       : viewModel?.gender as! Int,
                                           userMail         :(viewModel?.mail)!,
                                           userCompanyName  :(viewModel?.compName)!,
                                           userJob          :(viewModel?.jobName)!,
                                           communityId      : viewModel?.communityId as! Int,
                                           identityId       : viewModel?.idenId as! Int,
                                           userHobby        : (viewModel?.hobby)!,
                                           userSkill        : (viewModel?.skill)!,
                                           userRequire      :(viewModel?.require)!,
                                           userDesc         : viewModel?.desc)
        { (result, error) in
            weak var weakSelf = self
            if error != nil {
                weakSelf?.presentConfirmationAlert(hint: "\(error as AnyObject)", completion: nil)
                print(error as AnyObject)
                return
            }
            if result!["code"] as! Int == 200 {
                weakSelf?.presentHintMessage(hintMessgae: "个人信息修改成功", completion: { (_) in
                    weakSelf?.navigationController?.popViewController(animated: true)
                })
            } else {
                weakSelf?.presentConfirmationAlert(hint: "post request failed with exit code: \(String(describing: result!["code"])), reason: \(String(describing: result!["msg"]!))", completion: nil)
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isExpandedArray[section] == true {
            return rows[section]
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("ProfileEditTableViewHeader", owner: self, options: nil)?.first as! ProfileEditTableViewHeader
 
        switch section {
        case 0 : return nil
        case 1: headerView.headerTitleLbl.text = "个人信息"
        case 2: headerView.headerTitleLbl.text = "兴趣"
        case 3: headerView.headerTitleLbl.text = "技能标签"
        case 4: headerView.headerTitleLbl.text = "合伙需求"
        case 5: headerView.headerTitleLbl.text = "个人介绍"
        default: break
        }
        
        if isExpandedArray[section] == true {
            headerView.arrowImg.image = #imageLiteral(resourceName: "down_arrow")
        } else {
            headerView.arrowImg.image = #imageLiteral(resourceName: "up_arrow")
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(foldExpandHeader(_:)))
        headerView.addGestureRecognizer(tap)
        headerView.foldTag = section
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.00001
        }
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        switch indexPath.section {
        case 0:
            let avatarCell = tableView.dequeueReusableCell(withIdentifier: "ProfileEditChooseAvatarTableViewCell") as! ProfileEditChooseAvatarTableViewCell
            self.avatarCell = avatarCell
            // tap to pick image
            let tap = UITapGestureRecognizer(target: self, action: #selector(chooseAvatar))
            avatarCell.avatar.addGestureRecognizer(tap)
            cell = avatarCell
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: "ProfileEditSelfInfomationCell")!
            switch indexPath.row {
            case 0: cell.textLabel?.text       = "姓名"
            case 1: cell.textLabel?.text       = "性别"
            case 2: cell.textLabel?.text       = "联系电话"
            case 3: cell.textLabel?.text       = "邮箱"
            case 4: cell.textLabel?.text       = "公司"
            case 5: cell.textLabel?.text       = "职位"
            case 6: cell.textLabel?.text       = "社区"
            case 7: cell.textLabel?.text       = "切换身份  审核中、游客无法编辑"
            default: break
            }
        case 2:
            let hobbyCell = tableView.dequeueReusableCell(withIdentifier: "ProfileHobbiesSelectorTableViewBodyCell") as! ProfileHobbiesSelectorTableViewBodyCell
            if let hobbies = viewModel?.hobby, hobbies != "" {
                // get the single element of the string
                let hobbyArray = hobbies.components(separatedBy: ",")
                // remove the same element of an array
                var hobbyArr = Array(Set(hobbyArray))
                // assign array and string to the cell
                hobbyCell.hobbyArray = hobbyArr
                // traverse the whole array and set selected status
                for hobby in hobbyArr {
                    if hobby == "+自定义" {
                        hobbyArr.remove(at: hobbyArr.index(of: "+自定义")!)
                    }
                    for btn in hobbyCell.contentView.subviews {
                        let button = btn as! ShadowButton
                        let btnTitle = button.titleLabel!.text!
                        if hobby == btnTitle {
                            button.isSelected = true
                            button.backgroundColor = #colorLiteral(red: 0.5529412031, green: 0.6274510026, blue: 0.6941176653, alpha: 1)
                            button.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
                            // remove the selected button in array
                            if let index = hobbyArr.index(of: btnTitle) {
                                hobbyArr.remove(at: index)
                            }
                        } else {
                            continue
                        }
                    }
                }
                switch hobbyArr.count {
                case 0: break
                case 1:
                    hobbyCell.customBtn1.setTitle(hobbyArr[0], for: .normal)
                    hobbyCell.customBtn1.setTagSelected()
                    hobbyCell.customBtn2.isHidden = false
                case 2:
                    hobbyCell.customBtn1.setTitle(hobbyArr[0], for: .normal)
                    hobbyCell.customBtn2.setTitle(hobbyArr[1], for: .normal)
                    hobbyCell.customBtn1.setTagSelected()
                    hobbyCell.customBtn2.setTagSelected()
                    hobbyCell.customBtn3.isHidden = false
                case 3:
                    hobbyCell.customBtn1.setTitle(hobbyArr[0], for: .normal)
                    hobbyCell.customBtn2.setTitle(hobbyArr[1], for: .normal)
                    hobbyCell.customBtn3.setTitle(hobbyArr[2], for: .normal)
                    hobbyCell.customBtn1.setTagSelected()
                    hobbyCell.customBtn2.setTagSelected()
                    hobbyCell.customBtn3.setTagSelected()
                    hobbyCell.customBtn4.isHidden = false
                case 4:
                    hobbyCell.customBtn1.setTitle(hobbyArr[0], for: .normal)
                    hobbyCell.customBtn2.setTitle(hobbyArr[1], for: .normal)
                    hobbyCell.customBtn3.setTitle(hobbyArr[2], for: .normal)
                    hobbyCell.customBtn4.setTitle(hobbyArr[3], for: .normal)
                    hobbyCell.customBtn1.setTagSelected()
                    hobbyCell.customBtn2.setTagSelected()
                    hobbyCell.customBtn3.setTagSelected()
                    hobbyCell.customBtn4.setTagSelected()
                default: break
                }
            }
            self.hobbyCell = hobbyCell
            hobbyCell.viewModel = self.viewModel
            cell = hobbyCell
        case 3:
            let skillCell = tableView.dequeueReusableCell(withIdentifier: "ProfileSkillsSelectorTableViewBodyCell") as! ProfileSkillsSelectorTableViewBodyCell
            if let skills = viewModel?.skill, skills != "" {
                // get the single element of the string
                let skillArray = skills.components(separatedBy: ",")
                // remove the same element of an array
                var skillArr = Array(Set(skillArray))
                // assign array and string to the cell
                skillCell.skillArray = skillArray
                // traverse the whole array and set selected status
                for skill in skillArr {
                    if skill == "+自定义" {
                        skillArr.remove(at: skillArr.index(of: "+自定义")!)
                    }
                    for btn in skillCell.contentView.subviews {
                        let button = btn as! ShadowButton
                        let btnTitle = button.titleLabel!.text!
                        if skill == btnTitle {
                            button.isSelected = true
                            button.backgroundColor = #colorLiteral(red: 0.5529412031, green: 0.6274510026, blue: 0.6941176653, alpha: 1)
                            button.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
                            // remove the selected button in array
                            if let index = skillArr.index(of: btnTitle) {
                                skillArr.remove(at: index)
                            }
                        } else {
                            continue
                        }
                    }
                }
                switch skillArr.count {
                case 0: break
                case 1:
                    skillCell.customBtn5.setTitle(skillArr[0], for: .normal)
                    skillCell.customBtn5.setTagSelected()
                    skillCell.customBtn6.isHidden = false
                case 2:
                    skillCell.customBtn5.setTitle(skillArr[0], for: .normal)
                    skillCell.customBtn6.setTitle(skillArr[1], for: .normal)
                    skillCell.customBtn5.setTagSelected()
                    skillCell.customBtn6.setTagSelected()
                    skillCell.customBtn7.isHidden = false
                case 3:
                    skillCell.customBtn5.setTitle(skillArr[0], for: .normal)
                    skillCell.customBtn6.setTitle(skillArr[1], for: .normal)
                    skillCell.customBtn7.setTitle(skillArr[2], for: .normal)
                    skillCell.customBtn5.setTagSelected()
                    skillCell.customBtn6.setTagSelected()
                    skillCell.customBtn7.setTagSelected()
                    skillCell.customBtn8.isHidden = false
                case 4:
                    skillCell.customBtn5.setTitle(skillArr[0], for: .normal)
                    skillCell.customBtn6.setTitle(skillArr[1], for: .normal)
                    skillCell.customBtn7.setTitle(skillArr[2], for: .normal)
                    skillCell.customBtn8.setTitle(skillArr[3], for: .normal)
                    skillCell.customBtn5.setTagSelected()
                    skillCell.customBtn6.setTagSelected()
                    skillCell.customBtn7.setTagSelected()
                    skillCell.customBtn8.setTagSelected()
                default: break
                }
            }
            self.skillCell = skillCell
            skillCell.viewModel = self.viewModel
            cell = skillCell
        case 4:
            let tagCell = tableView.dequeueReusableCell(withIdentifier: "ProfileTextInputTableViewBodyCell") as! ProfileTextInputTableViewBodyCell
            tagCell.placeholderLbl.text = "简要介绍你的合伙需求（必填）"
            tagCell.isDesc = false
            tagCell.viewModel = self.viewModel
            tagCell.presentAlert = { [weak self]() in
                self?.presentHintMessage(hintMessgae: "字符不能超过300字", completion: nil)
            }
            if viewModel?.require != nil || viewModel?.require != "" {
                tagCell.inputTextView.text = viewModel?.require
                tagCell.placeholderLbl.isHidden = true
                tagCell.inputString = viewModel?.require
            }
            self.requireCell = tagCell
            cell = tagCell
        case 5:
            let tagCell = tableView.dequeueReusableCell(withIdentifier: "ProfileTextInputTableViewBodyCell") as! ProfileTextInputTableViewBodyCell
            tagCell.placeholderLbl.text = "可简单的介绍下自己（选填）"
            tagCell.isDesc = true
            tagCell.viewModel = self.viewModel
            tagCell.presentAlert = { [weak self]() in
                self?.presentHintMessage(hintMessgae: "字符不能超过300字", completion: nil)
            }
            if viewModel?.desc != nil || viewModel?.desc != "" {
                tagCell.inputTextView.text = viewModel?.desc
                tagCell.placeholderLbl.isHidden = true
                tagCell.inputString = viewModel?.desc
            }
            self.descCell = tagCell
            cell = tagCell
        default: break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:     return 150
        case 1:     return 52
        case 2, 3:  return 190
        case 4, 5:  return 160
        default:    return 0
        }
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.section == 1 {
            switch indexPath.row {
            case 0, 3, 4, 5: return indexPath
            case 1:
                let sheet = UIAlertController(title: "请选择性别", message: nil, preferredStyle: .actionSheet)
                let secret = UIAlertAction(title: "保密", style: .default, handler: { (_) in
                    tableView.cellForRow(at: indexPath)?.detailTextLabel?.text = "保密"
                    self.viewModel?.gender = 0
                })
                let female = UIAlertAction(title: "女", style: .default, handler: { (_) in
                    self.viewModel?.gender = 2
                    tableView.cellForRow(at: indexPath)?.detailTextLabel?.text = "女"
                })
                let male = UIAlertAction(title: "男", style: .default, handler: { (_) in
                    self.viewModel?.gender = 1
                    tableView.cellForRow(at: indexPath)?.detailTextLabel?.text = "男"
                })
                let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
                sheet.addAction(male)
                sheet.addAction(female)
                sheet.addAction(secret)
                sheet.addAction(cancel)
                present(sheet, animated: true, completion: {
                    return
                })
            case 2:
                presentHintMessage(hintMessgae: "联系电话不可修改", completion: nil)
                return nil
            case 6:
                // change community
                if let label = tableView.cellForRow(at: IndexPath.init(row: 6, section: 1))?.detailTextLabel {
                    popupSecondaryPicker(bindingLabel: label, type: .community, model: viewModel!, componentDict: communityData)
                }
                
            case 7: print("7")
            default: break
            }
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let selectedCell = tableView.cellForRow(at: indexPath)
            let detialText = selectedCell?.textLabel?.text!
            destnationVC?.navTitle = detialText
            destnationVC?.previousIndexPath = indexPath
            destnationVC?.inputPlaceholder = "请输入你的\(String(describing: detialText!))"
            
            destnationVC?.profileModel = viewModel
            destnationVC?.showLabel = tableView.cellForRow(at: indexPath)?.detailTextLabel
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // MARK:- end deiting to force the object resign first responder
        self.profileInfoTableView.endEditing(true)
        keyboardWillHide(withTransforming: profileInfoTableView)
        
        if let hobbyCell = hobbyCell {
            if hobbyCell.customBtn1.titleLabel?.text == "+自定义" { hobbyCell.reverseTagClicked(hobbyCell.customBtn1) }
            if hobbyCell.customBtn2.titleLabel?.text == "+自定义" { hobbyCell.reverseTagClicked(hobbyCell.customBtn2) }
            if hobbyCell.customBtn3.titleLabel?.text == "+自定义" { hobbyCell.reverseTagClicked(hobbyCell.customBtn3) }
            if hobbyCell.customBtn4.titleLabel?.text == "+自定义" { hobbyCell.reverseTagClicked(hobbyCell.customBtn4) }
        } else if let skillCell = skillCell {
            if skillCell.customBtn5.titleLabel?.text == "+自定义" { skillCell.reverseTagClicked(skillCell.customBtn5) }
            if skillCell.customBtn6.titleLabel?.text == "+自定义" { skillCell.reverseTagClicked(skillCell.customBtn6) }
            if skillCell.customBtn7.titleLabel?.text == "+自定义" { skillCell.reverseTagClicked(skillCell.customBtn7) }
            if skillCell.customBtn8.titleLabel?.text == "+自定义" { skillCell.reverseTagClicked(skillCell.customBtn8) }
        }
        
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        switch identifier {
        case "PEICustomHobbyTagSegue1":
            if let cell = hobbyCell {
                cell.customBtnClick(cell.customBtn1)
                if cell.customBtn1.titleLabel?.text == "+自定义" {
                    return true
                } else {
                    return false
                }
            }
        case "PEICustomHobbyTagSegue2":
            if let cell = hobbyCell {
                cell.customBtnClick(cell.customBtn2)
                if cell.customBtn2.titleLabel?.text == "+自定义" {
                    
                    return true
                } else {
                    return false
                }
            }
        case "PEICustomHobbyTagSegue3":
            if let cell = hobbyCell {
                cell.customBtnClick(cell.customBtn3)
                if cell.customBtn3.titleLabel?.text == "+自定义" {
                    return true
                } else {
                    return false
                }
            }
        case "PEICustomHobbyTagSegue4":
            if let cell = hobbyCell {
                cell.customBtnClick(cell.customBtn4)
                if cell.customBtn4.titleLabel?.text == "+自定义" {
                    return true
                } else {
                    return false
                }
            }
        case "PEICustomSkillTagSegue1":
            if let cell = skillCell {
                cell.customBtnClick(cell.customBtn5)
                if cell.customBtn5.titleLabel?.text == "+自定义" {
                    return true
                } else {
                    return false
                }
            }
        case "PEICustomSkillTagSegue2":
            if let cell = skillCell {
                cell.customBtnClick(cell.customBtn6)
                if cell.customBtn6.titleLabel?.text == "+自定义" {
                    return true
                } else {
                    return false
                }
            }
        case "PEICustomSkillTagSegue3":
            if let cell = skillCell {
                cell.customBtnClick(cell.customBtn7)
                if cell.customBtn7.titleLabel?.text == "+自定义" {
                    return true
                } else {
                    return false
                }
            }
        case "PEICustomSkillTagSegue4":
            if let cell = skillCell {
                cell.customBtnClick(cell.customBtn8)
                if cell.customBtn8.titleLabel?.text == "+自定义" {
                    return true
                } else {
                    return false
                }
            }
        default: break
        }
        
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as! ProfileEditInfomationInputDetialViewController
        destnationVC = dest
        destnationVC?.segue = segue
        if segue.identifier != "PEIInputDetialSegue" {
            destnationVC?.navTitle = "自定义标签"
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.profileInfoTableView.endEditing(true)
    }
    
    @objc func chooseAvatar() {
        let picker = ImagePickerController()
        picker.delegate = self
        picker.imageLimit = 1
        present(picker, animated: true, completion: nil)
    }
    
    // MARK:- image picker protocol functions

    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        guard images.count > 0 else { return }
        let lightboxImages = images.map {
            return LightboxImage(image: $0)
        }
        let lightbox = LightboxController(images: lightboxImages, startIndex: 0)
        imagePicker.present(lightbox, animated: true, completion: nil)
    }
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        guard images.count > 0 else { return }
        imagePicker.dismiss(animated: true) {
            weak var weakSelf = self
            for img in images {
                let avatarCell = weakSelf?.profileInfoTableView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! ProfileEditChooseAvatarTableViewCell
                avatarCell.avatar.image = img
            }
        }
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func loadData() {
        
        NetWorkTool.shareInstance.getCityAndCommunityList { (result, error) in
            weak var weakSelf = self
            if error != nil {
                weakSelf?.presentConfirmationAlert(hint: "\(error as AnyObject)", completion: nil)
                print(error as AnyObject)
                return
            }
            if result!["code"] as! Int == 200 {
                // TODO:- save province and city an array
                for dict in result!["result"]! as! [[String : AnyObject]] {
                    weakSelf?.communityData.append(dict)
                }
            } else {
                weakSelf?.presentConfirmationAlert(hint: "post request failed with exit code: \(String(describing: result!["code"]!)), reason: \(String(describing: result!["msg"]!))", completion: nil)
            }
        }
    }

}
