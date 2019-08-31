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
        playlistsTableView.register(PlaylistRowCell.self, forCellReuseIdentifier: PlaylistRowCell.id)
        playlistsTableView.register(OfferedPlaylistsCell.self, forCellReuseIdentifier: OfferedPlaylistsCell.id)
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
            let cell = tableView.dequeueReusableCell(withIdentifier: PlaylistRowCell.id, for: indexPath) as! PlaylistRowCell
            cell.playlistsCV.frame = CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: PlaylistRowCell.id, for: indexPath) as! PlaylistRowCell
            cell.playlistsCV.frame = CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height)
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 30))
        let label = CustomLabel(customFont: Font.IranYekanRegular(size: 17))
        label.textAlignment = .right
        headerView.addSubview(label)
        label.frame = CGRect(x: view.frame.midX, y: 0, width: tableView.frame.width/2-10, height: 30)
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
        return 30
    }
}


class PlayListViewController : BaseViewControllerNormal {
    
    let playlistsTableView : UITableView = {
        let view = UITableView(frame: .zero, style: UITableViewStyle.grouped)
        view.isScrollEnabled = true
        view.backgroundColor = .clear
        view.separatorColor = .clear
        return view
    }()
    
    
}
