//
//  ProfileTabsCollectionReusableView.swift
//  Instagram
//
//  Created by Roy Aiyetin on 06/07/2022.
//

import UIKit

protocol ProfileTabsCollectionReusableViewDelegate: AnyObject {
    func didTapGridButtonTab(_ header: ProfileTabsCollectionReusableView)
    func didTapTaggedButtonTab(_ header: ProfileTabsCollectionReusableView)
    func didTapVideoButtonTab(_ header: ProfileTabsCollectionReusableView)
}

struct Constants {
    static let padding: CGFloat = 5
}

final class ProfileTabsCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "ProfileTabsCollectionReusableView"
    
    public weak var delegate: ProfileTabsCollectionReusableViewDelegate?
    
    //MARK: - Declaring UI Elements
    private let gridButton: UIButton = {
        let button = UIButton()
        let boldConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium, scale: .default)
        button.setImage(UIImage(systemName: "square.grid.3x3", withConfiguration: boldConfig), for: .normal)
        button.tintColor = .systemBlue
        return button
    }()
    
    private let videoButton: UIButton = {
        let button = UIButton()
        let boldConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .medium, scale: .default)
        button.setImage(UIImage(systemName: "play", withConfiguration: boldConfig), for: .normal)
        button.tintColor = .lightGray
        return button
    }()
    
    private let taggedButton: UIButton = {
        let button = UIButton()
        let boldConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium, scale: .default)
        button.setImage(UIImage(systemName: "tag", withConfiguration: boldConfig), for: .normal)
        button.tintColor = .lightGray
        return button
    }()
    
    //MARK: - INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        
        addButtonActions()
        
        addSubviews(gridButton, taggedButton, videoButton)
        
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addButtonActions() {
        gridButton.addTarget(self, action: #selector (didTapGridButton), for: .touchUpInside)
        taggedButton.addTarget(self, action: #selector (didTapTaggedButton), for: .touchUpInside)
        videoButton.addTarget(self, action: #selector (didTapVideoButton), for: .touchUpInside)
    }
    
    //MARK: - Action Selectors
    // the view controller should handle the functions rather than the cell class
    @objc func didTapGridButton() { //leverage the delegates to tell the view controller what happens so it knows where the button call comes from
        delegate?.didTapGridButtonTab(self)
        gridButton.tintColor = .systemBlue
        taggedButton.tintColor = .lightGray
        videoButton.tintColor = .lightGray
    }
    
    @objc func didTapTaggedButton() {
        delegate?.didTapTaggedButtonTab(self)
        gridButton.tintColor = .lightGray
        taggedButton.tintColor = .systemBlue
        videoButton.tintColor = .lightGray
    }
    
    @objc func didTapVideoButton() {
        delegate?.didTapVideoButtonTab(self)
        gridButton.tintColor = .lightGray
        taggedButton.tintColor = .lightGray
        videoButton.tintColor = .systemBlue
    }
    
    //MARK: - Assign Frames
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let size = height - Constants.padding
        let gridButtonX = (width - (3 * size))/6
        
        gridButton.frame = CGRect(x: gridButtonX, y: Constants.padding, width: size, height: size)
        videoButton.frame = CGRect(x: 2 * gridButtonX + gridButton.right, y: Constants.padding, width: size, height: size)
        taggedButton.frame = CGRect(x: 2 * gridButtonX + videoButton.right, y: Constants.padding, width: size, height: size)
    }
}
