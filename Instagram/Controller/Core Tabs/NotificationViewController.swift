//
//  NotificationViewController.swift
//  Instagram
//
//  Created by Roy Aiyetin on 01/07/2022.
//

import UIKit

enum UserNotificationType {
    case like(post: UserPost)
    case follow(state: FollowState)
}

struct UserNotification {
    let type: UserNotificationType //type of notification received
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
        
        view.addSubviews(tableView, spinner)
        
        view.backgroundColor = .systemBackground
        
        fetchNotifications()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.backgroundColor = UIColor.clear
    }
    
    //MARK: - Fetch Notifications
    public func fetchNotifications() {
        
        for x in 0...100 {
            let user = User(username: "Joe_king", bio: "Music Artist",
                            name: (first: "Steve", last: "Joe"), birthday: Date(), profilePhoto: URL(string: "Roy3")!, gender: .male,
                            counts: UserCount(following: 1, followers: 1, posts: 3), joinDate: Date())
            
            let post = UserPost(identifier: "", postType: .photo,
                                thumbnailImage: URL(string: "Roy3")!,
                                postURL: URL(string: "https://www.google.com")!,
                                caption: "", likeCount: [],
                                comments: [], createdDate: Date(), taggedUser: [], owner: user)
            
            let model = UserNotification(type: x % 2 == 0 ? .like(post: post) : .follow(state: .not_following),
                                         user: user, text: x % 2 == 0 ? "alex_riley liked your post" : "Joe_king started following you")
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
    
    //data source methods
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
            cell.delegate = self
            return cell
            
        case .follow :
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationFollowEventTableViewCell.identifier, for: indexPath) as! NotificationFollowEventTableViewCell
            cell.configure(with: model) // public func defined in cells
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

//MARK: - Notification delegate method
extension NotificationViewController: NotificationLikeEventTableViewCellDelegate, NotificationFollowEventTableViewCellDelegate {
    
    func didTapFollowUnfollowButton(model: UserNotification) {
        print("Tapped button")
        //perform database update
    }
    
    //Notification like custom delegate method
    func didTapRelatedPostButton(model: UserNotification) {
        switch model.type {
        case .like(let post):
            //open post. Get into delegation
            let vc = PostViewController(model: post)
            vc.navigationItem.title = post.postType.rawValue
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)
            
        case .follow(_):
            fatalError("Dev issue: should never get called")
        }
    }
}
