//
//  AccessContactsViewController.swift
//  CustomContacts
//
//  Created by Quinton Pryce on 2020-06-14.
//  Copyright © 2020 TN. All rights reserved.
//

import UIKit

class AccessContactsViewController: UIViewController {
    private let accessor = ContactsAccessor()

    @IBOutlet private var containerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        if accessor.hasAccessToContacts {
            showContacts()
        } else if accessor.canAskForAccessToContacts {
            accessor.requestAccess { granted in
                if granted {
                    self.showContacts()
                } else {
                    self.showView()
                }
            }
        } else {
            showView()
        }
    }

    private func showView() {
        containerView.isHidden = false
    }

    private func showContacts() {
        let contactsTableViewController = storyboard!.instantiateViewController(identifier: "Contacts")
        navigationController?.setViewControllers([contactsTableViewController], animated: false)
    }

    @IBAction func openSettings() {
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else {
            assertionFailure("App settings URL is not valid.")
            return
        }

        UIApplication.shared.open(settingsURL)
    }
}
