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
    init(cnContact: CNContact?) {
        guard let cnContact = cnContact else { return }

        firstName = cnContact.givenName
        lastName = cnContact.familyName
        emails = []
        numbers = []

        cnContact.emailAddresses.forEach { email in
            emails.append(email.value as String)
        }

        cnContact.phoneNumbers.forEach { number in
            let label = CNLabeledValue<CNPhoneNumber>.localizedString(forLabel: number.label ?? "")
            let phoneNumber = Contact.PhoneNumber(label: label, number: number.value.stringValue)
            numbers.append(phoneNumber)
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
            emailAddresses.append(CNLabeledValue(label: "email", value: email as NSString))
        }

        contact.numbers.forEach { number in
            let cnPhoneNumber = CNPhoneNumber(stringValue: number.number)
            phoneNumbers.append(CNLabeledValue(label: number.label, value: cnPhoneNumber))
        }
    }
}
