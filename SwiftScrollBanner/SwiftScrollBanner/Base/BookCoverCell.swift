//
//  BookCoverCell.swift
//  SwiftScrollBanner
//
//  Created by shenjie on 2021/3/19.
//

import UIKit

class BookCoverCell: UICollectionViewCell {
    private var coverImage: UIImageView!
    
    var imageNmae: String = "" {
        didSet {
            coverImage.image = UIImage(named: imageNmae)
        }
    }
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        coverImage = UIImageView()
        contentView.addSubview(coverImage)
        backgroundColor = .gray
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        coverImage.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
