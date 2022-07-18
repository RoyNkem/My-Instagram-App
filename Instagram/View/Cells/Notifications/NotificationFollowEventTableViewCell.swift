//
//  NotificationFollowEventTableViewCell.swift
//  Instagram
//
//  Created by Roy Aiyetin on 10/07/2022.
//

import UIKit

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
        imageView.image = UIImage(named: "Roy3")
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "Joe_king followed you"
        label.numberOfLines = 0
        return label
    }()
    
    private let followButton: UIButton = {
        let button = UIButton()
        
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
            
        case .follow:
            //configure button
            break
            
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
        
        let size = contentView.height - 4
        followButton.frame = CGRect(x: contentView.width - size, y: 2, width: size, height: size)
        
        label.frame = CGRect(x: profileImageView.right, y: 0,
                             width: contentView.width - size - profileImageView.width - 6,
                             height: contentView.height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
