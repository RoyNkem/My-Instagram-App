//
//  InstagramFeedActionsTableViewCell.swift
//  Instagram
//
//  Created by Roy Aiyetin on 02/07/2022.
//

import UIKit

protocol InstagramFeedActionsTableViewCellDelegate: AnyObject {
    func didTapLikeButton()
    func didTapCommentButton()
    func didTapShareButton()
}

final class InstagramFeedActionsTableViewCell: UITableViewCell {
    
    public weak var delegate: InstagramFeedActionsTableViewCellDelegate?
    
    static let identifier = "InstagramFeedActionsTableViewCell"
    
    //MARK: - Declare UI Elememts
    private let likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "heart"), for: .normal)
        button.tintColor = .label
        return button
    }()
    
    private let commentButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        button.setImage(UIImage(named: "message"), for: .normal)
        return button
    }()
    
    private let shareButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "arrow.uturn.right"), for: .normal)
        button.tintColor = .label
        return button
    }()
    
    //MARK: INIT
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubviews(likeButton, shareButton, commentButton)
        
        likeButton.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
        commentButton.addTarget(self, action: #selector(didTapCommentButton), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(didTapShareButton), for: .touchUpInside)
    }
    
    @objc private func didTapLikeButton() {
        delegate?.didTapLikeButton()
    }
    @objc private func didTapCommentButton() {
        delegate?.didTapCommentButton()
        
    }
    @objc private func didTapShareButton() {
        delegate?.didTapShareButton()
        
    }
    
    public func configure(with post: String) {
        //configure cell content
        
    }
    
    //MARK: Frame Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //like, comment, send buttons
        //since the buttons are all similar, lets iterate through a single frame size using one variable: buttonSize
        let buttonSize: CGFloat = contentView.height - 10
        let buttons = [likeButton, commentButton, shareButton]
        
        for x in 0..<buttons.count {//Very smart
            let button = buttons[x] // x = 0,1,2
            button.frame = CGRect(x: (CGFloat(x) * buttonSize) + (10 * CGFloat(x+1)),
                                  y: 5, width: buttonSize, height: buttonSize)
        }
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
}
