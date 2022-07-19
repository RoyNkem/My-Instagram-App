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
    case comments(comments: [PostComment]) //comments
}
/// Model of  rendered post
struct PostRenderViewModel {
    let renderType: PostRenderType
}

class PostViewController: UIViewController {
    
    private var model: UserPost?
    
    private var renderModels = [PostRenderViewModel]() //each model/section has one property: renderType
    
    //MARK: - Defining TableView cells
    private let tableView: UITableView = {
        
        let tableView = UITableView()
        tableView.register(InstagramFeedPostTableViewCell.self, forCellReuseIdentifier: InstagramFeedPostTableViewCell.identifier)
        tableView.register(InstagramFeedHeaderTableViewCell.self, forCellReuseIdentifier: InstagramFeedHeaderTableViewCell.identifier)
        tableView.register(InstagramFeedActionsTableViewCell.self, forCellReuseIdentifier: InstagramFeedActionsTableViewCell.identifier)
        tableView.register(InstagramFeedGeneralTableViewCell.self, forCellReuseIdentifier: InstagramFeedGeneralTableViewCell.identifier)
        return tableView
    }()
    
    init(model: UserPost?) { // initialize the PostViewController with a userpost model
        self.model = model
        super.init(nibName: nil, bundle: nil)
        configureModels()
    }
    
    //MARK: - Model Configure data
    private func configureModels() {
        guard let userPostModel = self.model else { return }
        
        //Header
        renderModels.append(PostRenderViewModel(renderType: .header(provider: userPostModel.owner)))
        
        //Post
        renderModels.append(PostRenderViewModel(renderType: .primaryContent(provider: userPostModel)))
        
        //Action
        renderModels.append(PostRenderViewModel(renderType: .actions(provider: "")))
        
        //4 Comments
        var comments = [PostComment]()
        for i in 0..<4 {
            comments.append(PostComment(identifier: "123_\(i)", username: "adam_link", text: "Great Post", createdDate: Date(), likes: []
                                       )
            )
        }
        renderModels.append(PostRenderViewModel(renderType: .comments(comments: comments)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureModels()
        
        view.addSubviews(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
}

//MARK: - EXTENSIONS

extension PostViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        print("\(renderModels.count)")
        return renderModels.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch renderModels[section].renderType {
        case .actions(_): return 1
        case .comments(let comments): return comments.count > 4 ? 4 : comments.count
        case .header(_): return 1
        case .primaryContent(_): return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = renderModels[indexPath.section]
        
        switch model.renderType {
        case .actions(let actions):
            let cell = tableView.dequeueReusableCell(withIdentifier: InstagramFeedActionsTableViewCell.identifier, for: indexPath) as! InstagramFeedActionsTableViewCell
            return cell
            
        case .header(let user):
            let cell = tableView.dequeueReusableCell(withIdentifier: InstagramFeedHeaderTableViewCell.identifier, for: indexPath) as! InstagramFeedHeaderTableViewCell
            return cell
            
        case .primaryContent(let post):
            let cell = tableView.dequeueReusableCell(withIdentifier: InstagramFeedPostTableViewCell.identifier, for: indexPath) as! InstagramFeedPostTableViewCell
            return cell
            
        case .comments(let comments):
            let cell = tableView.dequeueReusableCell(withIdentifier: InstagramFeedGeneralTableViewCell.identifier, for: indexPath) as! InstagramFeedGeneralTableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = renderModels[indexPath.section]
        
        switch model.renderType {
        case .actions(_): return 60
            
        case .header(_): return 70
            
        case .primaryContent(_): return tableView.width //post should be a square
            
        case .comments(_): return 50
        }
    }
}
