//
//  BaseHeaderView.swift
//  SwiftScrollBanner
//
//  Created by shenjie on 2021/2/26.
//

import UIKit

class BaseHeaderView: UICollectionReusableView {
    
    private var textLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textLabel = UILabel()
        textLabel.font = UIFont.systemFont(ofSize: 20)
        textLabel.textAlignment = .center
        textLabel.text = "Header"
        self.addSubview(textLabel)
        self.backgroundColor = .orange
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textLabel.frame = bounds
    }
}
