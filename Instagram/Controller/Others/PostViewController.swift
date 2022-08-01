//
//  PostViewController.swift
//  Instagram
//
//  Created by Roy Aiyetin on 01/07/2022.
//

import UIKit

/*
 
 Section
 - Header model: Username, location & Drop down button
 Section
 - Post cell model: The picture or video
 Section
 - Action buttons cell model: Like, Share
 Section
 - n number of general cells for model
  
 */

//MARK: - Data Model
// model for our post sample
/// States of a rendered cell
enum PostRenderType {
    case header(provider: User) // profile picture, username
    case primaryContent(provider: UserPost) // post: picture or video
    case actions(provider: String) // like, share, comment buttons
    case captions(provider: UserPost) // number of likes, username, caption
    case comments(comments: [PostComment]) //comments
}
/// Model of  rendered post
struct PostRenderViewModel {
    let renderType: PostRenderType
}

class PostViewController: UIViewController {
    
    private var model: UserPost?
    
    private var renderModels = [PostRenderViewModel]() //each model/section has one property: renderType
    
    // initialize the PostViewController with a userpost model
    init(model: UserPost?) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        configureModels()
    }
    
    //MARK: - Defining TableView cells
    private let tableView: UITableView = {
        
        let tableView = UITableView()
        tableView.register(InstagramFeedPostTableViewCell.self, forCellReuseIdentifier: InstagramFeedPostTableViewCell.identifier)
        tableView.register(InstagramFeedHeaderTableViewCell.self, forCellReuseIdentifier: InstagramFeedHeaderTableViewCell.identifier)
        tableView.register(InstagramFeedActionsTableViewCell.self, forCellReuseIdentifier: InstagramFeedActionsTableViewCell.identifier)
        tableView.register(InstagramFeedGeneralTableViewCell.self, forCellReuseIdentifier: InstagramFeedGeneralTableViewCell.identifier)
        tableView.register(InstagramFeedCaptionTableViewCell.self, forCellReuseIdentifier: InstagramFeedCaptionTableViewCell.identifier)
        return tableView
    }()
    
    //MARK: - Model Configure data
    private func configureModels() {
//        guard let userPostModel = self.model else { return } //grab the model that came in from initializer of PostVC
        
        var comments = [PostComment]()
        for i in 0..<2 {
            comments.append(PostComment(identifier: "123_\(i)",
                                        username: i % 2 == 1 ? "adam_link" : "solo.wonder",
                                        text: i % 2 == 1 ? "Great chairs" : "How do i get similar furnitures?",
                                        createdDate: Date(), likes: []))
        }
        
        let user = User(username: "roy.aiyetin", bio: "Music Artist",
                        name: (first: "Steve", last: "Joe"), birthday: Date(), profilePhoto: URL(string: "Roy3")!, gender: .male,
                        counts: UserCount(following: 1, followers: 1, posts: 3), joinDate: Date())
        
        let post = UserPost(identifier: "", postType: .photo,
                            thumbnailImage: URL(string: "Roy3")!,
                            postURL: URL(string: "https://www.google.com")!,
                            caption: "Trying on these new set of furnitures i got from IKEA", likeCount: [],
                            comments: comments, createdDate: Date(), taggedUser: [], owner: user)
        
        //Header
        renderModels.append(PostRenderViewModel(renderType: .header(provider: user)))
        
        //Post
        renderModels.append(PostRenderViewModel(renderType: .primaryContent(provider: post)))
        
        //Action
        renderModels.append(PostRenderViewModel(renderType: .actions(provider: "")))
        
        //Caption
        renderModels.append(PostRenderViewModel(renderType: .captions(provider: post)))
        
        //4 Comments
        renderModels.append(PostRenderViewModel(renderType: .comments(comments: comments)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        view.addSubviews(tableView)
        view.backgroundColor = .systemBackground
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

//MARK: - EXTENSIONS

extension PostViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return renderModels.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch renderModels[section].renderType {
        case .actions(_): return 1
        case .comments(let comments): return comments.count > 4 ? 4 : comments.count
        case .header(_): return 1
        case .primaryContent(_): return 1
        case .captions(_): return 1
        }
        
    }
    
    //MARK: - TableView Cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = renderModels[indexPath.section] // we can switch renderType based on the section
        
        switch model.renderType {
        case .actions(let actions):
            let cell = tableView.dequeueReusableCell(withIdentifier: InstagramFeedActionsTableViewCell.identifier, for: indexPath) as! InstagramFeedActionsTableViewCell
            cell.delegate = self
            return cell
            
        case .header(let user):
            let cell = tableView.dequeueReusableCell(withIdentifier: InstagramFeedHeaderTableViewCell.identifier, for: indexPath) as! InstagramFeedHeaderTableViewCell
            cell.configure(with: user)
            cell.delegate = self
            return cell
            
        case .primaryContent(let post):
            let cell = tableView.dequeueReusableCell(withIdentifier: InstagramFeedPostTableViewCell.identifier, for: indexPath) as! InstagramFeedPostTableViewCell
            cell.configure(with: post)
            return cell
            
        case .comments(let comments):
            let cell = tableView.dequeueReusableCell(withIdentifier: InstagramFeedGeneralTableViewCell.identifier, for: indexPath) as! InstagramFeedGeneralTableViewCell
            cell.configure(with: comments)
            cell.delegate = self
            return cell
            
        case .captions(provider: let post):
            let cell = tableView.dequeueReusableCell(withIdentifier: InstagramFeedCaptionTableViewCell.identifier, for: indexPath) as! InstagramFeedCaptionTableViewCell
            cell.configure(with: post)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK: - Height For Row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = renderModels[indexPath.section]
        
        switch model.renderType {
        case .actions(_): return 50
            
        case .header(_): return 50
            
        case .primaryContent(_): return tableView.width //post should be a square
            
        case .comments(_): return 50
            
        case .captions(_): return 70
        }
    }
}

extension PostViewController: InstagramFeedGeneralTableViewCellDelegate, InstagramFeedActionsTableViewCellDelegate {
    //Comment Like Button
    func didTapCommentLikeButton() {
        //animate heart icon
    }
    
    func didTapShowMoreCommentsButton() {
        //Go to Comments VC
    }
    
    //Action Buttons
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

//MARK: Header Delegate Methods
extension PostViewController: InstagramFeedHeaderTableViewCellDelegate {
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
