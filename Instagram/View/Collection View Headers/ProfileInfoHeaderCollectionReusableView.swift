//
//  ProfileInfoHeaderCollectionReusableView.swift
//  Instagram
//
//  Created by Roy Aiyetin on 06/07/2022.
//

import UIKit

protocol ProfileInfoHeaderCollectionReusableViewDelegate: AnyObject {
    func profileHeaderDidTapPostButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapEditButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapFollowersButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapFollowingButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapExtraButton(_ header: ProfileInfoHeaderCollectionReusableView)
}

final class ProfileInfoHeaderCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "ProfileInfoHeaderCollectionReusableView"
    
    public weak var delegate: ProfileInfoHeaderCollectionReusableViewDelegate?
    
    private var isActive: Bool = false

    //MARK: - Declare UI Elements
    private let profilePhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: "Roy2")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.secondaryLabel.cgColor
        return imageView
    }()
    
    private let postButton: UIButton = {
        let button = UIButton()
        button.setTitle("Posts", for: .normal)
        button.backgroundColor = .systemBackground
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return button
    }()
    
    private let followersButton: UIButton = {
        let button = UIButton()
        button.setTitle("Followers", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .systemBackground
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return button
    }()
    
    private let followingButton: UIButton = {
        let button = UIButton()
        button.setTitle("Following", for: .normal)
        button.backgroundColor = .systemBackground
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return button
    }()
    
    private let nameLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Roy Aiyetin"
        label.textColor = .label
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    private let bioLabel: UILabel = {
        
        let label = UILabel()
        label.text = "iOS Developer. Building UpTide with SwiftUI. Learning more about life everyday"
        label.textColor = .label
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.numberOfLines = 0
        return label
    }()
    
    private let editProfileButton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit Profile", for: .normal)
        button.backgroundColor = .systemBackground
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 4
        button.setTitleColor(.label, for: .normal)
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.secondaryLabel.cgColor
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        return button
    }()
    
    private let extraButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 4
        button.tintColor = .label
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.secondaryLabel.cgColor
        return button
    }()
    
    //MARK: - INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        
        addButtonActions()
        
        addSubviews(profilePhotoImageView, editProfileButton, followersButton, followingButton, postButton, nameLabel, bioLabel, extraButton)
        
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Buttons
    private func addButtonActions() {
        followersButton.addTarget(self, action: #selector (didTapFollowerButton), for: .touchUpInside)
        followingButton.addTarget(self, action: #selector (didTapFollowingButton), for: .touchUpInside)
        editProfileButton.addTarget(self, action: #selector (didTapEditProfileButton), for: .touchUpInside)
        postButton.addTarget(self, action: #selector (didTapPostButton) , for: .touchUpInside)
        extraButton.addTarget(self, action: #selector (didTapExtraButton), for: .touchUpInside)
    }
    
    //MARK: - Action Selectors
    // the view controller should handle the functions rather than the cell class
    @objc func didTapFollowerButton() { //leverage the delegates to tell the view controller what happens so it knows where the button call comes from
        delegate?.profileHeaderDidTapFollowersButton(self)

    }
    @objc func didTapFollowingButton() {
        delegate?.profileHeaderDidTapFollowingButton(self)

    }
    @objc func didTapEditProfileButton() {
        delegate?.profileHeaderDidTapEditButton(self)
        
    }
    @objc func didTapPostButton() {
        delegate?.profileHeaderDidTapPostButton(self)
    }
    
    @objc func didTapExtraButton() {
        delegate?.profileHeaderDidTapExtraButton(self)
        
        //change current button image after tap
        UIView.animate(withDuration: 0.2, animations: {
            // add animation
        }) { (done) in
            if self.isActive {
                self.isActive = false
                self.extraButton.setImage(UIImage(systemName: "chevron.up"), for: .normal)
            } else {
                self.isActive = true
                self.extraButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
            }

        }
    }
    
    //MARK: - Assign Frames
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let profilePhotoSize = width/4
        profilePhotoImageView.frame = CGRect(x: 12, y: 10, width: profilePhotoSize, height: profilePhotoSize).integral
        
        profilePhotoImageView.layer.cornerRadius = profilePhotoSize/2
        
        let buttonHeight = profilePhotoSize/2
        let countButtonWidth = (width - 10 - profilePhotoSize)/3
        
        postButton.frame = CGRect(x: profilePhotoImageView.right, y: 10, width: countButtonWidth, height: buttonHeight).integral
        
        followersButton.frame = CGRect(x: postButton.right, y: 10, width: countButtonWidth, height: buttonHeight).integral
        
        followingButton.frame = CGRect(x: followersButton.right, y: 10, width: countButtonWidth, height: buttonHeight).integral
        
        nameLabel.frame = CGRect(x: 12, y: 10 + profilePhotoImageView.bottom, width: countButtonWidth, height: 20).integral
        
        let bioLabelSize = bioLabel.sizeThatFits(self.frame.size)
        bioLabel.frame = CGRect(x: 12, y: 5 + nameLabel.bottom, width: width - 24, height: bioLabelSize.height).integral
        
        editProfileButton.frame = CGRect(x: 10, y: 15 + bioLabel.bottom, width: width - 70, height: buttonHeight - 20).integral
        
        extraButton.frame = CGRect(x: editProfileButton.right + 5, y: 15 + bioLabel.bottom, width: width - 30 - editProfileButton.width, height: buttonHeight - 20).integral
    }
    
}

//MARK: - EXTENSIONS


