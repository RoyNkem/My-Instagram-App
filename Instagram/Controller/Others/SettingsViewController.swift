//
//  SettingsViewController.swift
//  Instagram
//
//  Created by Roy Aiyetin on 01/07/2022.
//

import UIKit
import SafariServices

struct SettingsCellModel {
    var title: String
    //    var image: String
    var handler: (() -> Void) //closure that takes no argument and returns void
}
/// ViewController to show user settings
final class SettingsViewController: UIViewController {
    
    //MARK: - DECLARE Tableview Elements views for Login screen
    private let tableView: UITableView = {
        
        var tableView = UITableView(frame: .zero, style: .grouped) // grouped sections
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private let searchBar = UISearchBar()
    
    private var data = [[SettingsCellModel]]() // multidimensional array because we have several sections (with several rows)
    
//MARK: - VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        configureModels()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = searchBarView()
        view.addSubviews(tableView)
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none // remove lines from row cells
        
        view.backgroundColor = .systemBackground
    }
    
    private func searchBarView() -> UIView {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: 50).integral)
        
        searchBar.placeholder = "Search..."
        searchBar.frame = CGRect(x: 0, y: 0, width: view.width, height: 50)
        header.addSubviews(searchBar)
        
        return header
    }
    
//MARK: - VIEW DID LAYOUT SUBVIEW
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
    //congigure cells in each sections
    private func configureModels() {
        
        // setup tableview grouped sections
        let sectionOne = [// individual rows
            SettingsCellModel(title: "Edit Profile") { [weak self] in
                self?.didTapEditProfile()},
            SettingsCellModel(title: "Follow and invite friends") { [weak self] in
                self?.didTapInviteFriends()},
            SettingsCellModel(title: "Save original posts") { [weak self] in
                self?.didTapSaveOriginalPhotos()}
        ]
        data.append(sectionOne)
        
        let sectionTwo = [
            SettingsCellModel(title: "Terms of services") { [weak self] in
                self?.openURL(type: .terms)},
            SettingsCellModel(title: "Privacy policy") { [weak self] in
                self?.openURL(type: .privacy)},
            SettingsCellModel(title: "Help") { [weak self] in
                self?.openURL(type: .help)},
            SettingsCellModel(title: "About") { [weak self] in
                self?.openURL(type: .about)}
        ]
        data.append(sectionTwo)
        
        let logoutSection = [
            SettingsCellModel(title: "Add account") { [weak self] in
                self?.didTapAddAccount()},
            SettingsCellModel(title: "Log out") { [weak self] in
                self?.didTapLogout()}
        ]
        data.append(logoutSection)
    }
    
    //MARK: - CELL TAP FUNCTIONS
    private func didTapEditProfile() {
        let vc = EditProfileViewController()
        vc.title = "Edit Profile"
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
    
    private func didTapInviteFriends() {
        // show share sheet to invite friends
    }
    
    private func didTapSaveOriginalPhotos() {
        
    }
    
    enum SettingsURLType {
        case terms, privacy, help, about
    }
    
    //MARK: - Open Url Webpages
    private func openURL(type: SettingsURLType) {
        let urlString: String
        
        switch type {
        case .terms: urlString =
            "https://help.instagram.com/581066165581870"
        case .privacy: urlString =
            "https://help.instagram.com/519522125107875/?helpref=hc_fnav"
        case .help: urlString =
            "https://help.instagram.com"
        case .about: urlString =
            "https://github.com/RoyNkem"
        }
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true) // move to new safari webview depending on url passed
    }
    
    //MARK: - Tap Add Account
    private func didTapAddAccount() {
        
        //Add account by login or signup alert sheet
        let alert = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        
        //change font of title and message.
        let titleFont = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .bold)]
        let titleAttrString = NSMutableAttributedString(string: "Add account", attributes: titleFont)
        alert.setValue(titleAttrString, forKey: "attributedTitle")
        
        //add action buttons
        let actionLogin = UIAlertAction(title: "Log In to Existing Account", style: .default) { [weak self] _ in
            //login
            let vc = LoginViewController()
            self?.present(UINavigationController(rootViewController: vc), animated: true)
        }
        let actionCreateAccount = UIAlertAction(title: "Create New Account", style: .default) { [weak self] _ in
            //create Account
            let vc = RegistrationViewController()
            vc.title = "Create New Account"
            self?.present(UINavigationController(rootViewController: vc), animated: true)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .destructive)
        
        alert.addActions(actionLogin, actionCreateAccount, cancel)

        present(alert, animated: true) {
            alert.view.superview?.isUserInteractionEnabled = true // allow touch event outside alertVC to dismiss alert
            alert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertControllerBackgroundTapped)))
        }
    }
    
    //MARK: - Tap Logout
    private func didTapLogout() {
        
        // show action sheet when logout button tapped
        let logoutSheet = UIAlertController(title: "Log out", message: "Are you sure you want to logout?", preferredStyle: .alert)
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let actionLogout = UIAlertAction(title: "Logout", style: .destructive) { logout in
            AuthManager.shared.logout { success in
                DispatchQueue.main.async {
                    if success {
                        //present loginvc
                        let loginVC = LoginViewController()
                        loginVC.modalPresentationStyle = .fullScreen
                        loginVC.navigationItem.setHidesBackButton(true, animated: false)
                        self.present(loginVC, animated: true, completion: nil)
                        
                    }
                    else {
                        // error occurred logging out
                        fatalError("Could not logout user")
                    }
                }
            }
        }
        
        logoutSheet.addActions(actionCancel, actionLogout)
        
        // Ipad crash fix
        logoutSheet.popoverPresentationController?.sourceView = tableView
        logoutSheet.popoverPresentationController?.sourceRect = tableView.bounds
        
        present(logoutSheet, animated: true) {
            logoutSheet.view.superview?.isUserInteractionEnabled = true // allow touch event outside alertVC to dismiss alert
            logoutSheet.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertControllerBackgroundTapped)))
        }
    }
}

//:MARK: - EXTENSION

extension SettingsViewController: UISearchBarDelegate {
    
}

//MARK: - TABLEVIEW DELEGATE AND DATASOURCE

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    //datasource methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    //delegate methods
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        cell.accessoryType = .disclosureIndicator // right chevron icon used to show that tapping the button presents a view
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //handle cell selection
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedCellForRow = data[indexPath.section][indexPath.row]
        selectedCellForRow.handler() // call/invoke cell handler during configuration i.e didTapLogout()
    }
}
