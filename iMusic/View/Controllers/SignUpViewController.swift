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
            self.line.frame = CGRect(x:self.view.frame.width/3, y: self.phoneNumberTextField.frame.maxY + 5, width: self.view.frame.width/3, height: 0.5)
            self.line.backgroundColor = UIColor.MyTheme.themeGreenColor
        })
    }
    private func keyboardHideAnimations() {
        UIView.animate(withDuration: 0.3, animations: {
            self.orLabel.alpha = 1
            self.line.frame = CGRect(x:self.phoneLoginGuide.frame.minX, y: self.phoneNumberTextField.frame.maxY + 5, width: self.phoneLoginGuide.frame.width, height: 0.5)
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

class SignUpViewController : BaseViewControllerTypeOne {
    
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func writeWelcome() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
            self.welocomeLabel.startTypewritingAnimation()
            self.welocomeLabel.typingTimeInterval = 2
        }
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
        
        phoneNumberTextField.delegate = self
        
        welocomeLabel.frame = CGRect(x: view.frame.width/3-30, y: self.logo.frame.maxY , width: view.frame.width/3+60, height: regularHeight)
        
        let phoneGuideSize = phoneLoginGuide.sizeThatFits(CGSize(width: view.frame.width, height: regularHeight))
        phoneLoginGuide.frame = CGRect(x: view.frame.width/2 - phoneGuideSize.width/2, y: self.welocomeLabel.frame.maxY, width: phoneGuideSize.width, height: regularHeight)
        
        let textFieldSize = phoneNumberTextField.sizeThatFits(CGSize(width: view.frame.width, height: 80))
        phoneNumberTextField.frame = CGRect(x: view.frame.width/5, y: phoneLoginGuide.frame.maxY+regularHeight/2 - textFieldSize.height/2, width: view.frame.width/5*3, height: textFieldSize.height)
        line.frame = CGRect(x: phoneLoginGuide.frame.minX, y: phoneNumberTextField.frame.maxY + 5, width: phoneLoginGuide.frame.width, height: 0.5)
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
        
        let sideViewSize = view.frame.width/15
        sideViewLeft.frame = CGRect(x:-sideViewSize/2 , y: view.frame.height - sideViewSize/2, width: sideViewSize, height: sideViewSize)
        sideViewRight.frame = CGRect(x: view.frame.width - sideViewSize/2, y: view.frame.height - sideViewSize/2, width: sideViewSize, height: sideViewSize)
        sideViewLeft.rotate(angle: 45)
        sideViewRight.rotate(angle: 45)
       
        setupButtonsUI()
        
    }
    
    private func setupButtonsUI() {
        
        //Google button
        googleButton.setGradientBackgroundColor(firstColor: UIColor.MyTheme.themeBlueColor, secondColor: UIColor.MyTheme.themeGreenColor)
        googleButton.layer.cornerRadius = view.frame.width/10
        googleButton.clipsToBounds = true
        
        let googleImage = UIImageView(image: #imageLiteral(resourceName: "google-plus"))
        googleImage.contentMode = UIViewContentMode.scaleAspectFit
        googleButton.addSubview(googleImage)
        googleImage.frame = CGRect(x: googleButton.frame.width/2 - 15, y: googleButton.frame.height/2 - 15, width: 30, height: 30)
        
        //Mobile button
        mobileButton.setGradientBackgroundColor(firstColor: UIColor.MyTheme.themeBlueColor, secondColor: UIColor.MyTheme.themeGreenColor)
        mobileButton.layer.cornerRadius = mobileButton.frame.height/2
        mobileButton.clipsToBounds = true
        mobileButton.setTitle("ورود با شماره موبایل", for: UIControlState.normal)
        mobileButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        mobileButton.titleLabel?.font = Font.IranYekanRegular(size: 18)
    }
    
    let welocomeLabel : CustomTyperLabel = {
        let label = CustomTyperLabel(customFont: Font.IranYekanBold(size: 35))
        label.text = "خوش آمدید"
        return label
    }()
    
    static let fontSize : CGFloat = 20
    
    let phoneLoginGuide : CustomLabel = {
        let label = CustomLabel(customFont:Font.IranYekanLight(size: fontSize))
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
    
    let phoneNumberTextField : CustomTextField = {
        let field = CustomTextField(placeHolder: "۰۹۱۲۰۰۰۰۰۰۰")
        return field
    }()
    
    let line : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let dividerLine : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.MyTheme.themeGreenColor
        view.layer.cornerRadius = 5
        return view
    }()
    
    let orLabel : CustomLabel = {
        let label = CustomLabel(customFont: Font.IranYekanRegular(size: 20))
        label.backgroundColor = UIColor.MyTheme.backgroundColor
        label.textColor = .white
        label.text = "یا"
        return label
    }()
    
    let mobileButton : UIButton = {
        let button = UIButton()
        return button
    }()
    
    let googleButton : UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(googleButtonTapped), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    let sideViewLeft : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.MyTheme.themeGreenColor
        return view
    }()

    let sideViewRight : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.MyTheme.themeGreenColor
        return view
    }()
}









