//
//  ExploreViewController.swift
//  Instagram
//
//  Created by Roy Aiyetin on 01/07/2022.
//

import UIKit

/// Explorer View Controller
final class ExploreViewController: UIViewController {
    
    private var models = [UserPost]()
    
    //MARK: - Define UI Elements
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.backgroundColor = .systemBackground
        return searchBar
    }()
    
    private let dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.isHidden = true
        return view
    }()
    
    private var tabbedSearchCollectionView: UICollectionView?
    
    private var collectionView: UICollectionView?
    
    //MARK: - VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSearchBar()
        configureExplorerCollectionLayout()
        configureGesture()
        configureTabbedSearch()
        
        guard let collectionView = collectionView,
              let tabbedSearchCollectionView = tabbedSearchCollectionView
        else {
            return
        }
        
        view.addSubviews(collectionView, dimmedView, tabbedSearchCollectionView)
    }
    
    //MARK: - Configure Functions
    private func configureSearchBar() {
        navigationController?.navigationBar.topItem?.titleView = searchBar
        searchBar.delegate = self
    }
    
    private func configureExplorerCollectionLayout() {
        let layout = UICollectionViewFlowLayout()
        let itemSize = (view.width - 4)/3
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1)
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
    }
    
    private func configureGesture() {
        // dismiss search if user taps anywhere on the screen apart from keyboard
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didCancelSearch))
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouchesRequired = 1
        dimmedView.addGestureRecognizer(gesture)
    }
    
    private func configureTabbedSearch() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.width/3, height: 52)
        layout.scrollDirection = .horizontal
        tabbedSearchCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        tabbedSearchCollectionView?.isHidden = true
        tabbedSearchCollectionView?.delegate = self
        tabbedSearchCollectionView?.dataSource = self
        tabbedSearchCollectionView?.backgroundColor = .yellow
    }
    
    //MARK: - VIEW LAYOUT
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView?.frame = view.bounds
        collectionView?.clipsToBounds = true
        
        dimmedView.frame = view.bounds
        tabbedSearchCollectionView?.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.width, height: 72)
    }
}

//MARK: - Collection View Delegate Methods

extension ExploreViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as? PhotoCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let user = User(username: "Joe_king", bio: "Music Artist",
                        name: (first: "Steve", last: "Joe"), birthday: Date(), profilePhoto: URL(string: "Roy3")!, gender: .male,
                        counts: UserCount(following: 1, followers: 1, posts: 3), joinDate: Date())
        
        let post = UserPost(identifier: "", postType: .photo,
                            thumbnailImage: URL(string: "Roy3")!,
                            postURL: URL(string: "https://www.google.com")!,
                            caption: "", likeCount: [],
                            comments: [], createdDate: Date(), taggedUser: [], owner: user)
        
        let vc = PostViewController(model: post)
        vc.navigationItem.title = post.postType.rawValue
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

//MARK: - SearchBar Delegate Methods
extension ExploreViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        didCancelSearch()
        
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
        query(text)
        
    }
    
    func query(_ text: String) {
        //perforn the search in the backend
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didCancelSearch))
        
        //animate dim View to show for background when using search bar
        dimmedView.isHidden = false
        UIView.animate(withDuration: 0.2) {
            self.dimmedView.alpha = 0.4
        } completion: { done in
            self.tabbedSearchCollectionView?.isHidden = false
        }
        
    }
    
    @objc func didCancelSearch() {
        searchBar.resignFirstResponder()
        navigationItem.rightBarButtonItem = nil
        
        self.tabbedSearchCollectionView?.isHidden = true

        UIView.animate(withDuration: 0.2) {
            self.dimmedView.alpha = 0.4
        } completion: { done in
            if done {
                self.dimmedView.isHidden = true
            }
        }
    }
    
}
