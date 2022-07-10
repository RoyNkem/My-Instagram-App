//
//  noNotificationsView.swift
//  Instagram
//
//  Created by Roy Aiyetin on 10/07/2022.
//

import UIKit

class NoNotificationsView: UIView {
    
    //MARK: - Declaring UI Elements
    private let label : UILabel = {
        let label = UILabel()
        label.text = "You have no notifications"
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    private let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .secondaryLabel
        imageView.image = UIImage(systemName: "bell")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews(label, imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = CGRect(x: (width - 50)/2, y: 0, width: 50, height: 50).integral
        label.frame = CGRect(x: 10, y: imageView.bottom, width: width - 20, height: height - 50).integral
    }
    
}
