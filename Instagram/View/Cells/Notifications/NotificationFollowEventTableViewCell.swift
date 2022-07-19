//
//  NotificationFollowEventTableViewCell.swift
//  Instagram
//
//  Created by Roy Aiyetin on 10/07/2022.
//

import UIKit
import SDWebImage

protocol NotificationFollowEventTableViewCellDelegate: AnyObject {
    func didTapFollowUnfollowButton(model: UserNotification)
}

class NotificationFollowEventTableViewCell: UITableViewCell {
    
    static let identifier = "NotificationFollowEventTableViewCell"
    
    public weak var delegate: NotificationFollowEventTableViewCellDelegate?
    
    private var model: UserNotification?
    
    //MARK: - Declare UI Elements
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.secondaryLabel.cgColor
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
//        label.text = "Joe_king started following you"
        label.font = .systemFont(ofSize: 13, weight: .light)
        label.numberOfLines = 0
        return label
    }()
    
    private let followButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 4
        return button
    }()
    
    //MARK: - INIT
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.clipsToBounds = true
        addSubviews(profileImageView, label, followButton)
        
        followButton.addTarget(self, action: #selector(didTapFollowButton), for: .touchUpInside)
    }
    
    @objc func didTapFollowButton() {
        guard let model = model else {
            return
        }
        delegate?.didTapFollowUnfollowButton(model: model)
    }
    
    public func configure(with model: UserNotification) {
        self.model = model
        
        switch model.type {
        case .like(_):
            break
            
        case .follow(let state):
            //configure button
            switch state {
            case .following:
                followButton.setTitle("Unfollow", for: .normal)
                followButton.setTitleColor(.label, for: .normal)
                followButton.layer.borderWidth = 1
                followButton.layer.borderColor = UIColor.systemBackground.cgColor
                
            case .not_following:
                followButton.setTitle("Follow", for: .normal)
                followButton.setTitleColor(.white, for: .normal)
                followButton.layer.borderWidth = 0
                followButton.backgroundColor = .link

            }
            
            label.text = model.text
            profileImageView.sd_setImage(with: model.user.profilePhoto, completed: nil)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        profileImageView.image = nil
        label.text = nil
        followButton.setTitle(nil, for: .normal)
        followButton.backgroundColor = nil
        followButton.layer.borderWidth = 0
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let photoWidth = contentView.height - 6
        profileImageView.frame = CGRect(x: 3, y: 3, width: photoWidth, height: photoWidth)
        profileImageView.layer.cornerRadius = profileImageView.height/2
        
        let size = contentView.height - 5
        
        label.frame = CGRect(x: profileImageView.right + 20, y: 0,
                             width: contentView.width - size - profileImageView.width - 6,
                             height: contentView.height)
        
        let buttonHeight: CGFloat = contentView.height/2
        followButton.frame = CGRect(x: contentView.width - size - 30, y: buttonHeight/2, width: size + 20, height: buttonHeight)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
