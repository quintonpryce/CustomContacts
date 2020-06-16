//
//  ViewController.swift
//  CustomContacts
//
//  Created by Ziad Hamdieh on 2020-02-11.
//  Copyright © 2020 TN. All rights reserved.
//

import UIKit

class ContactTableViewController: UITableViewController {
    let contactManager: ContactManaging
    let viewData: ContactViewData

    init?(coder: NSCoder, contactManager: ContactManaging) {
        self.contactManager = contactManager
        self.viewData = ContactViewData(contact: contactManager.contact)
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("You must create this view controller with a contact manager.")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    deinit {
        contactManager.save()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewData.data.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewData.data[section].count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewData.sectionHeaders[section]
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactValueCell", for: indexPath) as? ContactValueTableViewCell else {
            fatalError("Failed to dequeue ContactValueCell.")
        }

        let contact = viewData.data[indexPath.section][indexPath.row]

        cell.titleLabel.text = contact.title
        cell.textField.text = contact.detail

        cell.didUpdate = contact.didUpdate

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }

    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        contactManager.save()
    }
}
