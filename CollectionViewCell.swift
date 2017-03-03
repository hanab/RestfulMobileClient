//
//  CollectionViewCell.swift
//  RestfulMobileClient
//
//  Created by Hana  Demas on 2/24/17.
//  Copyright © 2017 ___HANADEMAS___. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class CollectionViewCell: UICollectionViewCell {
    
    // MARK: subviews
    private lazy var thumbnailImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.numberOfLines = 3
        label.font = UIFont.italicSystemFont(ofSize: 16)
        label.preferredMaxLayoutWidth = 100
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        return label
    }()
    
    //MARK: properties (setters for ui elements)
    var thumbnailUrl: String? = nil {
        didSet {
            thumbnailImageView.image = nil
            if thumbnailUrl != nil {
                loadThumbnailImage()
            }
        }
    }
    var title: String? {
        didSet {
            self.titleLabel.text = title
        }
    }
    
    //MARK: custom method (set the image of the uiimage view from network)
    private func loadThumbnailImage() {
        guard let imageUrl = thumbnailUrl else {
            return
        }
        UIImageView.loadImageFromUrl(imageUrlString: imageUrl) { (requestString, image) in
            if requestString == self.thumbnailUrl {
                self.thumbnailImageView.image = image
            }
        }
    }
    
    // add constraints to subviews
    func addConstraints() {
        thumbnailImageView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(0)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.center.equalTo(thumbnailImageView.snp.center)
        }
    }
    
    //MARK: Init methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        thumbnailImageView.addSubview(titleLabel)
        contentView.addSubview(thumbnailImageView)
        addConstraints()
    }
   
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
