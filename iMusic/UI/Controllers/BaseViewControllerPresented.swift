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
        
        setupBlurredView()
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

class BaseViewControllerPresented: BaseViewController {
    
    var initialTouchPoint: CGPoint = CGPoint(x: 0,y: 0)
    var initial_Y : CGFloat = 25
    
    init(initialY : CGFloat) {
        self.initial_Y = initialY
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBlurredView() {
        
        self.view.backgroundColor = UIColor.clear
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = CGRect(x: 0, y: initial_Y, width: view.frame.width, height: view.frame.height - initial_Y)
        blurredEffectView.layer.cornerRadius = 10
        blurredEffectView.clipsToBounds = true
        view.addSubview(blurredEffectView)
        view.addSubview(topView)
        
        let topViewHeight : CGFloat = 3
        let topView_y = blurredEffectView.frame.minY+15
        
        topView.frame = CGRect(x: view.frame.width/5*2-5, y: topView_y, width: view.frame.width/5+10, height: topViewHeight)
        self.logo.isHidden = true
    }
    
    /*
    private func setupView() {
        
        self.view.backgroundColor = UIColor.clear
        self.view.addSubview(presentedView)
        self.view.addSubview(topView)
        
        presentedView.frame = CGRect(x: 0, y: 25, width: view.frame.width, height: view.frame.height)
        
        let topViewHeight : CGFloat = 3
        let topView_y = Helper.shared.getMiddleYAxisPoint(up_y: 25, down_y: 20 + view.frame.height/16 - 15, height: topViewHeight)
        
        topView.frame = CGRect(x: view.frame.width/5*2-5, y: topView_y, width: view.frame.width/5+10, height: topViewHeight)
        
        self.presentedView.setGradientBackgroundColor(firstColor: UIColor.clear , secondColor: UIColor.MyTheme.gradientForBGColor)
        self.view.bringSubview(toFront: logo)
        
    }
    */
    
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



