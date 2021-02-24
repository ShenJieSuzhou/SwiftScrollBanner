//
//  CoverFlowLayout.swift
//  SwiftScrollBanner
//
//  Created by shenjie on 2021/2/24.
//

import UIKit

class CoverFlowLayout: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        // 获取该范围内的布局数组
        let attributes = super.layoutAttributesForElements(in: rect)
        // 计算中心
        let centerX = collectionView!.contentOffset.x + collectionView!.bounds.width / 2
        
        // 每个点距离中心点进行缩放
        attributes?.forEach({ (attr) in
            let pad = abs(centerX - attr.center.x)
            let scale = 1.8 - pad / collectionView!.bounds.width
            attr.transform = CGAffineTransform(scaleX: scale, y: scale)
        })
        return attributes
    }
        
    /// 重写滚动时停下的位置
    /// - Parameters:
    ///   - proposedContentOffset: 将要停止的点
    ///   - velocity: 滚动速度
    /// - Returns: 滚动停止的点
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        var targetPoint = proposedContentOffset
        // 中心点
        let centerX = proposedContentOffset.x + collectionView!.bounds.width
        // 获取这个点范围内的布局
        let attrs = self.layoutAttributesForElements(in: CGRect(x: proposedContentOffset.x, y: proposedContentOffset.y, width: collectionView!.bounds.size.width, height: collectionView!.bounds.size.height))
        
        // 需要移动的最小距离
        var moveDistance: CGFloat = CGFloat(MAXFLOAT)
        // 遍历数组找出最小距离
        attrs!.forEach { (attr) in
            if abs(attr.center.x - centerX) < abs(moveDistance) {
                moveDistance = attr.center.x - centerX
            }
        }
        
        if targetPoint.x > 0 && targetPoint.x < collectionViewContentSize.width - collectionView!.bounds.width {
            targetPoint.x += moveDistance
        }
        
        return targetPoint
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: sectionInset.left + sectionInset.right + (CGFloat(collectionView!.numberOfItems(inSection: 0)) * (itemSize.width + minimumLineSpacing)) - minimumLineSpacing, height: 0)
    }
}
