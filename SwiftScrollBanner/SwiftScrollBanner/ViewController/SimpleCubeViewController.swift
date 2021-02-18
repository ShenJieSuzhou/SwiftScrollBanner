//
//  SimpleCubeViewController.swift
//  SwiftScrollBanner
//
//  Created by shenjie on 2021/2/4.
//

import UIKit

class SimpleCubeViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "SimpleCubeViewController"
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height), collectionViewLayout: flowLayout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CellID")
        collectionView.delegate = self
        collectionView.dataSource = self
        self.view.addSubview(collectionView)
    }
}

extension SimpleCubeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (indexPath.row % 2 == 0) {
            return CGSize(width: 50, height: 50)
        } else {
            return CGSize(width: 100, height: 100)
        }
    }
}

extension SimpleCubeViewController: UICollectionViewDelegate {
    
}

extension SimpleCubeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }

    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellID", for: indexPath)
        
        cell.backgroundColor = UIColor(red:  CGFloat(arc4random()%256)/256.0, green:  CGFloat(arc4random()%256)/256.0, blue:  CGFloat(arc4random()%256)/256.0, alpha: 1)
       
        return cell
    }
}

