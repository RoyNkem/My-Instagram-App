//
//  HomeViewController.swift
//  Instagram
//
//  Created by Roy Aiyetin on 01/07/2022.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {
    
    private let tableView: UITableView = {
       
        let tableView = UITableView()
        tableView.register(InstagramFeedTableViewCell.self, forCellReuseIdentifier: InstagramFeedTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubviews(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: InstagramFeedTableViewCell.identifier, for: indexPath) as! InstagramFeedTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
