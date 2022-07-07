//
//  ProfileTabsCollectionReusableView.swift
//  Instagram
//
//  Created by Roy Aiyetin on 06/07/2022.
//

import UIKit

class ProfileTabsCollectionReusableView: UICollectionReusableView {
        
    static let identifier = "ProfileTabsCollectionReusableView"

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .orange
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
