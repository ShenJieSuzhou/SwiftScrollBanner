//
//  BaseAPIFlowLayout.swift
//  SwiftScrollBanner
//
//  Created by shenjie on 2021/2/26.
//

import UIKit

class BaseAPIFlowLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        self.register(DecorationView.self, forDecorationViewOfKind: "DecorationView")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        var newAttrs = [UICollectionViewLayoutAttributes]()
        attributes!.forEach({ (attr) in
            if attr.representedElementKind == UICollectionView.elementKindSectionHeader {
                let attr1 = layoutAttributesForSupplementaryView(ofKind:UICollectionView.elementKindSectionHeader, at: IndexPath(item: 0, section: 0))
                newAttrs.append(attr1!)
            } else if attr.representedElementKind == UICollectionView.elementKindSectionFooter {
                newAttrs.append(attr)
            }
            
            if attr.representedElementKind == nil {
                attr.transform = CGAffineTransform(rotationAngle: 45)
                newAttrs.append(attr)
            }
        })
        
        let attr2 = self.layoutAttributesForDecorationView(ofKind: "DecorationView", at: IndexPath(item: 0, section: 0))
        newAttrs.append(attr2!)
        return newAttrs;
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = super.layoutAttributesForItem(at: indexPath)
        attributes?.transform = CGAffineTransform(rotationAngle: 45)
        return attributes
    }

    override func layoutAttributesForDecorationView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = super.layoutAttributesForDecorationView(ofKind: elementKind, at: indexPath)
//        let attributes = layoutAttributesForDecorationView(ofKind: "DecorationView", at: indexPath)
//        if elementKind == "DecorationView" {
            attributes?.frame = CGRect(x: 0, y: 0, width: CGFloat(collectionView!.frame.size.width), height: 500)
            attributes?.zIndex = -1
//        }
        
        return attributes
    }

    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = super.layoutAttributesForSupplementaryView(ofKind: elementKind, at: indexPath)
        if elementKind == UICollectionView.elementKindSectionHeader {
           attributes?.size = CGSize(width: CGFloat(attributes!.frame.size.width), height: 10)
        } 
        return attributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
