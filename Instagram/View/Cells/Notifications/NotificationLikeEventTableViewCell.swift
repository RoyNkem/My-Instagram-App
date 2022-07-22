//
//  NotificationLikeEventTableViewCell.swift
//  Instagram
//
//  Created by Roy Aiyetin on 10/07/2022.
//

import UIKit
import SDWebImage

protocol NotificationLikeEventTableViewCellDelegate: AnyObject {
    func didTapRelatedPostButton(model: UserNotification)
}

class NotificationLikeEventTableViewCell: UITableViewCell {
    
    static let identifier = "NotificationLikeEventTableViewCell"
    
    private var model: UserNotification?
    
    public weak var delegate: NotificationLikeEventTableViewCellDelegate?
    
    //MARK: - Declare UI Elements
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
//        imageView.image = UIImage(named: "Roy3")
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.secondaryLabel.cgColor
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
//        label.text = "Joe_king liked your photo"
        label.font = .systemFont(ofSize: 13, weight: .light)
        label.numberOfLines = 0
        return label
    }()
    
    private let postButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        return button
    }()
    
    //MARK: - INIT
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.clipsToBounds = true
        addSubviews(profileImageView, label, postButton)
        
        postButton.addTarget(self, action: #selector(didTapPostButton), for: .touchUpInside)
        
        selectionStyle = .none
    }
    
    @objc func didTapPostButton() {
        guard let model = model else { return }
        delegate?.didTapRelatedPostButton(model: model)
    }
    
    //MARK: - Configure Model
    public func configure(with model: UserNotification) {
        self.model = model
        
        switch model.type {
            
        case .like(let post): //this is where we configure the post image
            let thumbnail = post.thumbnailImage
            guard !thumbnail.absoluteString.contains("google.com") else { return } // To sample post
            postButton.sd_setBackgroundImage(with: thumbnail, for: .normal, completed: nil)
            
        case .follow:
            break
        }
        
        // populate UI elements with model
        label.text = model.text
        profileImageView.sd_setImage(with: model.user.profilePhoto)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        profileImageView.image = nil
        label.text = nil
        postButton.setTitle(nil, for: .normal)
        postButton.backgroundColor = nil
        postButton.layer.borderWidth = 0
    }
    
    //MARK: - Layout Views
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let photoWidth = contentView.height - 20
        profileImageView.frame = CGRect(x: 10, y: 10, width: photoWidth, height: photoWidth)
        profileImageView.layer.cornerRadius = profileImageView.height/2
        
        let size = contentView.height - 12
        label.frame = CGRect(x: profileImageView.right + 15, y: 0,
                             width: contentView.width - size - profileImageView.width - 6,
                             height: contentView.height)
        
        postButton.frame = CGRect(x: contentView.width - size - 10, y: 6, width: size, height: size) // frame of thumbnail
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
