//
//  HomeViewController.swift
//  Instagram
//
//  Created by Roy Aiyetin on 01/07/2022.
//

import UIKit
import FirebaseAuth

//MARK: - MODELS
struct HomeFeedRenderViewModel {
    let header: PostRenderViewModel
    let post: PostRenderViewModel
    let action: PostRenderViewModel
    let captions: PostRenderViewModel
    let comments: PostRenderViewModel
}

class HomeViewController: UIViewController {
    
    private var feedRenderModels = [HomeFeedRenderViewModel]()
    
    private let tableView: UITableView = {
        
        let tableView = UITableView()
        tableView.register(InstagramFeedPostTableViewCell.self, forCellReuseIdentifier: InstagramFeedPostTableViewCell.identifier)
        tableView.register(InstagramFeedHeaderTableViewCell.self, forCellReuseIdentifier: InstagramFeedHeaderTableViewCell.identifier)
        tableView.register(InstagramFeedActionsTableViewCell.self, forCellReuseIdentifier: InstagramFeedActionsTableViewCell.identifier)
        tableView.register(InstagramFeedGeneralTableViewCell.self, forCellReuseIdentifier: InstagramFeedGeneralTableViewCell.identifier)
        tableView.register(InstagramFeedCaptionTableViewCell.self, forCellReuseIdentifier: InstagramFeedCaptionTableViewCell.identifier)
        return tableView
    }()
    
    //MARK: - VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubviews(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.backgroundColor = .systemBackground
        configureNavigationHeaderImage()

        createMockModels()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
    //check if user is logged in already
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        handleNotAuthenticated()
    }
    
    //MARK: - Configure models for use
    private func createMockModels() {
        
        var comments = [PostComment]()
        for i in 0..<2 {
            comments.append(PostComment(identifier: "123_\(i)",
                                        username: i % 2 == 0 ? "adam_link" : "solo.wonder",
                                        text: i % 2 == 0 ? "Great chairs" : "How do i get similar furnitures?",
                                        createdDate: Date(), likes: []))
        }
        
        let user = User(username: "Joe_king", bio: "Music Artist",
                        name: (first: "Steve", last: "Joe"), birthday: Date(),
                        profilePhoto: URL(string: "Roy3")!, gender: .male,
                        counts: UserCount(following: 1, followers: 1, posts: 3), joinDate: Date())
        
        let post = UserPost(identifier: "", postType: .photo,
                            thumbnailImage: URL(string: "Roy3")!,
                            postURL: URL(string: "https://www.google.com")!,
                            caption: "Trying on these new set of furnitures i got from IKEA", likeCount: [],
                            comments: comments, createdDate: Date(), taggedUser: [], owner: user)
        
        for _ in 0..<5 {
            let viewModel = HomeFeedRenderViewModel(header: PostRenderViewModel(renderType: .header(provider: user)),
                                                    post: PostRenderViewModel(renderType: .primaryContent(provider: post)),
                                                    action: PostRenderViewModel(renderType: .actions(provider: "")),
                                                    captions: PostRenderViewModel(renderType: .captions(provider: post)),
                                                    comments: PostRenderViewModel(renderType: .comments(comments: comments)))
            
            feedRenderModels.append(viewModel) // only one section
            
        }
    }
    
    //MARK: - Configure Navigation Header
    private func configureNavigationHeaderImage() {
        //left text logo
        let logo = UIImageView()
        logo.image = UIImage(named: "blacktextlogo")
        logo.contentMode = .scaleAspectFit
        logo.frame = CGRect(x: 0, y: 0, width: 100, height: 25)
//        logo.backgroundColor = .red
        self.navigationItem.titleView = logo
        
        //right bar buttons for new post and chat
        let addbutton = UIBarButtonItem(image: UIImage(systemName: "plus.app"), style: .plain, target: self, action: #selector(didTapAddButton))
        addbutton.tintColor = .label

        let chatbutton = UIBarButtonItem(image: UIImage(systemName: "message"), style: .plain, target: self, action: #selector(didTapChatButton))
        chatbutton.tintColor = .label

        navigationItem.rightBarButtonItems = [chatbutton, addbutton]
    }
    
    @objc private func didTapAddButton() {
        //dd
    }
    @objc private func didTapChatButton() {
        //dd
        let chatVC = ChatViewController()
        navigationItem.backButtonTitle = "roy.aiyetin"
        navigationController?.pushViewController(chatVC, animated: true)
    }
    
    //MARK: - Logout if not authenticated
    private func handleNotAuthenticated() {
        //Check Auth status
        if Auth.auth().currentUser == nil {
            // show loginVC
            let loginVC = LoginViewController()
            
            loginVC.modalPresentationStyle = .fullScreen
            
            present(loginVC, animated: false)
        }
    }
}

//MARK: - EXTENSION

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return feedRenderModels.count * 5 // 5 sections
    }
    
    //MARK: - Number of subsections
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let x = section
        let model: HomeFeedRenderViewModel
        
        if x == 0 { // special case
            model = feedRenderModels[0]
        }
        ///Design an expression to make subsection
        //for each batch of 4 sections we want to use the same model
        else {// from calculation -> (x section, subsection) = (1, 0) (2, 0) (3, 0) || (4, 1) (5, 1) (6, 1)
            let subsection = x % 5 == 0 ? x/5 : ((x - (x % 5)) / 5) // modulus operator returns the remainder after dividing
            model = feedRenderModels[subsection] // grab the respective position defined above
        }
        
        // for values of x above
        let subsection = x % 5
        
        if subsection == 0 {
            // header
            return 1
        }
        else if subsection == 1 {
            // post
            return 1
        }
        else if subsection == 2 {
            // actions
            return 1
        }
        else if subsection == 3 {
            // caption
            return 2
        }
        else if subsection == 4 {
            // comments
            switch model.comments.renderType { // number of rows to display comments in home feed
            case .comments(let comments): return comments.count > 2 ? 2 : comments.count
            case .header, .actions, .primaryContent, .captions: return 0
            }
        }
        return 0
        
    }
    
    //MARK: - Cell for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let x = indexPath.section
        let model: HomeFeedRenderViewModel
        
        if x == 0 { // special case
            model = feedRenderModels[0]
        }
        //for each batch of 4 sections we want to use the same model
        else {// from calculation -> (section, position) = (1, 0) (2, 0) (3, 0) || (4, 1) (5, 1) (6, 1)
            let subsection = x % 4 == 0 ? x/4 : ((x - (x % 4)) / 4) // modulus operator returns the remainder after dividing
            model = feedRenderModels[subsection] // grab the respective position defined above
        }
        
        let subsection = x % 4
        
        if subsection == 0 {
            // header
            switch model.header.renderType {
            case .header(let user):
                let cell = tableView.dequeueReusableCell(withIdentifier: InstagramFeedHeaderTableViewCell.identifier, for: indexPath) as! InstagramFeedHeaderTableViewCell
                cell.configure(with: user)
                cell.delegate = self
                return cell
                
            case .comments, .actions, .primaryContent, .captions: return UITableViewCell()
            }
        }
        else if subsection == 1 {
            // post
            switch model.post.renderType {
            case .primaryContent(let post):
                let cell = tableView.dequeueReusableCell(withIdentifier: InstagramFeedPostTableViewCell.identifier, for: indexPath) as! InstagramFeedPostTableViewCell
                cell.configure(with: post)
                return cell
                
            case .comments, .actions, .header, .captions: return UITableViewCell()
            }
        }
        else if subsection == 2 {
            // actions
            switch model.action.renderType {
            case .actions(let provider):
                let cell = tableView.dequeueReusableCell(withIdentifier: InstagramFeedActionsTableViewCell.identifier, for: indexPath) as! InstagramFeedActionsTableViewCell
                cell.configure(with: provider)
                cell.delegate = self
                return cell
                
            case .comments, .header, .primaryContent, .captions: return UITableViewCell()
            }
        }
        else if subsection == 3 {
            //captions
            switch model.captions.renderType {
            case .captions(let post):
                break
            case .header, .actions, .primaryContent, .comments: return UITableViewCell()
            }
        }
        else if subsection == 4 {
            switch model.comments.renderType {
            case .comments(let comments):
                let cell = tableView.dequeueReusableCell(withIdentifier: InstagramFeedGeneralTableViewCell.identifier, for: indexPath) as! InstagramFeedGeneralTableViewCell
                return cell
                
            case .header, .actions, .primaryContent, .captions: return UITableViewCell()
            }
        }
        return UITableViewCell()
    }
    
    //MARK: - Row Height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let subsection = indexPath.section % 4
        if subsection == 0 {
            //header
            return 50
        }
        else if subsection == 1 {
            //post
            return tableView.width
        }
        else if subsection == 2 {
            //actions
            return 50
        }
        else if subsection == 3 {
            //captions
            return 40
        }
        else if subsection == 4 {
            //comments
            return 50
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let subsection = section % 5
        if subsection == 4 { // comments subsection
            return 50 // spacing  between posts
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

//MARK: Header Delegate Methods
extension HomeViewController: InstagramFeedHeaderTableViewCellDelegate {
    func didTapMoreButton() {
        let actionSheet = UIAlertController(title: "Post options", message: nil, preferredStyle: .actionSheet)
        let reportAction = UIAlertAction(title: "Report Post", style: .destructive) { [weak self] _ in
            self?.reportPost()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        actionSheet.addActions(reportAction, cancel)
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    func reportPost() {
        
    }
}

//MARK: Action Buttons Delegate Methods

extension HomeViewController: InstagramFeedActionsTableViewCellDelegate {
    func didTapLikeButton() {
        //animate heart icon
    }
    
    func didTapCommentButton() {
        //show textfield to comment
    }
    
    func didTapShareButton() {
        //share post
    }
    
    func didTapSaveButton() {
        // bookmark post to view later
    }
}
