//
//  BaseAPIFlowLayout.swift
//  SwiftScrollBanner
//
//  Created by shenjie on 2021/2/26.
//

import UIKit

class BaseAPIFlowLayout: UICollectionViewFlowLayout {


    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributes = super.layoutAttributesForElements(in: rect)
        attributes!.forEach({ (attr) in
            if attr.representedElementCategory == .supplementaryView {
                let attr = layoutAttributesForSupplementaryView(ofKind:UICollectionView.elementKindSectionHeader, at: IndexPath(item: 0, section: 0))
                attributes!.append(attr!)
            }
        })

        return attributes;
    }

//    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
//        let attributes = super.layoutAttributesForItem(at: indexPath)
//        attributes?.transform = CGAffineTransform(rotationAngle: 45)
//        return attributes
//    }
//
////    override func layoutAttributesForDecorationView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
////
////    }

    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = super.layoutAttributesForSupplementaryView(ofKind: elementKind, at: indexPath)
//        attributes?.transform = CGAffineTransform(rotationAngle: 45)
        if elementKind == UICollectionView.elementKindSectionHeader {
            attributes?.frame = CGRect(x: 0, y: 0, width: CGFloat(attributes!.frame.size.width), height: 500)
//            attributes?.size = CGSize(width: CGFloat(attributes!.frame.size.width), height: 10)
//            attributes?.zIndex = -1
        }
        return attributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
