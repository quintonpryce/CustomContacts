//
//  ContactValueTableViewCell.swift
//  CustomContacts
//
//  Created by Quinton Pryce on 2020-06-14.
//  Copyright © 2020 TN. All rights reserved.
//

import UIKit

protocol ContactValueTableViewCellDelegate: AnyObject {
    func didUpdate(_ value: String)
}

class ContactValueTableViewCell: UITableViewCell, UITextFieldDelegate {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var textField: UITextField!

    var didUpdate: ((String) -> Void)?

    var keyboardType: UIKeyboardType {
        get { textField.keyboardType }
        set { textField.keyboardType = newValue }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        textField.isUserInteractionEnabled = selected
        if selected {
            textField.becomeFirstResponder()
        }
    }

    @IBAction func didEndEditingTextField() {
        didUpdate?(textField.text ?? "")
    }
}
