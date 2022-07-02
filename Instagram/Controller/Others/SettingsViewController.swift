//
//  SettingsViewController.swift
//  Instagram
//
//  Created by Roy Aiyetin on 01/07/2022.
//

import UIKit

struct SettingsCellModel {
    var title: String
    var handler: (() -> Void) //closure that takes no argument and returns void
}

/// ViewController to show user settings
final class SettingsViewController: UIViewController {
    
    //MARK: - DECLARE Tableview Elements views for Login screen
    
    private let tableView: UITableView = {
        
        var tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var data = [[SettingsCellModel]]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureModels()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubviews(tableView)
        
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
    //congigure cell in each section
    private func configureModels() {
        let section = [
            SettingsCellModel(title: "Log out") { [weak self] in
                self?.didTapLogout()
            }
        ]
        data.append(section)
    }
    
    private func didTapLogout() {
        
        // show action sheet when logout button tapped
        let logoutSheet = UIAlertController(title: "Log out", message: "Are you sure you want to logout", preferredStyle: .actionSheet)
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let actionLogout = UIAlertAction(title: "Logout", style: .destructive) { action in
            AuthManager.shared.logout { success in
                DispatchQueue.main.async {
                    if success {
                        //present loginvc
                        let loginVC = LoginViewController()
                        self.present(loginVC, animated: true) {
                            //returns screen to home after login again
                        }
                    }
                    else {
                        // error occurred logging out
                        fatalError("Could not logout user")
                    }
                }
            }
        }
        
        logoutSheet.addAction(actionCancel)
        logoutSheet.addAction(actionLogout)
        
        // Ipad crash fix
        logoutSheet.popoverPresentationController?.sourceView = tableView
        logoutSheet.popoverPresentationController?.sourceRect = tableView.bounds
        
        present(logoutSheet, animated: true)
    }
}
//MARK: - TABLEVIEW DELEGATE AND DATASOURCE

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    //datasource methods
    func numberOfSections(in tableView: UITableView) -> Int {
//        print("section: \(data.count)")
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print("logout row: \(data[section].count)")
        return data[section].count
    }
    
    //delegate methods
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //handle cell selection
        tableView.deselectRow(at: indexPath, animated: true)
        let logoutModel = data[indexPath.section][indexPath.row]
        logoutModel.handler() // call/invoke logout handler during configuration i.e didTapLogout()
    }
}
