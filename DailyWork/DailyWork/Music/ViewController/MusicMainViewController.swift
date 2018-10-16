//
//  MusicMainViewController.swift
//  DailyWork
//
//  Created by wuqh on 2018/8/8.
//  Copyright © 2018年 wuqh. All rights reserved.
//

import UIKit

class MusicMainViewController: BaseViewController {
    
    private var songList:[MusicInfo]? {
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
            self?.queryMusicList(0)
        }
        
        tv.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {[weak self] in
            let offset = self?.songList?.count
            if let offset = offset {
                self?.queryMusicList(offset)
            }
            
        })
        return tv
    }()
    
    private lazy var search: UISearchController = {
        let search = UISearchController.init(searchResultsController: MusicSearchResultViewController())
        addChild(search)
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
        
        queryMusicList(0)

    }

    private func queryMusicList(_ offset: Int) {
        MusicHandle.queryMusicList(offset,success: { (songList) in
            if offset == 0 {
                self.songList = songList
            }else {
                self.songList?.append(contentsOf: songList)
            }
            self.tableView.refreshControl?.endRefreshing()
            if songList.count < 10 {
                self.tableView.mj_footer.endRefreshingWithNoMoreData()
            }else {
                self.tableView.mj_footer.endRefreshing()
            }
        }) { (error) in
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
    private func playMusic(_ musicInfo: MusicInfo) {
        MusicHandle.queryMusicInfo(musicInfo.song_id!, success: { (music) in
            
            MusicPlayToolView.shared.musicInfo = music
            MusicPlayToolView.shared.show(animated: true)
            let audioModel = DDAudioModel()
            audioModel.audioUrl = music.bitrate?.file_link
            DDAudioPlayer.shared.playAudioImmediately([audioModel])
            DDAudioPlayer.shared.delegates.append(MusicPlayToolView.shared)
          
        }) { (errorMsg) in
            
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
        playMusic((songList?[indexPath.row])!)

    }
}

extension MusicMainViewController: UISearchControllerDelegate,UISearchBarDelegate {
    
}
