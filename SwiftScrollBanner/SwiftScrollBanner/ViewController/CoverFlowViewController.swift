//
//  CoverFlowViewController.swift
//  SwiftScrollBanner
//
//  Created by shenjie on 2021/2/23.
//

import UIKit

class CoverFlowViewController: UIViewController {

    private let cellID = "baseCellID"
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func setUpView() {
        // 初始化 flowlayout
        let layout = CoverFlowLayout()
        let margin: CGFloat = 20
        let collH: CGFloat = 200
        let itemH = collH - margin * 2
        let itemW = view.bounds.width - margin * 2 - 100
        layout.itemSize = CGSize(width: itemW, height: itemH)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 0, left: margin, bottom: 0, right: margin)
        layout.scrollDirection = .horizontal
        
        // 初始化 collectionview
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 180, width: view.bounds.width, height: collH), collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // 注册 Cell
        collectionView.register(BaseCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        view.addSubview(collectionView)
    }
}

extension CoverFlowViewController: UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

    }
}

extension CoverFlowViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! BaseCollectionViewCell
        cell.cellIndex = indexPath.item
        cell.backgroundColor = indexPath.item % 2 == 0 ? .purple : .red

        return cell
    }
}

