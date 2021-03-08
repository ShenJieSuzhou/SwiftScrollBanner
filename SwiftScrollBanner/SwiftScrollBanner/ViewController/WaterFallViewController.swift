//
//  WaterFallViewController.swift
//  SwiftScrollBanner
//
//  Created by snaigame on 2021/2/17.
//

import UIKit

class WaterFallViewController: UIViewController {
    
    private let cellID = "baseCellID"
    
    var itemCount: Int = 30
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpView()
    }
    
    func setUpView() {
        // 设置 flowlayout
        let layout = WaterFallFlowLayout()
        layout.delegate = self
        
        // 设置 collectionview
        let  margin: CGFloat = 8
        layout.minimumLineSpacing = margin
        layout.minimumInteritemSpacing = margin
        layout.sectionInset = UIEdgeInsets(top: 0, left: margin, bottom: 0, right: margin)
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        
        // 注册 Cell
        collectionView.register(BaseCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        view.addSubview(collectionView)
    }
}

extension WaterFallViewController: UICollectionViewDelegate{
    
}

extension WaterFallViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! BaseCollectionViewCell
        cell.cellIndex = indexPath.item
        cell.backgroundColor = indexPath.item % 2 == 0 ? .systemBlue : .purple
        if itemCount - 1 == indexPath.item {
            itemCount += 20
            collectionView.reloadData()
        }
        return cell
    }
}

extension WaterFallViewController: WaterFallLayoutDelegate{
    func waterFlowLayout(_ waterFlowLayout: WaterFallFlowLayout, itemHeight indexPath: IndexPath) -> CGFloat {
        return CGFloat(arc4random_uniform(150) + 50)
    }
}
