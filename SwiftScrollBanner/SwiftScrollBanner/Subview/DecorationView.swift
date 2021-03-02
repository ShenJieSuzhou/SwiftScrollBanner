//
//  DecorationView.swift
//  SwiftScrollBanner
//
//  Created by shenjie on 2021/2/26.
//

import UIKit

class DecorationView: UICollectionReusableView {
    
    var dcv: UIImageView!
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        dcv = UIImageView(frame: frame)
        dcv.image = UIImage(named: "123")
        self.addSubview(dcv)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        dcv.frame = self.bounds
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        
    }
}
