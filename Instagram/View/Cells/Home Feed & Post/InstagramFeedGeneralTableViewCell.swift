//
//  InstagramFeedGeneralTableViewCell.swift
//  Instagram
//
//  Created by Roy Aiyetin on 02/07/2022.
//

import UIKit

protocol InstagramFeedGeneralTableViewCellDelegate: AnyObject {
    func didTapShowMoreCommentsButton()
    func didTapCommentLikeButton()
}

final class InstagramFeedGeneralTableViewCell: UITableViewCell {

    public weak var delegate: InstagramFeedGeneralTableViewCellDelegate?

    static let identifier = "InstagramFeedGeneralTableViewCell"
        
    //MARK: - Declare UI Elements
    private let showMoreCommentsButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .thin)
        return button
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 13, weight: .medium)
        return label
    }()
    
    private let comments: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    
    private let likeButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 10, weight: .thin)
        let image = UIImage(systemName: "heart", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .label
        return button
    }()
    
    //MARK: - INIT
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        contentView.backgroundColor = .systemOrange
        contentView.addSubviews(showMoreCommentsButton, comments, usernameLabel, likeButton)
        
        showMoreCommentsButton.addTarget(self, action: #selector(didTapShowMoreCommentsButton), for: .touchUpInside)
        likeButton.addTarget(self, action: #selector(didTapCommentLikeButton), for: .touchUpInside)
    }
    
    @objc func didTapShowMoreCommentsButton() {
        delegate?.didTapShowMoreCommentsButton()
    }
    @objc func didTapCommentLikeButton() {
        delegate?.didTapCommentLikeButton()
        
        //show animation for like button
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configure model
    public func configure(with model: [PostComment]) {
        
        //configure cell content
//        usernameLabel.text = model.last?.username
        usernameLabel.text = "adam.link"
        showMoreCommentsButton.setTitle("View all 30 comments", for: .normal)
        comments.text = model.first?.text
//        comments.text = " I would like to get some for my new home"
        
    }
    
    //MARK: - VIEW LAYOUT
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let size = contentView.height/2
        showMoreCommentsButton.frame = CGRect(x: 18, y: 0, width: contentView.width/3, height: size)
        usernameLabel.frame = CGRect(x: 20, y: showMoreCommentsButton.bottom, width: contentView.width/6, height: size)
        comments.frame = CGRect(x: usernameLabel.right, y: showMoreCommentsButton.bottom, width: contentView.width - usernameLabel.width, height: size)
        
        let buttonSize = contentView.height/4
        likeButton.frame = CGRect(x: contentView.width - (buttonSize + 15), y: showMoreCommentsButton.bottom + buttonSize/2, width: buttonSize, height: buttonSize)
    }
    
}
