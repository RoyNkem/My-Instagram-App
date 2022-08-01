//
//  PhotoCollectionViewCell.swift
//  Instagram
//
//  Created by Roy Aiyetin on 06/07/2022.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PhotoCollectionViewCell"
    
    //MARK: - DECLARE UI ELEMENTS
    private let photoImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        photoImageView.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        photoImageView.image = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubviews(photoImageView)
        contentView.clipsToBounds = true
        accessibilityLabel = "User post image"
        accessibilityHint = "Double Tap to open post"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Congigure cell with a model
//    public func configure(with model: UserPost) {
//        let url = model.thumbnailImage
//        photoImageView.sd_setImage(with: url, completed: nil)
//    }
    
    public func configure(with ImageName: String) {
        
        for x in 0..<100 {
            photoImageView.image = UIImage(named: x % 2 == 0 ? "Chair" : "Chair")
        }
    }
}
