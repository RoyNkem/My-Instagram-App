//
//  FormTableViewCell.swift
//  Instagram
//
//  Created by Roy Aiyetin on 03/07/2022.
//

import UIKit

protocol FormTableViewCellDelegate: AnyObject {
    // function to extract value when user hits return key
    func formTableViewCell(_ cell: FormTableViewCell, didUpdateField updatedModel: EditProfileFormModel)
}

class FormTableViewCell: UITableViewCell {
    
    static let identifier = "FormTableViewCell"
    
    private var model: EditProfileFormModel? // optional when starting, there will be no model created
    
    public weak var delegate: FormTableViewCellDelegate?
    
    //MARK: - DECLARE UI Elements for Cell
    
    private let formLabel: UILabel = {
        
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    
    private let field: UITextField = {
        
        let field = UITextField()
        field.returnKeyType = .done
        return field
    }()
    
    //MARK: - INIT
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        clipsToBounds = true
        contentView.addSubview(formLabel) // add views to the content view of cell
        contentView.addSubview(field)
        field.delegate = self // pass event control to our class
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Configure cells
    public func configure( with model: EditProfileFormModel) {
        
        self.model = model // we are storing the model we get from EditVC in our cell model property
        formLabel.text = model.label
        field.placeholder = model.placeholder
        field.text = model.value
    }
    
//    Make sure prior cell values is not accidentally reused in the next one
    override func prepareForReuse() {
        super.prepareForReuse()

        formLabel.text = nil
        field.placeholder = nil
        field.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //MARK: - Assign Frames
        
        //make the label and field to be aligned horizontally in the content view of cell
        formLabel.frame = CGRect(x: 5, y: 0, width: (contentView.width)/3, height: contentView.height)
        field.frame = CGRect(x: formLabel.right + 5, y: 0, width: contentView.width - formLabel.width, height: contentView.height)
        
    }
}

//MARK: - EXTENSIONS
extension FormTableViewCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        model?.value = textField.text // pass the input to model
        guard let model = model else { // every time the user hits return func invokes
            return true
        }
        delegate?.formTableViewCell(self, didUpdateField: model) //?? Not clear
        textField.resignFirstResponder()
        return true
    }
}
