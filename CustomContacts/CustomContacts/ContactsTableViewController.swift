//
//  ContactsTableViewController.swift
//  CustomContacts
//
//  Created by Quinton Pryce on 2020-06-14.
//  Copyright © 2020 TN. All rights reserved.
//

import Contacts
import UIKit

class ContactsTableViewController: UITableViewController {
    let accessor = ContactsAccessor()

    lazy var contacts: [CNContact] = {
        accessor.contacts
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contacts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath)
        let contact = contacts[indexPath.row]

        cell.textLabel?.text = "\(contact.givenName) \(contact.familyName)"

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = contacts[indexPath.row]
        presentContactViewController(for: contact)
    }

    private func presentContactViewController(for contact: CNContact) {
        guard let vc = storyboard?.instantiateViewController(identifier: "Contact", creator: { coder in
            return ContactTableViewController(coder: coder, contactManager: ContactManager(cnContact: contact))
        }) else {
            fatalError("Failed to load EditUserViewController from storyboard.")
        }

        navigationController?.pushViewController(vc, animated: true)
    }
}
