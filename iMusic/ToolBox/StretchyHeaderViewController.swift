//
//  StretchyHeaderViewController.swift
//  StretchyHeaderViewController
//
//  Created by Frédéric Quenneville on 18-01-04.
//  Copyright © 2018 Frédéric Quenneville. All rights reserved.
//

//
//  StretchingHeaderScrollViewController.swift
//  myBook-iOS
//
//  Created by Frederic Quenneville on 17-11-03.
//  Copyright © 2017 Third Bridge. All rights reserved.
//

import Foundation
import UIKit

extension ProfileViewController : UITableViewDelegate , UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height/10
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.updateHeaderView()
    }
    
    
}

class ProfileViewController: BaseViewControllerNormal {
    
    // MARK : - Attributes
    let headerTitle = "title"
    
    let headerSubtitle = "subtitle"
    
    let image = #imageLiteral(resourceName: "Screen Shot 2019-04-27 at 5.30.32 PM")
    
    let minHeaderHeight: CGFloat = 100
    
    let maxHeaderHeight: CGFloat = 300
    
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
    
    // Defining margin in this file in order to reuser the class in multiple projects
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
        view.image = #imageLiteral(resourceName: "Rectangle_black")
        view.clipsToBounds = true
        return view
    }()
    
    let scrollView : UITableView = {
        let view = UITableView(frame: .zero, style: UITableViewStyle.plain)
        view.backgroundColor = .clear
        view.separatorColor = .clear
        return view
    }()
    
    fileprivate lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.font = titleFont
        titleLabel.textColor = tintColor
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.layer.shadowColor = shadowColor
        titleLabel.layer.shadowOffset = shadowOffset
        titleLabel.layer.shadowRadius = shadowRadius
        titleLabel.layer.shadowOpacity = shadowOpacity
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    fileprivate lazy var subtitleLabel: UILabel = {
        let subtitleLabel = UILabel()
        subtitleLabel.numberOfLines = 0
        subtitleLabel.font = subtitleFont
        subtitleLabel.textColor = tintColor
        subtitleLabel.backgroundColor = UIColor.clear
        subtitleLabel.layer.shadowColor = shadowColor
        subtitleLabel.layer.shadowOffset = shadowOffset
        subtitleLabel.layer.shadowRadius = shadowRadius
        subtitleLabel.layer.shadowOpacity = shadowOpacity
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return subtitleLabel
    }()
    
    // MARK :  - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = headerTitle
        subtitleLabel.text = headerSubtitle
        imageView.image = image
        titleLabel.textColor = tintColor
        subtitleLabel.textColor = tintColor
        titleLabel.font = titleFont
        subtitleLabel.font = subtitleFont
        titleLabel.layer.shadowColor = shadowColor
        subtitleLabel.layer.shadowColor = shadowColor
        titleLabel.layer.shadowOffset = shadowOffset
        subtitleLabel.layer.shadowOffset = shadowOffset
        titleLabel.layer.shadowRadius = shadowRadius
        subtitleLabel.layer.shadowRadius = shadowRadius
        titleLabel.layer.shadowOpacity = shadowOpacity
        subtitleLabel.layer.shadowOpacity = shadowOpacity
        scrollView.contentInsetAdjustmentBehavior = .never
        
        scrollView.delegate = self
        scrollView.dataSource = self
        
        setupViews()
    }
    
    fileprivate func setupViews() {
        
        view.layer.sublayers = nil
        view.backgroundColor = UIColor.init(rgb: 0x02181F)
        
        view.addSubview(imageView)
        imageView.frame.size = CGSize(width: view.frame.width, height: maxHeaderHeight)
        
        view.addSubview(imageMaskView)
        imageMaskView.frame.size = CGSize(width: view.frame.width, height: maxHeaderHeight)
        
        view.addSubview(scrollView)
        scrollView.frame = view.frame
        scrollView.frame.size.height = view.frame.height - helper.getTabBarHeight()
        
        view.bringSubview(toFront: imageView)
        view.bringSubview(toFront: imageMaskView)
        
        scrollView.contentInset.top = imageView.frame.height
        scrollView.contentOffset.y = -imageView.frame.height
        
        scrollView.contentInset.top = imageMaskView.frame.height
        scrollView.contentOffset.y = -imageMaskView.frame.height
        
       
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
        
        titleLabel.alpha = progress
        subtitleLabel.alpha = progress
    }
}

