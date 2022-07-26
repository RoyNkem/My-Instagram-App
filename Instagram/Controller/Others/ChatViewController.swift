//
//  ChatViewController.swift
//  Instagram
//
//  Created by Roy Aiyetin on 24/07/2022.
//

import UIKit

class ChatViewController: UIViewController {
    
    //MARK: - Define UI Elements
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UsersChatTableViewCell.self, forCellReuseIdentifier: UsersChatTableViewCell.identifier)
        return tableView
    }()
    
    private let segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["All", "0 requested"])
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
//MARK: - VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureSegmentedControl()
        configureNavigationButtons()
        view.addSubviews(tableView, segmentedControl)
    }

    //MARK: - Helper Functions
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
    }
    
    private func configureSegmentedControl() {
//        update contents of segmented control
        segmentedControl.removeBorder()
        segmentedControl.addUnderlineForSelectedSegment()
    }
    
    private func configureNavigationButtons() {
        //add 2 navigation bar buttons 
        let videoButton = UIBarButtonItem(image: UIImage(named: "video"), style: .plain, target: self, action: #selector(didTapVideoButton))
        videoButton.tintColor = .label
        
        let newChatButton = UIBarButtonItem(image: UIImage(named: "video"), style: .plain, target: self, action: #selector(didTapNewChatButton))
        newChatButton.tintColor = .label
        
        navigationItem.rightBarButtonItems = [videoButton, newChatButton]
        
        navigationItem.title = "Messages"
    }
    
    @objc private func didTapVideoButton() {
        // Open new controller for video call function
    }
    @objc private func didTapNewChatButton() {
        // Open new controller for video call function
    }
    
//MARK: - VIEW LAYOUT
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
        segmentedControl.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.width, height: 40)
    }
}
//MARK: - EXTENSION
extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UsersChatTableViewCell.identifier, for: indexPath) as! UsersChatTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
