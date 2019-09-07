//
//  AddPlaylistViewController.swift
//  iMusic
//
//  Created by New User on 9/3/19.
//  Copyright © 2019 sasan soroush. All rights reserved.
//

import UIKit

extension AddPlaylistViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addKeyboardNotifiactions()
        
    }
    
}

extension AddPlaylistViewController {
    
    private func setupView() {
        
        let padding : CGFloat = 20
        self.logo.isHidden = true
        nameTextField.delegate = self
        
        view.addSubview(guide1)
        guide1.frame = CGRect(x: padding, y: topView.frame.maxY + padding, width: view.frame.width - padding*2, height: 40)
        
        view.addSubview(guide2)
        guide2.frame = CGRect(x: padding, y: guide1.frame.maxY , width: view.frame.width - padding*2, height: 40)
        
        view.addSubview(nameTextField)
        nameTextField.frame = CGRect(x: padding, y: guide2.frame.maxY + padding, width: view.frame.width - padding*2, height: 50)
        
        view.addSubview(addButton)
        addButton.frame = CGRect(x: padding, y: nameTextField.frame.maxY + padding, width: view.frame.width - padding*2, height: view.frame.height - helper.getTabBarHeight() - nameTextField.frame.maxY - padding*2)
    }
    
}

extension AddPlaylistViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

class AddPlaylistViewController : BaseViewControllerPresented {
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if nameTextField.isFirstResponder {
            nameTextField.resignFirstResponder()
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    override init(initialY: CGFloat) {
        super.init(initialY: initialY)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let guide1 : CustomLabel = {
        let label = CustomLabel(customFont: Font.IranYekanRegular(size: 19))
        label.text = "لیست پخش جدید"
        label.textColor = UIColor.white
        return label
    }()
    
    let guide2 : CustomLabel = {
        let label = CustomLabel(customFont: Font.IranYekanRegular(size: 17))
        label.text = "نام لیست پخش خود را وارد نمایید"
        label.textColor = UIColor.lightGray
        return label
    }()
    
    let nameTextField : CustomTextField = {
        let field = CustomTextField(placeHolder: "اسم را وارد کنید.")
        field.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        field.layer.cornerRadius = 8
        field.keyboardType = .alphabet
        field.autocorrectionType = .no
        field.returnKeyType = UIReturnKeyType.done
        field.clipsToBounds = true
        return field
    }()
    
    let addButton : UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.setTitle("ایجاد", for: UIControlState.normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = Font.IranYekanRegular(size: 19)
        return button
    }()
}

extension AddPlaylistViewController {
    
    private func addKeyboardNotifiactions() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y == 0 {
                self.view.frame.origin.y -= (keyboardSize.height-helper.getTabBarHeight())
            }
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        if view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
}
