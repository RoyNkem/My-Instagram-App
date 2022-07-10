//
//  UserFollowTableViewCell.swift
//  Instagram
//
//  Created by Roy Aiyetin on 09/07/2022.
//

import UIKit

protocol UserFollowTableViewCellDelegate: AnyObject {
    func didTapFollowUnfollowButton(model: UserRelationship)
}

enum FollowState {
    case following, not_following
}

public struct UserRelationship {
    let username: String
    let name: String
    let type: FollowState
}

final class UserFollowTableViewCell: UITableViewCell {
    
    static let identifier = "UserFollowTableViewCell"
    
    public weak var delegate: UserFollowTableViewCellDelegate? //protocol must conform to AnyObject for weak declaration
    
    private var model: UserRelationship?
    
    //MARK: - Declare UI Elements
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true // for corner radius to work
        imageView.image = UIImage(named: "Roy1")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 13, weight: .light)
        label.text = "Joe Steve"
        return label
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.text = "Joe_king"
        return label
    }()
    
    private let followButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .link
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 4
        button.setTitle("Follow", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        return button
    }()
    
    //MARK: - INIT
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.clipsToBounds = true
        contentView.addSubviews(profileImageView,nameLabel,userNameLabel,followButton)
        
        selectionStyle = .none // color of cell when selected/tapped
        
        followButton.addTarget(self, action: #selector(didTapFollowButton), for: .touchUpInside)
    }
    
    @objc func didTapFollowButton() {
        guard let model = model else {
            return
        }
        delegate?.didTapFollowUnfollowButton(model: model)
    }
    
    //Exchange between model data and labels in cell
    public func configure(with model: UserRelationship) {
        self.model = model
        
        userNameLabel.text = model.username
        nameLabel.text = model.name
        switch model.type {
        case .following:
            // show unfollow button
            followButton.setTitle("Unfollow", for: .normal)
            followButton.setTitleColor(.label, for: .normal)
            followButton.backgroundColor = .systemBackground
            followButton.layer.borderWidth = 1
            followButton.layer.borderColor = UIColor.secondaryLabel.cgColor
        case .not_following:
            // show follow button
            followButton.setTitle("Follow", for: .normal)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        //    Make sure prior cell values is not accidentally reused in the next one
        profileImageView.image = nil
        nameLabel.text = nil
        userNameLabel.text = nil
        followButton.setTitle(nil, for: .normal)
        followButton.layer.borderWidth = 0
        followButton.backgroundColor = nil
    }
    
    //MARK: - Assign Frames
    override func layoutSubviews() {
        super.layoutSubviews()
        
        profileImageView.frame = CGRect(x: 3, y: 3, width: contentView.height - 6, height: contentView.height - 6)
        profileImageView.layer.cornerRadius = profileImageView.width/2

        let buttonWidth = contentView.width > 500 ? 200.0 : contentView.width/5
        followButton.frame = CGRect(x: contentView.width - buttonWidth - 5, y: contentView.height/3, width: buttonWidth, height: contentView.height/3)
        
        let labelHeight = (contentView.height - 5)/4
        userNameLabel.frame = CGRect(x: profileImageView.right + 10, y: labelHeight, width: contentView.width - profileImageView.width - 8 - buttonWidth, height: labelHeight)
        nameLabel.frame = CGRect(x: profileImageView.right + 10, y: userNameLabel.bottom + 5, width: contentView.width - profileImageView.width - 8 - buttonWidth, height: labelHeight)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
