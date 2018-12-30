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
        
        welocomeLabel.frame = CGRect(x: view.frame.width/3-30, y: self.logo.frame.maxY , width: view.frame.width/3+60, height: regularHeight)
        phoneLoginGuide.frame = CGRect(x: 30, y: self.welocomeLabel.frame.maxY, width: view.frame.width - 60, height: regularHeight)
        let textFieldSize = phoneNumberTextField.sizeThatFits(CGSize(width: view.frame.width, height: 80))
        phoneNumberTextField.frame = CGRect(x: view.frame.width/5, y: phoneLoginGuide.frame.maxY+regularHeight/2 - textFieldSize.height/2, width: view.frame.width/5*3, height: textFieldSize.height)
        line.frame = CGRect(x: phoneNumberTextField.frame.minX - 10, y: phoneNumberTextField.frame.maxY + 10, width: phoneNumberTextField.frame.width+20, height: 0.5)
        dividerLine.frame = CGRect(x: 0, y: line.frame.maxY + regularHeight, width: view.frame.width, height: 1)
        
        let orLabelSize = orLabel.sizeThatFits(CGSize(width: 80, height: 50))
        orLabel.frame = CGRect(x: view.frame.width/2 - 20, y: dividerLine.frame.minY - orLabelSize.height/2, width: 40, height: 30)
        
        googleLoginGuide.frame = CGRect(x: 30, y: dividerLine.frame.maxY-15, width: view.frame.width - 60, height: regularHeight*2)
        let googleButtonWidth = regularHeight/1.2
        googleButton.frame = CGRect(x: view.frame.width/3, y: googleLoginGuide.frame.maxY-googleButtonWidth/4-5, width: view.frame.width/3, height: googleButtonWidth/2+10)
        googleButton.layer.cornerRadius = googleButtonWidth/4+5
        
    }
    
    let welocomeLabel : CustomLabel = {
        let label = CustomLabel(customFont: Font.AvenirTextUltraLight(size: 35))
        label.text = "Welcome"
        return label
    }()
    
    static let fontSize : CGFloat = 21
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
    
    let phoneNumberTextField : UITextField = {
        let field = UITextField()
        field.textColor = .white
        let placeHolder = "Complete phone number"
        field.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
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
        label.text = "OR"
        return label
    }()
    
    let googleButton : UIButton = {
        let button = UIButton()
        button.setGradientBackgroundColor(firstColor: UIColor.MyTheme.themeBlueColor, secondColor: UIColor.MyTheme.themeGreenColor)
        button.backgroundColor = UIColor.MyTheme.themeGreenColor
        button.setImage(#imageLiteral(resourceName: "google-plus"), for: UIControlState.normal)
        button.addTarget(self, action: #selector(googleButtonTapped), for: UIControlEvents.touchUpInside)
        return button
    }()
    
}









