//
//  ViewController.swift
//  iMusic
//
//  Created by New User on 12/29/18.
//  Copyright © 2018 sasan soroush. All rights reserved.
//

import UIKit
import GoogleSignIn

extension SignUpViewController : GIDSignInUIDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        writeWelcome()
        addKeyboardNotifiactions()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc private func googleButtonTapped() {
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
    }
    
    
    
    fileprivate func setToCodeState() {
        self.runTimer()
        self.mobileButton.setTitle("تایید کد", for: .normal)
        self.phoneLoginGuide.text = "لطفا کد ارسال شده را وارد کنید"
        self.phoneLoginGuide.startTypewritingAnimation()
        self.codeStateAnimation()
        
    }
    
    @objc private func enterButtonTapped() {
        
        if codeState {
            
        } else {
            setToCodeState()
        }
        
    }
    
    @objc private func resendButtonTepped() {
        self.resendButton.isHidden = true
        self.runTimer()
        self.timerLabel.isHidden = false
    }
    
    @objc private func backButtonTapped() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            
            self.codeState = false
            self.setFrames(self.view.frame.height/9, isFromBackButton: true)
            
        }) { (success) in
            
            UIView.animate(withDuration: 0.5, animations: {
                self.setGoogleViewsVisiblity(visible: true)
            })
            
        }
    }
    
    private func runTimer() {
        let time = timeString(time: TimeInterval(seconds))
        timerLabel.text = "\(time)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(self.updateTimer)), userInfo: nil, repeats: true)
        isTimerRunning = true
    }
    
    @objc private func updateTimer() {
        if seconds < 2 {
            timerLabel.isHidden = true
            resendButton.isHidden = false
            timer.invalidate()
            seconds = 90
        } else {
            seconds -= 1
            let time = timeString(time: TimeInterval(seconds))
            timerLabel.text = "\(time)"
        }
    }
    
    func timeString(time:TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%2i : %02i", minutes, seconds)
    }
    
    
}



extension SignUpViewController {
    
    private func addKeyboardNotifiactions() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
       self.keyboardShowAnimations()
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.keyboardHideAnimations()
    }
    
    private func keyboardShowAnimations() {
        UIView.animate(withDuration: 0.3, animations: {
            self.dividerLine.alpha = 0
            self.googleLoginGuide.alpha = 0
            self.googleButton.alpha = 0
            self.orLabel.alpha = 0
            self.line.frame = CGRect(x:self.view.frame.width/3, y: self.phoneNumberTextField.frame.maxY + 5, width: self.view.frame.width/3, height: 1.5)
            self.line.backgroundColor = UIColor.MyTheme.gradientForBGColor
        })
    }
    private func keyboardHideAnimations() {
        UIView.animate(withDuration: 0.3, animations: {
            self.orLabel.alpha = 1
            self.line.frame = CGRect(x:self.phoneLoginGuide.frame.minX, y: self.phoneNumberTextField.frame.maxY + 5, width: self.phoneLoginGuide.frame.width, height: 1)
            self.line.backgroundColor = UIColor.white
            self.dividerLine.alpha = 1
            self.googleLoginGuide.alpha = 1
            self.googleButton.alpha = 1
        })
    }
    
}

extension SignUpViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var isValidAmount = true
        guard let txt = textField.text else {return false}
        guard let _ = Int(String(txt + string)) else {return false}
        isValidAmount = txt.count <= 14
        guard let text = textField.text else { return true }
        let count = text.count + string.count - range.length
        let aSet = NSCharacterSet(charactersIn:"+0123456789").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered && count < 13 && isValidAmount
    }
}

class SignUpViewController : BaseViewControllerNormal {
    
    var codeState : Bool = false
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    var seconds = 90
    var timer = Timer()
    var isTimerRunning = false
    
    let welocomeLabel : CustomLabel = {
        let label = CustomLabel(customFont: Font.IranYekanBold(size: 35))
        label.text = "خوش آمدید"
        return label
    }()
    
    static let fontSize : CGFloat = 20
    
    let phoneLoginGuide : CustomTyperLabel = {
        let label = CustomTyperLabel(customFont: Font.IranYekanLight(size: fontSize))
        label.typingTimeInterval = 0.04
        label.hideTextBeforeTypewritingAnimation = true
        let LabelString = "لطفا شماره موبایل خود را وارد کنید"
        label.text = LabelString
        return label
    }()
    
    let googleLoginGuide : CustomLabel = {
        let label = CustomLabel(customFont:Font.IranYekanLight(size: fontSize))
        let LabelString = "با اکانت گوگل خود وارد شوید"
        label.text = LabelString
        return label
    }()
    
    let timerLabel : CustomLabel = {
        let label = CustomLabel(customFont:Font.IranYekanLight(size: 16))
        label.alpha = 0
        return label
    }()
    
    let phoneNumberTextField : CustomTextField = {
        let field = CustomTextField(placeHolder: "۰۹۱۲۰۰۰۰۰۰۰")
        return field
    }()
    
    let codeNumberTextField : CustomTextField = {
        let field = CustomTextField(placeHolder: "کد ۶ رقمی ارسال شده")
        return field
    }()
    
    let line : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let dividerLine : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 5
        return view
    }()
    
    let orLabel : CustomLabel = {
        let label = CustomLabel(customFont: Font.IranYekanRegular(size: 20))
        label.backgroundColor = UIColor.MyTheme.backgroundColor
        label.textColor = .white
        label.text = "یا"
        label.layer.borderColor = UIColor.white.cgColor
        label.layer.borderWidth = 2.5
        return label
    }()
    
    let mobileButton : UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.setTitle("ورود با شماره موبایل", for: UIControlState.normal)
        button.setTitleColor(UIColor.white, for: UIControlState.normal)
        button.titleLabel?.font = Font.IranYekanRegular(size: 18)
        button.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.1)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.MyTheme.gradientForBGColor.cgColor
        button.addTarget(self, action: #selector(enterButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let googleButton : UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(googleButtonTapped), for: UIControlEvents.touchUpInside)
        button.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.1)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.MyTheme.gradientForBGColor.cgColor
        return button
    }()
    
    let resendButton : UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(resendButtonTepped), for: UIControlEvents.touchUpInside)
        button.setTitle("ارسال دوباره", for: UIControlState.normal)
        button.titleLabel?.font = Font.IranYekanLight(size: 16)
        button.isHidden = true
        return button
    }()
    
    let backButton : UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(backButtonTapped), for: UIControlEvents.touchUpInside)
        button.setTitle("بازگشت", for: UIControlState.normal)
        button.titleLabel?.font = Font.IranYekanLight(size: 16)
        return button
    }()
    
    let sideViewLeft : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.MyTheme.gradientForBGColor
        return view
    }()

    let sideViewRight : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.MyTheme.gradientForBGColor
        return view
    }()
}


extension SignUpViewController {
    private func writeWelcome() {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.25) {
            
            
            self.phoneLoginGuide.startTypewritingAnimation()
            
            
        }
        
    }
    
    fileprivate func setFrames(_ regularHeight: CGFloat , isFromBackButton : Bool = false ) {
        
        welocomeLabel.frame = CGRect(x: view.frame.width/3-30, y: self.logo.frame.maxY , width: view.frame.width/3+60, height: regularHeight)
        
        let phoneGuideSize = phoneLoginGuide.sizeThatFits(CGSize(width: view.frame.width, height: regularHeight))
        phoneLoginGuide.frame = CGRect(x: view.frame.width/2 - phoneGuideSize.width/2, y: self.welocomeLabel.frame.maxY, width: phoneGuideSize.width, height: regularHeight)
        
        let textFieldSize = phoneNumberTextField.sizeThatFits(CGSize(width: view.frame.width, height: 80))
        phoneNumberTextField.frame = CGRect(x: view.frame.width/5, y: phoneLoginGuide.frame.maxY+regularHeight/2 - textFieldSize.height/2, width: view.frame.width/5*3, height: textFieldSize.height)
        
        codeNumberTextField.frame = CGRect(x: view.frame.width*1.5, y: phoneLoginGuide.frame.maxY+regularHeight/2 - textFieldSize.height/2, width: view.frame.width/5*3, height: textFieldSize.height)
        
        line.frame = CGRect(x: phoneLoginGuide.frame.minX, y: phoneNumberTextField.frame.maxY + 5, width: phoneLoginGuide.frame.width, height: 1)
        line.layer.cornerRadius = 0.5
        dividerLine.frame = CGRect(x: 10, y: view.frame.height/4*2.85, width: view.frame.width-20, height: 3)
        let mobileButton_y = Helper.shared.getMiddleYAxisPoint(up_y: line.frame.maxY, down_y: dividerLine.frame.minY, height: regularHeight/2*1.5)
        mobileButton.frame = CGRect(x: view.frame.width/4, y: mobileButton_y, width: view.frame.width/2, height: regularHeight/2*1.5)
        
        orLabel.frame = CGRect(x: view.frame.width/2 - 20, y: dividerLine.frame.minY - 20, width: 40, height: 40)
        
        orLabel.layer.cornerRadius = 20
        orLabel.clipsToBounds = true
        
        googleButton.frame = CGRect(x:view.frame.width/5*2, y: view.frame.height - view.frame.width/5 - 30, width:view.frame.width/5, height: view.frame.width/5)
        
        let googleLoginSize = googleLoginGuide.sizeThatFits(CGSize(width: view.frame.width, height: 50))
        let googleLoginGuide_y = Helper.shared.getMiddleYAxisPoint(up_y: dividerLine.frame.maxY, down_y: googleButton.frame.minY+10, height: googleLoginSize.height)
        
        googleLoginGuide.frame = CGRect(x: 30, y: googleLoginGuide_y, width: view.frame.width - 60, height: googleLoginSize.height)
        
        
        
        if !isFromBackButton {
            let sideViewSize = view.frame.width/15
            sideViewLeft.frame = CGRect(x:-sideViewSize/2 , y: view.frame.height - sideViewSize/2, width: sideViewSize, height: sideViewSize)
            sideViewRight.frame = CGRect(x: view.frame.width - sideViewSize/2, y: view.frame.height - sideViewSize/2, width: sideViewSize, height: sideViewSize)
            sideViewLeft.rotate(angle: 45)
            sideViewRight.rotate(angle: 45)
        } else {
            
            self.mobileButton.setTitle("ورود با شماره موبایل", for: UIControlState.normal)
        }
        
        
        let resendButton_y = self.view.frame.midY - 15 + self.codeNumberTextField.frame.height + 10
        
        timerLabel.frame = CGRect(x: view.frame.width, y: resendButton_y , width: view.frame.width/2, height: 20)
        
        backButton.frame = CGRect(x: view.frame.width/3, y: view.frame.maxY, width: view.frame.width/3, height: 40)
        
        
    }
    
    private func setGoogleViewsVisiblity (visible : Bool) {
        self.dividerLine.alpha = visible ? 1 : 0
        self.orLabel.alpha = visible ? 1 : 0
        self.googleButton.alpha = visible ? 1 : 0
        self.googleLoginGuide.alpha = visible ? 1 : 0
        
    }
    
    private func setupView() {
        
        let regularHeight = view.frame.height/9
        
        view.addSubview(welocomeLabel)
        view.addSubview(phoneLoginGuide)
        view.addSubview(phoneNumberTextField)
        view.addSubview(line)
        view.addSubview(dividerLine)
        view.addSubview(orLabel)
        view.addSubview(googleLoginGuide)
        view.addSubview(googleButton)
        view.addSubview(mobileButton)
        view.addSubview(sideViewLeft)
        view.addSubview(sideViewRight)
        view.addSubview(timerLabel)
        view.addSubview(resendButton)
        view.addSubview(backButton)
        view.addSubview(codeNumberTextField)
        
        phoneNumberTextField.delegate = self
        
        setFrames(regularHeight)
        
        setupButtonsUI()
        
    }
    
    private func setupButtonsUI() {
        
        //Google button
        //googleButton.setGradientBackgroundColor(firstColor: UIColor.MyTheme.gradientForBGColor, secondColor: UIColor.MyTheme.backgroundColor)
        googleButton.layer.cornerRadius = view.frame.width/10
        googleButton.clipsToBounds = true
        
        let googleImage = UIImageView(image: #imageLiteral(resourceName: "google-plus"))
        googleImage.contentMode = UIViewContentMode.scaleAspectFit
        googleButton.addSubview(googleImage)
        googleImage.frame = CGRect(x: googleButton.frame.width/2 - 15, y: googleButton.frame.height/2 - 15, width: 30, height: 30)
        
        //Mobile button
        //mobileButton.setGradientBackgroundColor(firstColor: UIColor.MyTheme.gradientForBGColor, secondColor: UIColor.MyTheme.backgroundColor)
        mobileButton.layer.cornerRadius = mobileButton.frame.height/2
        
    }
}

//MARK:- animations
extension SignUpViewController {
    
    fileprivate func codeStateAnimation() {
        //send mobileTextField Out
        
        UIView.animate(withDuration: 0.5, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            
            self.phoneNumberTextField.frame.origin.x = -self.view.frame.width
            
            
            self.line.frame = CGRect(x: 5, y: self.phoneNumberTextField.frame.maxY + 5, width: 15, height: 1)
            
        }) { (success) in
            
            UIView.animate(withDuration: 0.75, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                
                
                self.codeNumberTextField.frame.origin.x = self.view.frame.width/5
                self.line.backgroundColor = UIColor.MyTheme.gradientForBGColor
                self.line.layer.cornerRadius = 5
                self.line.frame = CGRect(x: self.view.frame.width - 20, y: self.phoneNumberTextField.frame.maxY + 5, width: 15, height: 10)
                
            }, completion: { (success) in
                
                UIView.animate(withDuration: 0.5, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                    
                    self.line.backgroundColor = .white
                    self.line.layer.cornerRadius = 0.5
                    self.line.frame = CGRect(x: self.phoneLoginGuide.frame.minX+15, y: self.phoneNumberTextField.frame.maxY + 5, width: self.phoneLoginGuide.frame.width-30, height: 2)
                    
                }, completion: { (success) in
                    
                    UIView.animate(withDuration: 0.5, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                        
                        self.setGoogleViewsVisiblity(visible: false)
                        
                    }, completion: { (success) in
                        
                        UIView.animate(withDuration: 0.5, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                            
                            self.mobileButton.frame.origin.y = self.dividerLine.frame.maxY
                            
                        }, completion: { (success) in
                            
                            UIView.animate(withDuration: 0.5, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                                
                                
                                
                                self.codeNumberTextField.frame.origin.y = self.view.frame.midY - 15
                                self.line.frame.origin.y = self.codeNumberTextField.frame.maxY + 10
                                
                                
                            }, completion: { (success) in
                                
                                UIView.animate(withDuration: 0.5, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                                    
                                    self.timerLabel.frame = CGRect(x: self.view.frame.width/4, y: self.line.frame.maxY + 10, width: self.view.frame.width/2, height: 20)
                                    self.backButton.frame.origin.y = self.helper.getMiddleYAxisPoint(up_y: self.mobileButton.frame.maxY, down_y: self.view.frame.maxY, height: 40)
                                    self.resendButton.frame = self.timerLabel.frame
                                    self.timerLabel.alpha = 1
                                    
                                    
                                }, completion: { (successs) in
                                    
                                    //
                                    
                                })
                                
                                
                            })
                            
                            
                        })
                        
                    })
                    
                    
                })
                
                
            })
            
        }
    }
}



