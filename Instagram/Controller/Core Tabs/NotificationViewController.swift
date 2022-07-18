//
//  NotificationViewController.swift
//  Instagram
//
//  Created by Roy Aiyetin on 01/07/2022.
//

import UIKit

enum UserNotificationType {
    case like(post: UserPost)
    case follow
}
struct UserNotification {
    let type: UserNotificationType
    let user: User
    let text: String
}

final class NotificationViewController: UIViewController {
    
    private let tableView: UITableView = {
        
        let tableView = UITableView()
        tableView.isHidden = false
        tableView.register(NotificationLikeEventTableViewCell.self, forCellReuseIdentifier: NotificationLikeEventTableViewCell.identifier)
        tableView.register(NotificationFollowEventTableViewCell.self, forCellReuseIdentifier: NotificationFollowEventTableViewCell.identifier)
        return tableView
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    private lazy var noNotificationsView = NoNotificationsView() //Custom view. no need to define here.
    
    private var models = [UserNotification]()
    
    //MARK: - VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Notifications"
        
        tableView.delegate = self
        tableView.dataSource = self
                
        view.addSubviews(tableView, spinner, noNotificationsView)
        
        view.backgroundColor = .systemBackground
        
        addNoNotificationsView()
    }
    
    public func fetchNotifications() {
        let post = UserPost(identifier: "", postType: .photo,
                            thumbnailImage: URL(string: "https://www.google.com")!,
                            postURL: URL(string: "https://www.google.com")!,
                            caption: "", likeCount: [],
                            comments: [], createdDate: Date(), taggedUser: [])
        
        for user in 0...100 {
            let model = UserNotification(type: user % 2 == 0 ? .like(post: post) : .follow,
                                         user: User(username: "Joe_king", bio: "Music Artist",
                                                    name: (first: "Steve", last: "Joe"), birthday: Date(), profilePhoto: URL(string: "https://www.google.com")!, gender: .male,
                                                    counts: UserCount(following: 1, followers: 1, posts: 3), joinDate: Date()), text: "Hello World")
            models.append(model)
            
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
        spinner.center = view.center
        
        //        addNoNotificationsView()
    }
    
    private func addNoNotificationsView() {
        view.addSubviews(noNotificationsView)
        tableView.isHidden = true
        noNotificationsView.frame = CGRect(x: 0, y: 0, width: view.width/2, height: view.width/4)
        noNotificationsView.center = view.center
    }
    
}

//MARK: - EXTENSION

extension NotificationViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row] //declared model above
        
        switch model.type {
        case .like(post: ) :
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationLikeEventTableViewCell.identifier, for: indexPath) as! NotificationLikeEventTableViewCell
            
            cell.configure(with: model)
            
            return cell
            
        case .follow :
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationFollowEventTableViewCell.identifier, for: indexPath) as! NotificationFollowEventTableViewCell
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
