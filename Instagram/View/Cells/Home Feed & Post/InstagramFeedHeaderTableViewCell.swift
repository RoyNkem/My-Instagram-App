//
//  InstagramFeedHeaderTableViewCell.swift
//  Instagram
//
//  Created by Roy Aiyetin on 02/07/2022.
//

import UIKit
import SDWebImage

protocol InstagramFeedHeaderTableViewCellDelegate: AnyObject {
    func didTapMoreButton()
}

final class InstagramFeedHeaderTableViewCell: UITableViewCell {
    
    public weak var delegate: InstagramFeedHeaderTableViewCellDelegate?

    static let identifier = "InstagramFeedHeaderTableViewCell"
    
        //MARK: - Declare UI Elements
    private let profilePhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    private let moreButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        button.setImage(UIImage(named: "ellipsis"), for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubviews(profilePhotoImageView, usernameLabel, moreButton)
        
        moreButton.addTarget(self, action: #selector(didTapMoreButton), for: .touchUpInside)
    }
    
    @objc func didTapMoreButton() {
        delegate?.didTapMoreButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Update Content of Header
    public func configure(with model: User) {
        usernameLabel.text = model.username
        profilePhotoImageView.image = UIImage(named: "Roy2")
        
//        profilePhotoImageView.sd_setImage(with: model.profilePhoto, completed: nil)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let size = contentView.height/4
        profilePhotoImageView.frame = CGRect(x: 2, y: 2, width: size, height: size)
        profilePhotoImageView.layer.cornerRadius = size/2
        
        usernameLabel.frame = CGRect(x: profilePhotoImageView.right + 10, y: 2, width: contentView.width - (size - 2) - 15, height: contentView.height - 4)
        
        moreButton.frame = CGRect(x: contentView.width - size, y: 2, width: size, height: size)
      
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        usernameLabel.text = nil
        profilePhotoImageView.image = nil
    }
}
