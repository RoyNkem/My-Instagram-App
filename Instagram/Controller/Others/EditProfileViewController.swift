//
//  EditProfileViewController.swift
//  Instagram
//
//  Created by Roy Aiyetin on 01/07/2022.
//

import UIKit

struct EditProfileFormModel {
    let label: String
    let placeholder: String
    var value: String?
}

class EditProfileViewController: UIViewController {
    
    let pickerVC = UIImagePickerController()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FormTableViewCell.self, forCellReuseIdentifier: FormTableViewCell.identifier)
        return tableView
    }()
    
    private let profilePictureLabel = UILabel()

    private let profilePhotoButton = UIButton()
    
    private var models = [[EditProfileFormModel]]() // 2 Dimensional array i.e column & rows
    
    //MARK: - VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerVC.delegate = self
        pickerVC.allowsEditing = true
       
        configureModels()
        configureTableView()
        navigationBarButtons()
        
        view.backgroundColor = .secondarySystemBackground
        
        view.addSubviews(tableView)
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = createTableHeaderView()
    }
    private func navigationBarButtons() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSave))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(didTapCancel))
    }
    
    //MARK: - TableView Header
    func createTableHeaderView() -> UIView {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.height/4).integral)
        let size = header.height/1.5

        profilePictureLabel.text = "Edit Picture"
        profilePictureLabel.textColor = .label
        profilePictureLabel.frame = CGRect(x: (view.width - size)/2 + 35, y: (header.height - size)/2 + size/2, width: size - 70, height: size/4)
        profilePictureLabel.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        profilePictureLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        profilePictureLabel.layer.masksToBounds = true
        profilePictureLabel.layer.cornerRadius = 4
        
        profilePhotoButton.frame = CGRect(x: (view.width - size)/2, y: (header.height - size)/2, width: size, height: size)
        profilePhotoButton.setBackgroundImage(UIImage(systemName: "person.circle"), for: .normal)
        profilePhotoButton.layer.masksToBounds = true
        profilePhotoButton.layer.cornerRadius = size/2
        profilePhotoButton.layer.borderWidth = 1
        profilePhotoButton.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        profilePhotoButton.addTarget(self, action: #selector(didTapProfilePhotoButton), for: .touchUpInside)
        
        header.addSubviews(profilePhotoButton, profilePictureLabel)
        return header
    }
    
    //MARK: - Set up Table Sections data
    private func configureModels() {
        //      name, username, website, bio
        var sectionOne = [EditProfileFormModel]()
        
        let sectionOneLabels = ["Name", "Username", "Bio"] //label is just one of 3 properties for the model
        
        for label in sectionOneLabels {
            let model = EditProfileFormModel(label: label, placeholder: "Enter \(label)...", value: nil)
            sectionOne.append(model)
        }
        models.append(sectionOne)
        
        //email, phone, gender
        let sectionTwoLabels = ["Email", "Phone", "Gender"]
        var sectionTwo = [EditProfileFormModel]()
        for label in sectionTwoLabels {
            let model = EditProfileFormModel(label: label, placeholder: "Enter \(label)...", value: nil)
            sectionTwo.append(model)
        }
        models.append(sectionTwo)
    }
    
    //MARK: - VIEW ADD LAYOUT
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
    //MARK: - Tap Change Profile Picture
    @objc private func didTapProfilePhotoButton() {
        let actionSheet = UIAlertController(title: "Profile Picture", message: "Change Profile Picture", preferredStyle: .actionSheet)
        //Change profile picture from camera
        let takePhoto = UIAlertAction(title: "Take Photo", style: .default) { [weak self] select in
            guard let strongSelf = self else { return }
            strongSelf.pickerVC.sourceType = .camera
            
            self?.present(strongSelf.pickerVC, animated: true)
        }
        //Change profile picture from photos in library
        let libraryPhoto = UIAlertAction(title: "Choose from library", style: .default) { [weak self] select in
            guard let strongSelf = self else { return }
            strongSelf.pickerVC.sourceType = .photoLibrary
            
            
            self?.present(strongSelf.pickerVC, animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        actionSheet.addAction(takePhoto)
        actionSheet.addAction(libraryPhoto)
        actionSheet.addAction(cancelAction)
        
        actionSheet.popoverPresentationController?.sourceView = view
        actionSheet.popoverPresentationController?.sourceRect = view.bounds
        
        present(actionSheet, animated: true)
    }
    
    //MARK: - Tap Save To Save Changes
    @objc private func didTapSave() {
        // save changes to database
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Tap Cancel To Discard Changes
    // check if the user has made changes, then present alert sheet. Otherwise, cancel without prompt???
    
    @objc private func didTapCancel() {
        // ask user to be sure to discard changes/edits
        let cancelAlert = UIAlertController(title: "", message: "Are you sure you want to discard all changes?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let discardAction = UIAlertAction(title: "Discard Changes", style: .destructive) { [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        }
        
        cancelAlert.addAction(cancelAction)
        cancelAlert.addAction(discardAction)
        
        // Ipad crash fix
        cancelAlert.popoverPresentationController?.sourceView = view
        cancelAlert.popoverPresentationController?.sourceRect = view.bounds
        
        present(cancelAlert, animated: true) {
            cancelAlert.view.superview?.isUserInteractionEnabled = true // allows touch event outside alert controller
            cancelAlert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertControllerBackgroundTapped)))
        }
    }
    
}

//MARK: - EXTENSIONS
extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // info is a dictionary. Get image out of the dictionary
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            profilePhotoButton.setImage(image, for: .normal)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension EditProfileViewController: UITableViewDelegate, UITableViewDataSource {
    //tableView Datasource
    func numberOfSections(in: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = models[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: FormTableViewCell.identifier, for: indexPath) as! FormTableViewCell
        cell.configure(with: model)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "Private Info"
        }
        return nil
    }
}

//MARK: - Form Cell Delegate
extension EditProfileViewController: FormTableViewCellDelegate {
    // formtableview cell delegate
    func formTableViewCell(_ cell: FormTableViewCell, didUpdateField updatedModel: EditProfileFormModel) {
        print("Field value: \(updatedModel.value ?? "nil"), \(updatedModel.label)") // this is where we get the textfield info
    }
}
