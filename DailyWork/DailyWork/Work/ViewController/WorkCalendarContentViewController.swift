//
//  WorkCalendarViewController.swift
//  DailyWork
//
//  Created by wuqh on 2018/9/10.
//  Copyright © 2018年 wuqh. All rights reserved.
//

import UIKit

class WorkCalendarContentViewController: UIViewController {
    
    static let contentHeight:CGFloat = 40*6+64
    let itemWidth:CGFloat  = SCREEN_WIDTH/7
    let itemHeight:CGFloat = 40
    
    private lazy var flowLayout:UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        flowLayout.minimumLineSpacing = CGFloat.leastNormalMagnitude
        flowLayout.minimumInteritemSpacing = CGFloat.leastNormalMagnitude
        flowLayout.headerReferenceSize = CGSize(width: SCREEN_WIDTH, height: 64)
        return flowLayout
    }()
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.register(WorkCalendarCell.self, forCellWithReuseIdentifier: WorkCalendarCell.description())
        collectionView.register(WorkCalendarHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: WorkCalendarHeaderView.description())
        collectionView.contentInsetAdjustmentBehavior = .never
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

}

extension WorkCalendarContentViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 42
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WorkCalendarCell.description(), for: indexPath)
        guard let calendarCell = cell as? WorkCalendarCell else {
            return cell
        }
//        cell.backgroundColor = UIColor.randomColor
        calendarCell.label.text = "\(indexPath.row)"
        return calendarCell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: WorkCalendarHeaderView.description(), for: indexPath)
        return reusableView
    }
}
