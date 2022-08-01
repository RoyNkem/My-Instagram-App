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
        label.font = .systemFont(ofSize: 13, weight: .medium)
        return label
    }()
    
    private let moreButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 18, weight: .regular)
        let image = UIImage(systemName: "ellipsis", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .label
        return button
    }()
    
    //MARK: - INIT
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubviews(profilePhotoImageView, usernameLabel, moreButton)
        
        moreButton.addTarget(self, action: #selector(didTapMoreButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapMoreButton() {
        delegate?.didTapMoreButton()
    }
    
    //MARK: - Update Content of Header
    public func configure(with model: User) {
        usernameLabel.text = model.username
        profilePhotoImageView.image = UIImage(named: "Roy2")
        
//        profilePhotoImageView.sd_setImage(with: model.profilePhoto, completed: nil)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let size = contentView.height/5
        profilePhotoImageView.frame = CGRect(x: size, y: size, width: size*3, height: size*3)
        profilePhotoImageView.layer.cornerRadius = profilePhotoImageView.height/2
        
        usernameLabel.frame = CGRect(x: profilePhotoImageView.right + 10, y: contentView.height/3, width: contentView.width - (size - 2) - 15, height: contentView.height/3)
        
        let buttonSize = contentView.height/3
        moreButton.frame = CGRect(x: contentView.width - (size + buttonSize + 15), y: buttonSize, width: buttonSize, height: buttonSize)
      
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        usernameLabel.text = nil
        profilePhotoImageView.image = nil
    }
}
