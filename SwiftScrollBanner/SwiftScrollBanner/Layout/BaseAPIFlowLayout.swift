//
//  BaseAPIFlowLayout.swift
//  SwiftScrollBanner
//
//  Created by shenjie on 2021/2/26.
//

import UIKit

class BaseAPIFlowLayout: UICollectionViewFlowLayout {
    
    private var sectionAttrs: [Int:UICollectionViewLayoutAttributes] = [:]
    
    override init() {
        super.init()
        self.register(DecorationView.self, forDecorationViewOfKind: "DecorationView")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepare() {
     
        guard let numberOfSections = self.collectionView?.numberOfSections else {
            return
        }
        
        let layoutDelegate: UICollectionViewDelegateFlowLayout = self.collectionView?.delegate as! UICollectionViewDelegateFlowLayout
        
        sectionAttrs.removeAll()
        
        // 计算每个section的装饰视图的布局属性
        for section in 0..<numberOfSections {
            // 获取这个 section 下一个以及最后一个 item 的布局属性
            guard let numberOfItems = self.collectionView?.numberOfItems(inSection: section),
                  numberOfItems > 0,
                  let firstItem = self.layoutAttributesForItem(at: IndexPath(item: 0, section: section)),
                  let lastItem = self.layoutAttributesForItem(at: IndexPath(item: numberOfItems - 1, section: section)) else {
                continue
            }
            
            // 获取 section 的内边距
            var sectionInset = self.sectionInset
            if let inset = layoutDelegate.collectionView?(self.collectionView!, layout: self, insetForSectionAt: section) {
                sectionInset = inset
            }
            
            // 计算 section 实际位置
            var sectionFrame = firstItem.frame.union(lastItem.frame)
            // 计算 section 实际尺寸
            if self.scrollDirection == .horizontal {
                sectionFrame.origin.x -= sectionInset.left
                sectionFrame.origin.y = sectionInset.top
                sectionFrame.size.width += sectionInset.left + sectionInset.right
                sectionFrame.size.height = self.collectionView!.frame.height
            } else {
                sectionFrame.origin.x = sectionInset.left
                sectionFrame.origin.y -= sectionInset.top
                sectionFrame.size.width = self.collectionView!.frame.width
                sectionFrame.size.height += sectionInset.top + sectionInset.bottom
            }
             
            // 计算装饰图属性
            let decorations = UICollectionViewLayoutAttributes(forDecorationViewOfKind: "DecorationView", with: IndexPath(item: 0, section: section))
            //let decorations = self.layoutAttributesForDecorationView(ofKind: "DecorationView", at: IndexPath(item: 0, section: section))
            decorations.frame = sectionFrame
            decorations.zIndex = -1
            
            self.sectionAttrs[section] = decorations
        }
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributes = super.layoutAttributesForElements(in: rect)
        
        attributes?.append(contentsOf: self.sectionAttrs.values.filter{
            return rect.intersects($0.frame)
        })
//        var newAttrs = [UICollectionViewLayoutAttributes]()
//        attributes!.forEach({ (attr) in
//            if attr.representedElementKind == UICollectionView.elementKindSectionHeader {
//                let attr1 = layoutAttributesForSupplementaryView(ofKind:UICollectionView.elementKindSectionHeader, at: IndexPath(item: 0, section: 0))
//                newAttrs.append(attr1!)
//            } else if attr.representedElementKind == UICollectionView.elementKindSectionFooter {
//                let attr2 = layoutAttributesForSupplementaryView(ofKind:UICollectionView.elementKindSectionFooter, at: IndexPath(item: 0, section: 0))
//                newAttrs.append(attr2!)
//            } else if attr.representedElementKind == nil {
//                newAttrs.append(attr)
//            }
//        })
//
//        for i in 0 ..< 6 {
//            let decorations = self.layoutAttributesForDecorationView(ofKind: "DecorationView", at: IndexPath(item: 0, section: i))
//            if let decorate = decorations {
//                newAttrs.append(decorate)
//            }
//        }
        
//        for (var i = 0; i < 9; i++ ) {
//            let decorations = self.layoutAttributesForDecorationView(ofKind: "DecorationView", at: IndexPath(item: 0, section: i))
//            if let decorate = decorations, rect.intersects(decorate.frame){
//                newAttrs.append(decorate)
//            }
//        }
       
        return attributes;
    }
    

    override func layoutAttributesForDecorationView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let section = indexPath.section
        return sectionAttrs[section]
//        attributes.frame = CGRect(x: 0, y: 0, width: CGFloat(collectionView!.frame.size.width), height: CGFloat(150))
//        attributes.zIndex = -1
//
//        return attributes
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
