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
        // 计算每个 Cell 的宽度
        let itemWidth = (collectionView!.bounds.width - sectionInset.left - sectionInset.right - minimumInteritemSpacing * CGFloat(cols - 1)) / CGFloat(cols)
        // Cell 数量
        let itemCount = collectionView!.numberOfItems(inSection: 0)
        // 最小高度索引
        var minHeightIndex = 0
        // 遍历 item 计算并缓存属性
        for i in layoutAttributeArray.count ..< itemCount {
            let indexPath = IndexPath(item: i, section: 0)
            let attr = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            // 获取动态高度
            let itemHeight = delegate?.waterFlowLayout(self, itemHeight: indexPath)
            
            // 找到高度最短的那一列
            let value = yArray.min()
            // 获取数组索引
            minHeightIndex = yArray.firstIndex(of: value!)!
            // 获取该列的 Y 坐标
            var itemY = yArray[minHeightIndex]
            // 判断是否是第一行，如果换行需要加上行间距
            if i >= cols {
                itemY += minimumInteritemSpacing
            }
            
            // 计算该索引的 X 坐标
            let itemX = sectionInset.left + (itemWidth + minimumInteritemSpacing) * CGFloat(minHeightIndex)
            // 赋值新的位置信息
            attr.frame = CGRect(x: itemX, y: itemY, width: itemWidth, height: CGFloat(itemHeight!))
            // 缓存布局属性
            layoutAttributeArray.append(attr)
            // 更新最短高度列的数据
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
