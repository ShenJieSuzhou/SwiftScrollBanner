//
//  BaseAPIFlowLayout.swift
//  SwiftScrollBanner
//
//  Created by shenjie on 2021/2/26.
//

import UIKit

class BaseAPIFlowLayout: UICollectionViewFlowLayout {
    
    fileprivate lazy var sectionAttrs: [UICollectionViewLayoutAttributes] = []
    
    override init() {
        super.init()
        // 注册装饰视图
        self.register(DecorationView.self, forDecorationViewOfKind: "DecorationView")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepare() {
        super.prepare()
        // 1.获取 section 数量
        guard let numberOfSections = self.collectionView?.numberOfSections,
              let layoutDelegate = self.collectionView?.delegate as? UICollectionViewDelegateFlowLayout else {
            return
        }
        
        // 先清除样式
        sectionAttrs.removeAll()
        
        // 2.计算每个section的装饰视图的布局属性
        for section in 0..<numberOfSections {
            // 2.1 获取这个 section 第一个以及最后一个 item 的布局属性
            guard let numberOfItems = self.collectionView?.numberOfItems(inSection: section),
                  numberOfItems > 0,
                  let firstItem = self.layoutAttributesForItem(at: IndexPath(item: 0, section: section)),
                  let lastItem = self.layoutAttributesForItem(at: IndexPath(item: numberOfItems - 1, section: section)) else {
                continue
            }
            
            // 2.2 获取 section 的内边距
            var sectionInset = self.sectionInset
            if let inset = layoutDelegate.collectionView?(self.collectionView!, layout: self, insetForSectionAt: section) {
                sectionInset = inset
            }
            
            // 2.3 计算得到该section实际的位置
            var sectionFrame = firstItem.frame.union(lastItem.frame)
            sectionFrame.origin.x = 0
            sectionFrame.origin.y -= sectionInset.top
            
            // 2.4 计算得到该section实际的尺寸
            if self.scrollDirection == .horizontal {
                sectionFrame.size.width += sectionInset.left + sectionInset.right
                sectionFrame.size.height = self.collectionView!.frame.height
            } else {
                sectionFrame.size.width = self.collectionView!.frame.width
                sectionFrame.size.height += sectionInset.top + sectionInset.bottom
            }
            
            // 2.5 计算装饰图属性
            let decorations = UICollectionViewLayoutAttributes(forDecorationViewOfKind: "DecorationView", with: IndexPath(item: 0, section: section))
            decorations.frame = sectionFrame
            decorations.zIndex = -1

            self.sectionAttrs.append(decorations)
        }
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attrs = super.layoutAttributesForElements(in: rect)
        
        attrs!.append(contentsOf: self.sectionAttrs.filter {
              return rect.intersects($0.frame)
          })
        
        var newAttrs:[UICollectionViewLayoutAttributes] = []
        
        attrs!.forEach({ (attr) in
            if attr.representedElementKind == UICollectionView.elementKindSectionHeader {
                let attr1 = self.layoutAttributesForSupplementaryView(ofKind:UICollectionView.elementKindSectionHeader, at: attr.indexPath)
                newAttrs.append(attr1!)
            } else if attr.representedElementKind == UICollectionView.elementKindSectionFooter {
                let attr2 = self.layoutAttributesForSupplementaryView(ofKind:UICollectionView.elementKindSectionFooter, at: attr.indexPath)
                newAttrs.append(attr2!)
            } else {
                newAttrs.append(attr)
            }
        })
    
        return attrs
        
//        let attributes = super.layoutAttributesForElements(in: rect)

//        attributes!.forEach({ (attr) in
//            let decorations = self.layoutAttributesForDecorationView(ofKind: "DecorationView", at: attr.indexPath)
//            if let decorate = decorations, rect.intersects(decorate.frame){
//                newAttrs.append(decorate)
//            }
//        })
//        return newAttrs;
//        attributes?.append(contentsOf: self.sectionAttrs.values.filter{
//            return rect.intersects($0.frame)
//        })
//        var newAttrs = [UICollectionViewLayoutAttributes]()
    }
    

    override func layoutAttributesForDecorationView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = super.layoutAttributesForDecorationView(ofKind: elementKind, at: indexPath)
        
//        if elementKind == "DecorationView" {
//            let section = indexPath.section
//            attributes?.frame = sectionAttrs[section].frame
//        }
        return attributes
    }

    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = super.layoutAttributesForSupplementaryView(ofKind: elementKind, at: indexPath)
        if elementKind == UICollectionView.elementKindSectionHeader {
           attributes?.size = CGSize(width: CGFloat(attributes!.frame.size.width), height: 10)
        } else if elementKind == UICollectionView.elementKindSectionFooter {
            attributes?.size = CGSize(width: CGFloat(attributes!.frame.size.width), height: 10)
        }
        return attributes
    }
    
//    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
//        return true
//    }
}

