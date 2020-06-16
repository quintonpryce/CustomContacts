//
//  CNContactManager.swift
//  CustomContacts
//
//  Created by Quinton Pryce on 2020-02-11.
//  Copyright © 2020 TN. All rights reserved.
//

import Contacts
import Foundation

class ContactManager: ContactManaging {
    // MARK: - Properties

    var contact: Contact

    private var mutableContact: CNMutableContact
    private let store = CNContactStore()

    private let isNewContact: Bool

    // MARK: - Initializers

    required init(cnContact: CNContact? = nil) {
        self.isNewContact = cnContact == nil
        self.mutableContact = CNContact.mutable(copyOf: cnContact)
        self.contact = Contact(cnContact: cnContact)
    }

    // MARK: - Methods

    /// Updates and saves the `CNMutableContact` with the values from the user facing `Contact` struct.
    func save() {
        mutableContact.update(with: contact)

        let saveRequest = CNSaveRequest()

        isNewContact ? saveRequest.add(mutableContact, toContainerWithIdentifier: nil) :
            saveRequest.update(mutableContact)

        try? store.execute(saveRequest)
    }

    /// Deletes the contact if the contact was existing.
    func delete() {
        guard !isNewContact else { return }

        let saveRequest = CNSaveRequest()
        saveRequest.delete(mutableContact)
        try? store.execute(saveRequest)
    }
}

// MARK: - `CNContact` Mutability Initializer

private extension CNContact {
    static func mutable(copyOf contact: CNContact?) -> CNMutableContact {
        (contact?.mutableCopy() as? CNMutableContact) ?? CNMutableContact()
    }
}

// MARK: - `Contact` Initializer with `CNContact`

private extension Contact {
    convenience init(cnContact: CNContact?) {
        self.init()

        guard let cnContact = cnContact else { return }

        firstName = cnContact.givenName
        lastName = cnContact.familyName
        emails = []
        numbers = []

        cnContact.emailAddresses.forEach { emailAddress in
            let label = CNLabeledValue<NSString>.localizedString(forLabel: emailAddress.label ?? "")
            let email = Contact.LabeledValue(label: label, value: emailAddress.value as String)
            emails.append(email)
        }

        cnContact.phoneNumbers.forEach { phoneNumber in
            let label = CNLabeledValue<CNPhoneNumber>.localizedString(forLabel: phoneNumber.label ?? "")
            let number = Contact.LabeledValue(label: label, value: phoneNumber.value.stringValue)
            numbers.append(number)
        }
    }
}

// MARK: - `CNMutableContact` Update with `Contact`

private extension CNMutableContact {
    func update(with contact: Contact) {
        givenName = contact.firstName
        familyName = contact.lastName
        emailAddresses = []
        phoneNumbers = []

        contact.emails.forEach { email in
            emailAddresses.append(CNLabeledValue<NSString>(label: email.label, value: email.value as NSString))
        }

        contact.numbers.forEach { number in
            let cnPhoneNumber = CNPhoneNumber(stringValue: number.value)
            phoneNumbers.append(CNLabeledValue(label: number.label, value: cnPhoneNumber))
        }
    }
}
