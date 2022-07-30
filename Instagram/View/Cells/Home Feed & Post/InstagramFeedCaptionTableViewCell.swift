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
        label.font = .systemFont(ofSize: 13, weight: .thin)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemOrange
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
  
}
