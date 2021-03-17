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
                let attr2 = layoutAttributesForSupplementaryView(ofKind:UICollectionView.elementKindSectionFooter, at: IndexPath(item: 0, section: 0))
                newAttrs.append(attr2!)
            } else if attr.representedElementKind == nil {
                newAttrs.append(attr)
            }
        })
        
        for i in 0 ..< 6 {
            let decorations = self.layoutAttributesForDecorationView(ofKind: "DecorationView", at: IndexPath(item: 0, section: i))
            if let decorate = decorations {
                newAttrs.append(decorate)
            }
        }
        
//        for (var i = 0; i < 9; i++ ) {
//            let decorations = self.layoutAttributesForDecorationView(ofKind: "DecorationView", at: IndexPath(item: 0, section: i))
//            if let decorate = decorations, rect.intersects(decorate.frame){
//                newAttrs.append(decorate)
//            }
//        }
       
        return newAttrs;
    }
    

    override func layoutAttributesForDecorationView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = UICollectionViewLayoutAttributes(forDecorationViewOfKind: "DecorationView", with: indexPath)
       
        attributes.frame = CGRect(x: 0, y: 0, width: CGFloat(collectionView!.frame.size.width), height: CGFloat(150))
        attributes.zIndex = -1

        return attributes
    }

    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = super.layoutAttributesForSupplementaryView(ofKind: elementKind, at: indexPath)
        if elementKind == UICollectionView.elementKindSectionHeader {
           attributes?.size = CGSize(width: CGFloat(attributes!.frame.size.width), height: 80)
        } else if elementKind == UICollectionView.elementKindSectionFooter {
            attributes?.size = CGSize(width: CGFloat(attributes!.frame.size.width), height: 150)
        }
        return attributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
