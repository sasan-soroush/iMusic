//
//  ProfileViewController.swfit
//  myBook-iOS
//
//  Created by Frederic Quenneville on 17-11-03.
//  Copyright © 2017 Third Bridge. All rights reserved.
//

import Foundation
import UIKit


extension ProfileViewController {
    
    @objc private func logoutButtonTapped(sender : UIButton) {
        
    }
    
    func expandHeader() {
        UIView.animate(withDuration: headerExpandingAnimationDuration) {
            self.scrollView.contentOffset.y = -self.maxHeaderHeight
            self.imageView.frame.size.height = self.maxHeaderHeight
            self.imageMaskView.frame.size.height = self.maxHeaderHeight
            self.view.layoutIfNeeded()
        }
    }
    
    func collapseHeader() {
        UIView.animate(withDuration: headerCollapsingAnimationDuration) {
            self.scrollView.contentOffset.y = -self.minHeaderHeight
            self.imageView.frame.size.height = self.minHeaderHeight
            self.imageMaskView.frame.size.height = self.maxHeaderHeight
            self.view.layoutIfNeeded()
        }
    }
    
    func updateHeaderView() {
        
        if scrollView.contentOffset.y < -maxHeaderHeight {
            imageView.frame.size.height = -scrollView.contentOffset.y
            imageMaskView.frame.size.height = imageView.frame.size.height
        } else if scrollView.contentOffset.y >= -maxHeaderHeight && scrollView.contentOffset.y < -minHeaderHeight {
            imageView.frame.size.height = -scrollView.contentOffset.y
            imageMaskView.frame.size.height = imageView.frame.size.height
        } else {
            imageView.frame.size.height = minHeaderHeight
            imageMaskView.frame.size.height = minHeaderHeight
        }
        
        scrollView.scrollIndicatorInsets = scrollView.contentInset
        
        imageView.alpha = progress
        
        if progress == 0.0 {
            imageMaskView.alpha = 0.0
        } else {
            imageMaskView.alpha = 1.0
        }
        
        settingLabel.alpha = 1.0 - progress
    }
}

extension ProfileViewController : UITableViewDelegate , UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
   
    
    fileprivate func emptyCell() -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
    }
    
    fileprivate func setupViewForCells(_ indexPath: IndexPath, _ cell: ProfileTableViewCell) {
        switch indexPath.row {
        case 3 :
            cell.addSubview(cell.button)
            cell.button.frame = CGRect(x: cell.frame.width/2, y: cell.frame.height - 80, width: cell.frame.width/2 - 20, height: 70)
            cell.button.setTitle("تغییر عکس پروفایل", for: UIControlState.normal)
            cell.button.setTitleColor(.white, for: .normal)
            cell.button.contentHorizontalAlignment = .right
            cell.button.tag = 1
            cell.button.addTarget(self, action: #selector(changePic(_:)), for: UIControlEvents.touchUpInside)
        case 4 :
            cell.addSubview(cell.button)
            cell.button.frame = CGRect(x: cell.frame.width/2, y: cell.frame.height - 80, width: cell.frame.width/2 - 20, height: 70)
            cell.button.setTitle("خروج از حساب کاربری", for: UIControlState.normal)
            cell.button.setTitleColor(#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), for: .normal)
            cell.button.contentHorizontalAlignment = .right
            
            cell.button.addTarget(self, action: #selector(logoutButtonTapped(sender:)), for: UIControlEvents.touchUpInside)
        default:
            cell.addSubview(cell.textField)
            cell.textField.frame = CGRect(x: 20, y: cell.frame.height - 80, width: cell.frame.width - 40, height: 70)
        }
    }
    
    fileprivate func setupTextfieldsInCells(_ indexPath: IndexPath, _ cell: ProfileTableViewCell) {
        switch indexPath.item {
        case 0:
            cell.textField.placeholder = "نام و نام خانوادگی"
        case 1:
            cell.textField.placeholder = "ایمیل"
        case 2:
            cell.textField.placeholder = "شماره موبایل"
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.id, for: indexPath) as! ProfileTableViewCell
        cell.selectionStyle = .none
        
        setupViewForCells(indexPath, cell)
        
        setupTextfieldsInCells(indexPath, cell)
        
        
        return cell
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
        case 3 :
            return 90
        case 4 :
            return view.frame.height/3.25
        default:
            return 80
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.updateHeaderView()
    }
    
}

extension ProfileViewController {
    
    
    private func addKeyboardNotifiactions() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height/2
            }
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        if view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
}

class ProfileViewController: BaseViewControllerNormal {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK : - Attributes
    let headerTitle = "title"
    
    let headerSubtitle = "subtitle"
    
    let image = #imageLiteral(resourceName: "Screen Shot 2019-04-27 at 5.30.32 PM")
    
    var minHeaderHeight: CGFloat {
        return view.frame.height/10
    }
    
    var maxHeaderHeight: CGFloat {
        return view.frame.height/2.5
    }
    
    let tintColor: UIColor = .black
    
    let titleFont: UIFont = UIFont.boldSystemFont(ofSize: 32)
    
    let subtitleFont: UIFont = UIFont.systemFont(ofSize: 20)
    
    let shadowColor: CGColor = UIColor.black.cgColor
    
    let shadowOffset: CGSize = .zero
    
    let shadowRadius: CGFloat = 0
    
    let shadowOpacity: Float = 0
    
    var progress : CGFloat {
        return (imageView.frame.height - minHeaderHeight)/(maxHeaderHeight - minHeaderHeight)
    }
    
    var headerCollapsingAnimationDuration: Double = 1
    var headerExpandingAnimationDuration: Double = 1
    
    fileprivate let margin: CGFloat = 10
    
    // MARK : - UI Elements
    fileprivate lazy var imageView: UIImageView = {
        var image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    fileprivate lazy var imageMaskView : UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = #imageLiteral(resourceName: "Rectangle")
        view.clipsToBounds = true
        return view
    }()
    
    lazy var settingLabel : CustomLabel = {
        let label = CustomLabel(customFont: Font.IranYekanLight(size: 25))
        label.text = "پروفایل"
        label.alpha = 0
        return label
    }()
    
    let scrollView : UITableView = {
        let view = UITableView(frame: .zero, style: UITableViewStyle.plain)
        view.backgroundColor = .clear
        view.separatorColor = .clear
        return view
    }()
    
    // MARK :  - Lifecycle methods
    
    fileprivate func setupGeneral() {
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.delegate = self
        scrollView.dataSource = self
        scrollView.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.id)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGeneral()
        setupViews()
        addKeyboardNotifiactions()
        
    }
    
    fileprivate func setupViews() {
        
        view.layer.sublayers = nil
        view.backgroundColor = UIColor.MyTheme.backgroundColor
        
        view.addSubview(imageView)
        imageView.frame.size = CGSize(width: view.frame.width, height: maxHeaderHeight)
        
        view.addSubview(imageMaskView)
        imageMaskView.frame.size = CGSize(width: view.frame.width, height: maxHeaderHeight)
        
        view.addSubview(scrollView)
        scrollView.frame = view.frame
        scrollView.frame.size.height = view.frame.height - helper.getTabBarHeight()
        
        view.addSubview(settingLabel)
        settingLabel.frame = CGRect(x: 20, y: 20, width: view.frame.width - 40, height: 80)
        
        view.bringSubview(toFront: imageView)
        view.bringSubview(toFront: imageMaskView)
        
        scrollView.contentInset.top = imageView.frame.height
        scrollView.contentOffset.y = -imageView.frame.height
        
        scrollView.contentInset.top = imageMaskView.frame.height
        scrollView.contentOffset.y = -imageMaskView.frame.height
        
        view.bringSubview(toFront: settingLabel)
    }
    
    
}

extension ProfileViewController : UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    
    @objc private func changePic(_ sender: UIButton) {
        var optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        if UIDevice.current.userInterfaceIdiom == .pad {
            optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        }
        let library = UIAlertAction(title: "Device Photos", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            let imagePickerController = UIImagePickerController()
            imagePickerController.sourceType = .photoLibrary
            imagePickerController.allowsEditing = true
            imagePickerController.delegate = self
            self.present(imagePickerController, animated: true, completion: nil)
            
        })
        
        let camera = UIAlertAction(title: "Camera", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            let imagePickerController = UIImagePickerController()
            imagePickerController.sourceType = .camera
            imagePickerController.allowsEditing = true
            imagePickerController.delegate = self
            self.present(imagePickerController, animated: true, completion: nil)
            
            
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler:nil)
        optionMenu.addAction(camera)
        optionMenu.addAction(library)
        optionMenu.addAction(cancelAction)
        
        self.present(optionMenu, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let selectedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        self.imageView.image = selectedImage
        self.dismiss(animated: true, completion: nil)
        
       
        
    }
}

