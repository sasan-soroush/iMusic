//
//  FeaturedViewController.swift
//  iMusic
//
//  Created by New User on 2/26/19.
//  Copyright © 2019 sasan soroush. All rights reserved.
//

import UIKit

extension PlayListViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
    }
    
}

extension PlayListViewController : iCarouselDelegate , iCarouselDataSource {
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return 10

    }
    
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        var label: UILabel
        var itemView: UIImageView
        
        //reuse view if available, otherwise create a new view
        if let view = view as? UIImageView {
            itemView = view
            //get a reference to the label in the recycled view
            label = itemView.viewWithTag(1) as! UILabel
        } else {
            //don't do anything specific to the index within
            //this `if ... else` statement because the view will be
            //recycled and used with other index values later
            let frameSize = self.view.frame.height/3 - 30
            itemView = UIImageView(frame: CGRect(x: 0, y: 0, width: frameSize, height: frameSize))
            itemView.image = UIImage(named: "page.png")
            itemView.contentMode = .center
            
            label = UILabel(frame: itemView.bounds)
            label.backgroundColor = UIColor.red
            label.textAlignment = .center
            label.font = label.font.withSize(50)
            label.tag = 1
            itemView.addSubview(label)
        }
        
        //set item label
        //remember to always set any properties of your carousel item
        //views outside of the `if (view == nil) {...}` check otherwise
        //you'll get weird issues with carousel item content appearing
        //in the wrong place in the carousel
        label.text = "\(index)"
        
        return itemView
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if (option == .spacing) {
            return value * 1.1
        }
        return value
    }
    
    
    
    
}

extension PlayListViewController {
    
    private func setupView() {
        
        self.logo.isHidden = true
        
        view.addSubview(carousel)
        carousel.delegate = self
        carousel.dataSource = self
        carousel.frame = CGRect(x: 0, y: 40, width: view.frame.width, height: view.frame.height/3)
        
    }
    
}

class PlayListViewController : BaseViewControllerNormal {
    
    let carousel : iCarousel = {
        let view = iCarousel()
        view.type = iCarouselType.linear
        return view
    }()

}
