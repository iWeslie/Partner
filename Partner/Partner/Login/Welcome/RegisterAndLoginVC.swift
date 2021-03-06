//
//  RegisterAndLoginVC.swift
//  Partner
//
//  Created by LiuXinQiang on 2018/1/5.
//

import UIKit

class RegisterAndLoginVC: UIViewController {
    //注册控件
    @IBOutlet weak var phoneNumLab: UITextField!
    @IBOutlet weak var pwdNumField: UITextField!
    @IBOutlet weak var identifyCodeField: UITextField!
    @IBOutlet weak var identifyingbtn: UIButton!
    @IBOutlet weak var lineCenterX: NSLayoutConstraint!
    
    //登录控件
    @IBOutlet weak var loginPhoneTextField: UITextField!
    @IBOutlet weak var loginPwdTextField: UITextField!
    @IBOutlet weak var forgetPwdBtn: UIButton!
    
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var registerView: UIView!
    @IBOutlet weak var loginInBtn: UIButton!
    @IBOutlet weak var registerAction: UIButton!
    
    var isloaded : Bool = true
    //定时器方法
    fileprivate var countDownTimer: Timer?
    fileprivate var remainingSeconds: Int = 0 {
        willSet {
                identifyingbtn.setTitle("重新发送\(newValue)秒", for: .normal)
            if newValue <= 0 {
                identifyingbtn.setTitle("发送验证码", for: .normal)
                isCounting = false
            }
        }
    }
    fileprivate var isCounting = false {
        willSet {
            if newValue {
                countDownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
                remainingSeconds = 60
            } else {
                countDownTimer?.invalidate()
                countDownTimer = nil
            }
            identifyingbtn.isEnabled = !newValue
        }
    }
    @objc fileprivate func updateTime() {
        remainingSeconds -= 1
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        registerView.isHidden = true
        loginView.isHidden = false
        
        if  isloaded == false{
            //添加子控制器
            let welcomeVC = UIStoryboard.init(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "WelcomeLoginVCID")
            self.addChildViewController(welcomeVC)
            self.view.addSubview(welcomeVC.view)
        }
       
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         self.phoneNumLab.resignFirstResponder()
         self.pwdNumField.resignFirstResponder()
         self.identifyCodeField.resignFirstResponder()
         self.loginPhoneTextField.resignFirstResponder()
         self.loginPwdTextField.resignFirstResponder()
    
    }
    override func viewWillAppear(_ animated: Bool) {
    }
    //登录
    @IBAction func loginIn(_ sender: Any) {
        if loginPhoneTextField.text == "" {
            self.presentHintMessage(hintMessgae: "请输入手机号码", completion: nil)
            return
        }else if loginPwdTextField.text == "" {
            self.presentHintMessage(hintMessgae: "请输入手机密码", completion: nil)
            return
        }
        //发送请求
        NetWorkTool.shareInstance.UserLogin( loginPhoneTextField.text!, password: loginPwdTextField.text!) { [weak self](result, error) in
            if error == nil {
                // MARK:- judge the return data from server
                if result?["code"] as? Int == 200 {
                    self?.presentHintMessage(hintMessgae: "登录成功", completion: { (action) in
                        let  resultDict = result!["result"] as? NSDictionary
                        if  let token = resultDict?["token"] as? String {
                            //偏好设置
                            let userDefault =  UserDefaults.standard
                            //存储数据
//                            userDefault.set(token, forKey: "token")
                             userDefault.set(token, forKey: "temptoken")
                            access_token = token
                            let uid = resultDict?["uid"]
                            userDefault.set(uid, forKey: "uid")
                            userDefault.set(self?.phoneNumLab.text ,forKey: "number")
                            userDefault.set(self?.pwdNumField.text, forKey: "pwd")
                            //同步数据
                            userDefault.synchronize()
                        }
                        
                        if let finished  = resultDict!["finished"] {
                            if finished as? Bool == true{
                                //回跳主界面
                                if let access_token = UserDefaults.standard.string(forKey: "temptoken"){
                                    let userDefault =  UserDefaults.standard
                                    //存储数据
                                    userDefault.set(access_token, forKey: "token")
                                    //同步数据
                                    userDefault.synchronize()
                                }
                                
                                self?.dismiss(animated: true, completion: nil)
                            }else{
                                //跳转到对应的填充页面
                                if let page  = resultDict!["page"] {
                                    let  infoPage = page as? Int
                                    let  destVC   = self?.chooseDesVC(page: infoPage!)
                                    self?.navigationController?.pushViewController(destVC!, animated: true)
                                }
                            } //                    “status”: 1,
                        }
                    })
                } else {
                    let  errorShow  =  result!["msg"] as! String
                    self?.presentHintMessage(hintMessgae: errorShow, completion: nil)
                }
            }
        }
    }
    
    
    //判断跳转控制器
    func  chooseDesVC(page : Int) -> (UIViewController){
        var tempVCIdentifier  :  String?
//
//        1选择身份
//        2个人信息（区分普通用户、投资商）
//        3技能
//        4兴趣
//        5合伙需求
        switch page {
        case 1:
            tempVCIdentifier = "ChooseIdentityVCID"
            break
        case 2:
            tempVCIdentifier = "InformationDetailVCID"
            break
        case 3:
            tempVCIdentifier = "InterestedVCID"
            break
        case 4:
            tempVCIdentifier = "SkillViewControllerID"
            break
        case 5:
            tempVCIdentifier = "ChooseIdentityVCID"
            break
        default:
            break
        }
        let pushVC = UIStoryboard.init(name: "Login", bundle: nil).instantiateViewController(withIdentifier: tempVCIdentifier!)
        return pushVC
    }
    
    
    
    
    @IBAction func loginInAction(_ sender: Any) {
        self.lineCenterX.constant = self.loginInBtn.frame.minX - self.lineView.frame.width/2.2
        loginView.isHidden = false
        registerView.isHidden = true
    }
    
    @IBAction func registerActionfunc(_ sender: Any) {
        self.lineCenterX.constant = self.registerAction.frame.minX - self.lineView.frame.width/2.2
        loginView.isHidden = true
        registerView.isHidden = false
    }



}

  //MARK: - 注册登录
extension RegisterAndLoginVC {
    //发送验证码
    @IBAction func sendIdentifyAction(_ sender: Any) {
        if phoneNumLab.text == "" {
            self.presentHintMessage(hintMessgae: "请输入手机号码", completion: nil)
            return
        }
        
        NetWorkTool.shareInstance.getDynamicpw(phone: self.phoneNumLab.text!) { [weak self](result, error) in
            if error == nil {
                // MARK:- judge the return data from server
                if result?["code"] as? Int == 200 {
                    self?.presentHintMessage(hintMessgae: "验证码发送成功", completion: nil)
                    self?.phoneNumLab.endEditing(true)
                    self?.isCounting = true
                } else {
                    let  errorShow  =  result!["msg"] as! String
                    self?.presentHintMessage(hintMessgae: errorShow, completion: nil)
                
                }
           }
        }
    }

    //注册
    @IBAction func RegisterAction(_ sender: Any) {
        let  destVC   = self.chooseDesVC(page: 1)
        self.navigationController?.pushViewController(destVC, animated: true)
        if phoneNumLab.text == "" {
            self.presentHintMessage(hintMessgae: "请输入手机号码", completion: nil)
            return
        }else if pwdNumField.text == "" {
            self.presentHintMessage(hintMessgae: "请输入手机密码", completion: nil)
            return
        }else if identifyCodeField.text == "" {
            self.presentHintMessage(hintMessgae: "请输入手机验证码", completion: nil)
            return
        }else if pwdNumField.text?.isValidPassword == false {
            self.presentHintMessage(hintMessgae: "密码应为6-20位字母和数字组合", completion: nil)
            return
        }
//        //发送请求
        NetWorkTool.shareInstance.userRegister(phone:  phoneNumLab.text!, password: pwdNumField.text!, code: identifyCodeField.text!) { [weak self](result, error) in
            if error == nil {
                // MARK:- judge the return data from server
                if result?["code"] as? Int == 200 {
                    self?.presentHintMessage(hintMessgae:"注册成功", completion: nil)
                    let dict = result?["result"] as? NSDictionary
                    if  let token = dict?["token"] as? String {
                        //偏好设置
                        let userDefault =  UserDefaults.standard
                        //存储数据
                        userDefault.set(token, forKey: "temptoken")
                        access_token = token
                        //同步数据
                        userDefault.synchronize()
                    }
                    let  destVC   = self?.chooseDesVC(page: 1)
                    self?.navigationController?.pushViewController(destVC!, animated: true)
                } else {
                    let  errorShow  =  result!["msg"] as! String
                    self?.presentHintMessage(hintMessgae: errorShow, completion: nil)

                }
            }
        }

    }
    
 
}



  //MARK: - 游客登录
extension RegisterAndLoginVC{
    //游客登录
    @IBAction func passengerLogin(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
