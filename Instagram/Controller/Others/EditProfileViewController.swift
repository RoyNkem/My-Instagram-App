//
//  EditProfileViewController.swift
//  Instagram
//
//  Created by Roy Aiyetin on 01/07/2022.
//

import UIKit

class EditProfileViewController: UIViewController {

//MARK: - VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSave))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didTapCancel))
        view.backgroundColor = .secondarySystemBackground
    }

    @objc private func didTapSave() {
        
    }
    
    //MARK: - Tap Cancel To Discard Changes
    // check if the user has made changes, then present alert sheet. Otherwise, cancel without prompt???
    
    @objc private func didTapCancel() {
        // ask user to be sure to discard changes/edits
        let cancelAlert = UIAlertController(title: "", message: "Are you sure you want to discard all changes?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let discardAction = UIAlertAction(title: "Discard Changes", style: .destructive) { discard in
            let vc = SettingsViewController()
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        cancelAlert.addAction(cancelAction)
        cancelAlert.addAction(discardAction)

        // Ipad crash fix
        cancelAlert.popoverPresentationController?.sourceView = view
        cancelAlert.popoverPresentationController?.sourceRect = view.bounds
        
        present(cancelAlert, animated: true)
        {
            cancelAlert.view.superview?.isUserInteractionEnabled = true // allows touch event outside alert controller
            cancelAlert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertControllerBackgroundTapped)))
        }
    }
    
    //MARK: - Tap Change Profile Picture
    @objc private func didTapChangeProfilePicture() {
        let actionSheet = UIAlertController(title: "Profile Picture", message: "Change Profile Picture", preferredStyle: .actionSheet)
        let takePhoto = UIAlertAction(title: "Take Photo", style: .default, handler: nil)
        let libraryPhoto = UIAlertAction(title: "Choose from library", style: .default) { select in
            print("library")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        actionSheet.addAction(takePhoto)
        actionSheet.addAction(libraryPhoto)
        actionSheet.addAction(cancelAction)
        
        actionSheet.popoverPresentationController?.sourceView = view
        actionSheet.popoverPresentationController?.sourceRect = view.bounds
        
        present(actionSheet, animated: true)
    }
}
