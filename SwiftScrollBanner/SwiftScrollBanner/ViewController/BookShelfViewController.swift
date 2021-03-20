//
//  BookShelfViewController.swift
//  SwiftScrollBanner
//
//  Created by snaigame on 2021/3/20.
//

import UIKit

class BookShelfViewController: UIViewController {

    private var collectionView: UICollectionView!
    private let maxNum:Int = 4
    private var mockData = [[String]]()
    private var prevIndexPath:IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Book Shelf"
        mockData = [["1","2","3"],["4","5","6","7"],["8","9","10"],["11","22","33"],["44","55"],["66","77","88","99"],["100","11"]]
        
        
        let flowLayout = BaseAPIFlowLayout()
        let margin: CGFloat = 20
        let section: CGFloat = 15
        flowLayout.minimumLineSpacing = margin
        flowLayout.minimumInteritemSpacing = margin
        flowLayout.sectionInset = UIEdgeInsets(top: section, left: margin, bottom: section, right: margin)
        flowLayout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height), collectionViewLayout: flowLayout)
        // 注册 UICollectionViewCell
        collectionView.register(BookCoverCell.self, forCellWithReuseIdentifier: "CellID")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        self.view.addSubview(collectionView)
        
        // 添加手势
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongGesture(_:)))
        collectionView.addGestureRecognizer(longPressGesture)
    }
    
    @objc func handleLongGesture(_ gesture: UILongPressGestureRecognizer) {
        
        switch(gesture.state) {
            case .began:
                guard let selectedIndexPath = self.collectionView.indexPathForItem(at: gesture.location(in: self.collectionView)) else {
                    break
                }
                prevIndexPath = selectedIndexPath
                // 开始交互
                collectionView.beginInteractiveMovementForItem(at: selectedIndexPath)
            case .changed:
                // 更新位置
                if let moveIndexPath:IndexPath = self.collectionView.indexPathForItem(at: gesture.location(in: self.collectionView)) {
                    if prevIndexPath == moveIndexPath {
                        collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
                    } else {
                        // 判断书架是否放满
                        if collectionView.numberOfItems(inSection: moveIndexPath.section) < 4 {
                            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
                        } else {
                            break
                        }
                    }
                }
            case .ended:
                // 结束交互
                collectionView.endInteractiveMovement()
            default:
                // 默认取消交互
                collectionView.cancelInteractiveMovement()
        }
    }
    
}


extension BookShelfViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 120)
    }
}

extension BookShelfViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension BookShelfViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mockData[section].count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return mockData.count
    }

    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellID", for: indexPath) as! BookCoverCell
        cell.imageNmae = mockData[indexPath.section][indexPath.row]
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//
//        if kind == UICollectionView.elementKindSectionHeader {
//            let headerView: BaseHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerView", for: indexPath) as! BaseHeaderView
//            return headerView
//        } else if kind == UICollectionView.elementKindSectionFooter {
//            let footerView: BaseFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footerView", for: indexPath) as! BaseFooterView
//            return footerView
//        }
//
//        return UICollectionReusableView()
//    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let book = mockData[sourceIndexPath.section].remove(at: sourceIndexPath.row)
        mockData[destinationIndexPath.section].insert(book, at: (destinationIndexPath as NSIndexPath).row)
    }

}
