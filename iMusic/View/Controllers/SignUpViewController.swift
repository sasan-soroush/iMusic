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
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc private func googleButtonTapped() {
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
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
    
    private func setupView() {
        
        let regularHeight = view.frame.height/8
        view.addSubview(welocomeLabel)
        view.addSubview(phoneLoginGuide)
        view.addSubview(phoneNumberTextField)
        view.addSubview(line)
        view.addSubview(dividerLine)
        view.addSubview(orLabel)
        view.addSubview(googleLoginGuide)
        view.addSubview(googleButton)
        
        phoneNumberTextField.delegate = self
        
        welocomeLabel.frame = CGRect(x: view.frame.width/3-30, y: self.logo.frame.maxY , width: view.frame.width/3+60, height: regularHeight)
        
        let phoneGuideSize = phoneLoginGuide.sizeThatFits(CGSize(width: view.frame.width, height: regularHeight))
        phoneLoginGuide.frame = CGRect(x: view.frame.width/2 - phoneGuideSize.width/2, y: self.welocomeLabel.frame.maxY, width: phoneGuideSize.width, height: regularHeight)
        
        let textFieldSize = phoneNumberTextField.sizeThatFits(CGSize(width: view.frame.width, height: 80))
        phoneNumberTextField.frame = CGRect(x: view.frame.width/5, y: phoneLoginGuide.frame.maxY+regularHeight/2 - textFieldSize.height/2, width: view.frame.width/5*3, height: textFieldSize.height)
        line.frame = CGRect(x: phoneLoginGuide.frame.minX, y: phoneNumberTextField.frame.maxY + 10, width: phoneLoginGuide.frame.width, height: 0.5)
        dividerLine.frame = CGRect(x: 0, y: line.frame.maxY + regularHeight, width: view.frame.width, height: 1)
        
        let orLabelSize = orLabel.sizeThatFits(CGSize(width: 80, height: 50))
        orLabel.frame = CGRect(x: view.frame.width/2 - 20, y: dividerLine.frame.minY - orLabelSize.height/2, width: 40, height: 30)
        
        let googleLoginSize = googleLoginGuide.sizeThatFits(CGSize(width: view.frame.width, height: 50))
        googleLoginGuide.frame = CGRect(x: 30, y: dividerLine.frame.maxY + regularHeight - googleLoginSize.height/2, width: view.frame.width - 60, height: googleLoginSize.height)
//        let googleButtonWidth = regularHeight/1.2
        
        let googleButton_y = Helper.shared.getMiddleYAxisPoint(up_y: googleLoginGuide.frame.maxY, down_y: view.frame.height, height: view.frame.width/5)
        googleButton.frame = CGRect(x:view.frame.width/5*2, y: googleButton_y, width:view.frame.width/5, height: view.frame.width/5)
       
        googleButton.setGradientBackgroundColor(firstColor: UIColor.MyTheme.themeBlueColor, secondColor: UIColor.MyTheme.themeGreenColor)
        googleButton.layer.cornerRadius = view.frame.width/10
        googleButton.clipsToBounds = true
        
        let googleImage = UIImageView(image: #imageLiteral(resourceName: "google-plus"))
        googleImage.contentMode = UIViewContentMode.scaleAspectFit
        googleButton.addSubview(googleImage)
        googleImage.frame = CGRect(x: googleButton.frame.width/2 - 15, y: googleButton.frame.height/2 - 15, width: 30, height: 30)
        
    }
    
    let welocomeLabel : CustomLabel = {
        let label = CustomLabel(customFont: Font.AvenirTextUltraLight(size: 35))
        label.text = "Welcome"
        return label
    }()
    
    static let fontSize : CGFloat = 20
    
    let phoneLoginGuide : CustomLabel = {
        
        let label = CustomLabel(customFont:Font.AvenirTextUltraLight(size: fontSize) )
        let LabelString = "Please enter your phone number"
        let regularAttributes = [NSAttributedStringKey.font: Font.AvenirTextUltraLight(size: fontSize)]
        let largeAttributes = [NSAttributedStringKey.font: Font.AvenirTextRegular(size: fontSize)]
        let attributedSentence = NSMutableAttributedString(string: LabelString, attributes: regularAttributes)
        attributedSentence.setAttributes(largeAttributes, range: NSRange(location: 18, length: 12))
        label.attributedText = attributedSentence
        return label
    }()
    
    let googleLoginGuide : CustomLabel = {
        
        let label = CustomLabel(customFont:Font.AvenirTextUltraLight(size: fontSize) )
        let LabelString = "Sign in with your google account"
        let regularAttributes = [NSAttributedStringKey.font: Font.AvenirTextUltraLight(size: fontSize)]
        let largeAttributes = [NSAttributedStringKey.font: Font.AvenirTextRegular(size: fontSize)]
        let attributedSentence = NSMutableAttributedString(string: LabelString, attributes: regularAttributes)
        attributedSentence.setAttributes(largeAttributes, range: NSRange(location: 18, length: 14))
        label.attributedText = attributedSentence
        return label
    }()
    
    //6037 7016 5428 7074 naser soroush
    //09355343690
    
    //6393 4610 3831 3579
    //3232
    
    let phoneNumberTextField : UITextField = {
        let field = UITextField()
        field.textColor = .white
        let placeHolder = "09123456789"
        field.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [NSAttributedStringKey.foregroundColor: UIColor.gray])
        field.textAlignment = .center
        field.tintColor = UIColor.MyTheme.themeBlueColor
        field.keyboardType = .numberPad
        field.keyboardAppearance = .dark
//        field.layer.borderColor = UIColor.darkGray.cgColor
//        field.layer.borderWidth = 0.5
        return field
    }()
    
    let line : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    let dividerLine : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.MyTheme.themeGreenColor
        return view
    }()
    
    let orLabel : CustomLabel = {
        let label = CustomLabel(customFont: Font.AvenirTextUltraLight(size: 20))
        label.backgroundColor = UIColor.MyTheme.backgroundColor
        label.textColor = .white
        label.text = "OR"
        return label
    }()
    
    let googleButton : UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(googleButtonTapped), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    
    
}









