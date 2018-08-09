//
//  MusicMainViewController.swift
//  DailyWork
//
//  Created by wuqh on 2018/8/8.
//  Copyright © 2018年 wuqh. All rights reserved.
//

import UIKit

class MusicMainViewController: BaseViewController {
    
    private var songList:[Music]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    private lazy var tableView: UITableView = {
        let tv = UITableView.init(frame: view.bounds, style: .plain)
        tv.dataSource = self
        tv.delegate = self
        tv.register(MusicListCell.self, forCellReuseIdentifier: MusicListCell.description())
        tv.tableFooterView = UIView()
        tv.addRefreshControl {[weak self] in
            self?.queryMusic()
        }
        return tv
    }()
    
    private lazy var search: UISearchController = {
        let search = UISearchController.init(searchResultsController: MusicSearchResultViewController())
        addChildViewController(search)
        search.searchBar.barTintColor = UIColor.blue
        search.searchBar.tintColor = UIColor.yellow
        search.delegate = self
        search.searchBar.delegate = self
        search.searchBar.placeholder = "搜索"
        return search
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        if #available(iOS 11.0, *) {
            navigationItem.searchController = search
        }else {
            tableView.tableHeaderView = search.searchBar
        }
        
        queryMusic()

    }

    private func queryMusic() {
        MusicHandle.query(success: { (songList) in
            self.songList = songList
            self.tableView.refreshControl?.endRefreshing()
        }) { (error) in
            self.tableView.refreshControl?.endRefreshing()
        }
    }

}

extension MusicMainViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songList?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MusicListCell.description(), for: indexPath) as! MusicListCell
        cell.music = songList?[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let musicPlayVc = MusicPlayViewController.init(songList![indexPath.row].song_id!)
        present(musicPlayVc, animated: true, completion: nil)
    }
}

extension MusicMainViewController: UISearchControllerDelegate,UISearchBarDelegate {
    
}
