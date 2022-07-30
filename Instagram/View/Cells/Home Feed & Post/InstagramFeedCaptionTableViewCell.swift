//
//  InstagramFeedCaptionTableViewCell.swift
//  Instagram
//
//  Created by Roy Aiyetin on 30/07/2022.
//

import UIKit

class InstagramFeedCaptionTableViewCell: UITableViewCell {
    
    static let identifier = "InstagramFeedCaptionTableViewCell"
    
    //MARK: Declare UI Elements
    private let numberOfLikes: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 13, weight: .medium)
        return label
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 13, weight: .medium)
        return label
    }()
    
    private let captionText: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    
    private let datePosted: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 11, weight: .thin)
        return label
    }()
    
//MARK: - INIT
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemRed
//        contentView.addSubviews(numberOfLikes, captionText, usernameLabel, datePosted)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//MARK: - VIEWS LAYOUT
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let size = contentView.height/3
        numberOfLikes.frame = CGRect(x: 20, y: 0, width: contentView.width, height: size)
        usernameLabel.frame = CGRect(x: 20, y: numberOfLikes.bottom, width: contentView.width/6, height: size)
        captionText.frame = CGRect(x: usernameLabel.right + 3, y: numberOfLikes.bottom, width: contentView.width - usernameLabel.width, height: size)
        datePosted.frame = CGRect(x: 20, y: usernameLabel.bottom, width: contentView.width, height: size)
    }
  
//MARK: Configure Content
    public func configure(with model: UserPost) {
        usernameLabel.text = model.owner.username
        numberOfLikes.text = "151 likes"
        captionText.text = model.caption
        datePosted.text = "28 July 2022"
//        datePosted.text = model.createdDate
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
