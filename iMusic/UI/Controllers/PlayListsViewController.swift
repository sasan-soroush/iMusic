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
        setDefaults()
        
    }
    
}

extension PlayListViewController {
    
    private func setupView() {
        
        view.addSubview(playlistsTableView)
        playlistsTableView.frame = CGRect(x: 0, y: view.safeAreaInsets.top + 30, width: view.frame.width, height: view.frame.height - helper.getTabBarHeight() - 30)
        
    }
    
    private func setDefaults() {
        self.logo.isHidden = true
        playlistsTableView.delegate = self
        playlistsTableView.dataSource = self
        playlistsTableView.register(YourPlaylistCell.self, forCellReuseIdentifier: YourPlaylistCell.id)
        playlistsTableView.register(OfferedPlaylistsCell.self, forCellReuseIdentifier: OfferedPlaylistsCell.id)
        playlistsTableView.register(FollowedPlaylistCell.self, forCellReuseIdentifier: FollowedPlaylistCell.id)
    }
    
    @objc private func showAllButtonTapped(button : UIButton) {
        print(button.tag)
        switch button.tag {
        case 0:
            break
        case 1:
            break
        case 2:
            break
        default:
            break
        }
    }
    
}

extension PlayListViewController : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0 :
            let cell = tableView.dequeueReusableCell(withIdentifier: OfferedPlaylistsCell.id, for: indexPath) as! OfferedPlaylistsCell
            cell.offersCV.frame = CGRect(x: 0, y: 0, width: cell.frame.width , height: cell.frame.height )
            return cell
        case 1 :
            let cell = tableView.dequeueReusableCell(withIdentifier: YourPlaylistCell.id, for: indexPath) as! YourPlaylistCell
            cell.playlists = []
            cell.playlistsCV.frame = CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: FollowedPlaylistCell.id, for: indexPath) as! FollowedPlaylistCell
            cell.playlistsCV.frame = CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height)
            cell.playlists = []
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 25))
        let label = CustomLabel(customFont: Font.IranYekanRegular(size: 15))
        
        let showAllButton = UIButton(type: UIButtonType.system)
        showAllButton.setTitle("نمایش همه", for: UIControlState.normal)
        showAllButton.setTitleColor(.white, for: UIControlState.normal)
        showAllButton.titleLabel?.font = Font.IranYekanRegular(size: 15)
        showAllButton.contentHorizontalAlignment = .left
        showAllButton.frame = CGRect(x: 10, y: 0, width: tableView.frame.width/2, height: 30)
        showAllButton.tag = section
        showAllButton.addTarget(self, action: #selector(showAllButtonTapped(button:)), for: UIControlEvents.touchUpInside)
        
        label.textAlignment = .right
        label.frame = CGRect(x: view.frame.midX, y: 0, width: tableView.frame.width/2-10, height: 30)
        
        headerView.addSubview(label)
        headerView.addSubview(showAllButton)
        switch section {
        case 0:
            label.text = "پلی لیست های پیشنهادی"
        case 1:
            label.text = "پلی لیست های شما"
        case 2:
            label.text = "پلی لیست های فالو شده"
        default:
            break
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (view.frame.width - 60)/2
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}


class PlayListViewController : BaseViewControllerNormal {
    
    let playlistsTableView : UITableView = {
        let view = UITableView(frame: .zero, style: UITableViewStyle.grouped)
        view.isScrollEnabled = true
        view.backgroundColor = .clear
        view.separatorColor = .clear
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    
}
