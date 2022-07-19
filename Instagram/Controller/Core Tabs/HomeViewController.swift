//
//  HomeViewController.swift
//  Instagram
//
//  Created by Roy Aiyetin on 01/07/2022.
//

import UIKit
import FirebaseAuth

struct HomeFeedRenderViewModel {
    let header: PostRenderViewModel
    let post: PostRenderViewModel
    let action: PostRenderViewModel
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
        return tableView
    }()
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        handleNotAuthenticated()
    }
    
    func handleNotAuthenticated() {
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: InstagramFeedPostTableViewCell.identifier, for: indexPath) as! InstagramFeedPostTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
