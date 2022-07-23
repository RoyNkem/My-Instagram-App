//
//  InstagramFeedTableViewCell.swift
//  Instagram
//
//  Created by Roy Aiyetin on 02/07/2022.
//

import UIKit
import SDWebImage
import AVFoundation

///Cell for primary post content
final class InstagramFeedPostTableViewCell: UITableViewCell {
    
    static let identifier = "InstagramFeedPostTableViewCell"
    
    //MARK: - Declare UI Elements
    
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var player: AVPlayer?
    private var playerLayer = AVPlayerLayer()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.layer.addSublayer(playerLayer) // must come before adding subviews
        contentView.addSubviews(postImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // //MARK: - Update the Post Content
    public func configure(with post: UserPost) {
        postImageView.image = UIImage(named: "text")
        
        return
        
        switch post.postType {
        case .photo:
            postImageView.sd_setImage(with: post.postURL, completed: nil)
        case .video:
            //load and play video
            player = AVPlayer(url: post.postURL)
            playerLayer.player = player
            playerLayer.player?.volume = 0
            playerLayer.player?.play()
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        playerLayer.frame = contentView.bounds
        postImageView.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postImageView.image = nil
    }
}
