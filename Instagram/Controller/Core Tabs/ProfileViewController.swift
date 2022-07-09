//
//  ProfileViewController.swift
//  Instagram
//
//  Created by Roy Aiyetin on 01/07/2022.
//

import UIKit
import SDWebImage

/// Profile View Controller
final class ProfileViewController: UIViewController {
    
    private var collectionView: UICollectionView? // optional because instantiate with flowlayout
    
    private var userposts = [UserPost]()
    
    //MARK: - VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "roy.aiyetin"
        
        //cells layout
        collectionViewLayout()
        
        collectionView?.backgroundColor = .secondarySystemBackground
        
        //cell
        collectionView?.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        
        //Headers
        collectionView?.register(ProfileInfoHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileInfoHeaderCollectionReusableView.identifier)
        
        collectionView?.register(ProfileTabsCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileTabsCollectionReusableView.identifier)
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        guard let collectionView = collectionView else {
            return
        }
        
        view.addSubviews(collectionView)
        
        configureNavigationBar()
        
        view.backgroundColor = .systemBackground
    }
    
    private func collectionViewLayout() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1)
        let size = (view.width - 4)/3
        layout.itemSize = CGSize(width: size, height: size)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView?.frame = view.bounds
    }
    
    // set up settings gear as nav item
    func configureNavigationBar() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done
                                                            , target: self, action: #selector(didTapSettingsButton))
        //        self.navigationItem.backBarButtonItem?.title = ""
    }
    
    @objc func didTapSettingsButton() {
        let vc = SettingsViewController()
        vc.title = "Settings"
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - EXTENSION

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ProfileTabsCollectionReusableViewDelegate, ProfileInfoHeaderCollectionReusableViewDelegate {
    //MARK: - Collection View
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2 // section 0 & section 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        }
        //return userposts.count
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //        let model = userposts[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
        cell.configure(with: "Roy1")
        //        cell.configure(with: model)
        cell.backgroundColor = .systemBackground
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //get the model and open post controller
        //        let model = userposts[indexPath.row]
        
        let vc = PostViewController(model: nil)
        vc.navigationItem.title = "Posts"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    //MARK: - Supplementary views: Section header and tab
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard kind == UICollectionView.elementKindSectionHeader else {
            //footer
            return UICollectionReusableView()
        }
        
        if indexPath.section == 1 {
            //tabs header
            let tabControlHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileTabsCollectionReusableView.identifier, for: indexPath) as! ProfileTabsCollectionReusableView
            
            tabControlHeader.delegate = self
            return tabControlHeader
        } else {
            let profileHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileInfoHeaderCollectionReusableView.identifier, for: indexPath) as! ProfileInfoHeaderCollectionReusableView
            
            profileHeader.delegate = self
            return profileHeader
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        //height for supplementary views, width remains same
        if section == 0 { // section header height
            return CGSize(width: collectionView.width, height: collectionView.height/3.5)
        }
        // section tabs height
        return CGSize(width: collectionView.width, height: 50)
    }
    
    //MARK: - Profile Tab View Delegate
    func didTapGridButtonTab(_ header: ProfileTabsCollectionReusableView) {
        //reload collection view with data
    }
    func didTapTaggedButtonTab(_ header: ProfileTabsCollectionReusableView) {
        //reload collection view with data
        
    }
    func didTapVideoButtonTab(_ header: ProfileTabsCollectionReusableView) {
        //reload collection view with data
        
    }
    
    //MARK: - Profile Info View Delegate
    func profileHeaderDidTapEditButton(_ header: ProfileInfoHeaderCollectionReusableView) {
        let vc = EditProfileViewController()
        vc.navigationItem.title = "Edit Profile"
        let navVC = UINavigationController(rootViewController: vc)
        present(navVC, animated: true, completion: nil)
    }
    func profileHeaderDidTapPostButton(_ header: ProfileInfoHeaderCollectionReusableView) {
        //scroll to posts in collection view cells
        collectionView?.scrollToItem(at: IndexPath(row: 0, section: 1), at: .top, animated: true)
    }
    func profileHeaderDidTapFollowersButton(_ header: ProfileInfoHeaderCollectionReusableView) {
        let vc = ListViewController(data: ["Wizkid, Burna Boy, Davido, Trey Songz, Wiz Khalifa, Jay z"])
        vc.navigationItem.title = "Followers"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    func profileHeaderDidTapFollowingButton(_ header: ProfileInfoHeaderCollectionReusableView) {
        let vc = ListViewController(data: ["Wizkid, Burna Boy, Davido, Trey Songz, Wiz Khalifa, Jay z"])
        vc.navigationItem.title = "Following"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    func profileHeaderDidTapExtraButton(_ header: ProfileInfoHeaderCollectionReusableView) {
        collectionView?.scrollToItem(at: IndexPath(row: 0, section: 1), at: .top, animated: true)
    }
}


