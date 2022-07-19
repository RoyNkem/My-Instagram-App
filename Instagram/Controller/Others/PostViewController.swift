//
//  PostViewController.swift
//  Instagram
//
//  Created by Roy Aiyetin on 01/07/2022.
//

import UIKit

class PostViewController: UIViewController {
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
    
    // model for our post sample
    /// States of a rendered cell
    enum PostRenderType {
        case header(provider: User)
        case primaryContent(provider: UserPost) // post
        case actions(provider: String) // like, share, comment
        case comments(comments: [PostComment])
    }
    
    struct PostRenderViewModel {
        let renderType: PostRenderType
    }
    private var model: UserPost?
    
    private let tableView: UITableView = {
       
        let tableView = UITableView()
        tableView.register(InstagramFeedTableViewCell.self, forCellReuseIdentifier: InstagramFeedTableViewCell.identifier)
        tableView.register(InstagramFeedHeaderTableViewCell.self, forCellReuseIdentifier: InstagramFeedHeaderTableViewCell.identifier)
        tableView.register(InstagramFeedActionsTableViewCell.self, forCellReuseIdentifier: InstagramFeedActionsTableViewCell.identifier)
        tableView.register(InstagramFeedPostGeneralTableViewCell.self, forCellReuseIdentifier: InstagramFeedPostGeneralTableViewCell.identifier)
        return tableView
    }()
    
    init(model: UserPost?) { // initialize the PostViewController with a userpost model
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//MARK: - VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()

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
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
