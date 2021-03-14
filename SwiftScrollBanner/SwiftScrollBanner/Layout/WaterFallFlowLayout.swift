//
//  WaterFallFlowLayout.swift
//  SwiftScrollBanner
//
//  Created by shenjie on 2021/2/19.
//

import UIKit

protocol WaterFallLayoutDelegate: NSObjectProtocol {
    func waterFlowLayout(_ waterFlowLayout: WaterFallFlowLayout, itemHeight indexPath: IndexPath) -> CGFloat
}

class WaterFallFlowLayout: UICollectionViewFlowLayout {

    weak var delegate: WaterFallLayoutDelegate?
    // 列数
    var cols = 4
    // 布局数组
    fileprivate lazy var layoutAttributeArray: [UICollectionViewLayoutAttributes] = []
    // 高度数组
    fileprivate lazy var yArray: [CGFloat] = Array(repeating: self.sectionInset.top, count: cols)
    
    fileprivate var maxHeight: CGFloat = 0
    
    override func prepare() {
        super.prepare()
        
        // 设置瀑布流布局
        setUpWaterFlowLayout()
    }
    
    func setUpWaterFlowLayout() -> Void {
        let itemWidth = (collectionView!.bounds.width - sectionInset.left - sectionInset.right - minimumInteritemSpacing * CGFloat(cols - 1)) / CGFloat(cols)
        let itemCount = collectionView!.numberOfItems(inSection: 0)
        
        var minHeightIndex = 0
        
        for i in layoutAttributeArray.count ..< itemCount {
            let indexPath = IndexPath(item: i, section: 0)
            let attr = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            let itemHeight = delegate?.waterFlowLayout(self, itemHeight: indexPath)
            
            // 找到高度最小的列
            let value = yArray.min()
            minHeightIndex = yArray.firstIndex(of: value!)!
            var itemY = yArray[minHeightIndex]
            
            if i >= cols {
                itemY += minimumInteritemSpacing
            }
            
            let itemX = sectionInset.left + (itemWidth + minimumInteritemSpacing) * CGFloat(minHeightIndex)
            
            attr.frame = CGRect(x: itemX, y: itemY, width: itemWidth, height: CGFloat(itemHeight!))
            layoutAttributeArray.append(attr)
            yArray[minHeightIndex] = attr.frame.maxY
        }
        maxHeight = yArray.max()! + sectionInset.bottom
    }
}

extension WaterFallFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        // 返回相交的区域
        return layoutAttributeArray.filter {
            $0.frame.intersects(rect)
        }
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: collectionView!.bounds.width, height: maxHeight)
    }
}
