//
//  BaseViewControllerPresented.swift
//  iMusic
//
//  Created by New User on 1/9/19.
//  Copyright © 2019 sasan soroush. All rights reserved.
//

import UIKit

extension BaseViewControllerPresented {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addPan()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
}

extension BaseViewControllerPresented {
    
    func addPan () {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerHandler(_:)))
        view.addGestureRecognizer(panGestureRecognizer)
        panGestureRecognizer.view?.frame = view.frame;
    }
    
    @objc func panGestureRecognizerHandler(_ sender: UIPanGestureRecognizer) {
        
        
        let touchPoint = sender.location(in: self.view?.window)
        
        if sender.state == UIGestureRecognizerState.began {
            initialTouchPoint = touchPoint
        } else if sender.state == UIGestureRecognizerState.changed {
            if touchPoint.y - initialTouchPoint.y > 0 {
                self.view.frame = CGRect(x: 0, y: touchPoint.y - initialTouchPoint.y, width: self.view.frame.size.width, height: self.view.frame.size.height)
            }
        } else if sender.state == UIGestureRecognizerState.ended || sender.state == UIGestureRecognizerState.cancelled {
            if touchPoint.y - initialTouchPoint.y > 100 {
                self.dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                })
            }
        }
    }
}

class BaseViewControllerPresented: UIViewController {
    
    var initialTouchPoint: CGPoint = CGPoint(x: 0,y: 0)
    
    private func setupView() {
        self.view.backgroundColor = UIColor.clear
        self.view.addSubview(presentedView)
        self.view.addSubview(topView)
        
        presentedView.frame = CGRect(x: 0, y: 25, width: view.frame.width, height: view.frame.height)
        
        let topViewHeight : CGFloat = 3
        let topView_y = Helper.shared.getMiddleYAxisPoint(up_y: 25, down_y: 20 + view.frame.height/16 - 15, height: topViewHeight)
        
        topView.frame = CGRect(x: view.frame.width/5*2-5, y: topView_y, width: view.frame.width/5+10, height: topViewHeight)
        
        self.presentedView.setGradientBackgroundColor(firstColor: UIColor.clear , secondColor: UIColor.MyTheme.gradientForBGColor)
        
        let logoSize = logo.sizeThatFits(CGSize(width: 200, height: 50))
        self.view.addSubview(logo)
        
        logo.frame = CGRect(x: view.frame.width/2 - logoSize.width/2, y: 20, width: logoSize.width, height: view.frame.height/8)
    }
    
    let logo : CustomLabel = {
        let label = CustomLabel(customFont: Font.DINCondensed(size: 30))
        label.text = "iMusic"
        return label
    }()
    
    let presentedView : UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.backgroundColor = UIColor.MyTheme.backgroundColor
        return view
    }()
    
    let topView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.MyTheme.gradientForBGColor
        view.layer.cornerRadius = 1.5
        return view
    }()
    
    
}



