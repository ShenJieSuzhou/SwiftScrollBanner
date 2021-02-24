//
//  CoverFlowViewController.swift
//  SwiftScrollBanner
//
//  Created by shenjie on 2021/2/23.
//

import UIKit

class CoverFlowViewController: UIViewController {

    private let cellID = "baseCellID"
    
    var itemCount: Int = 30
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        view.backgroundColor = .white
//        automaticallyAdjustsScrollViewInsets = false
//        contentInsetAdjustmentBehavior = false
        setUpView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        bringMiddleCellToFront()
    }
    
    fileprivate func bringMiddleCellToFront() {
        let pointX = (collectionView.contentOffset.x + collectionView.bounds.width / 2)
        let point = CGPoint(x: pointX, y: collectionView.bounds.height / 2)
        let indexPath = collectionView.indexPathForItem(at: point)
        if let indexPathCopy = indexPath {
            let cell = collectionView.cellForItem(at: indexPathCopy)
            guard let cellCopy = cell else {
                return
            }
            collectionView.bringSubviewToFront(cellCopy)
        }
    }
    
    func setUpView() {
        // 设置 flowlayout
        let layout = CoverFlowLayout()
        
        // 设置 collectionview
        let margin: CGFloat = 40
        let collH: CGFloat = 200
        let itemH = collH - margin * 2
        let itemW = (view.bounds.width - margin * 4) / 3
        layout.itemSize = CGSize(width: itemW, height: itemH)
        layout.minimumLineSpacing = margin
        layout.minimumInteritemSpacing = margin
        layout.sectionInset = UIEdgeInsets(top: 0, left: margin, bottom: 0, right: margin)
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 180, width: view.bounds.width, height: collH), collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // 注册 Cell
        collectionView.register(BaseCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        view.addSubview(collectionView)
    }
}

extension CoverFlowViewController: UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        bringMiddleCellToFront()
    }
}

extension CoverFlowViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! BaseCollectionViewCell
        cell.cellIndex = indexPath.item
        cell.backgroundColor = indexPath.item % 2 == 0 ? .purple : .lightGray
//        if itemCount - 1 == indexPath.item {
//            itemCount += 20
//            collectionView.reloadData()
//        }
        return cell
    }
}

