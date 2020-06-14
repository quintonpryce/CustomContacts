//
//  Mocks.swift
//  CustomContacts
//
//  Created by Quinton Pryce on 2020-02-11.
//  Copyright © 2020 TN. All rights reserved.
//

import Contacts
import Foundation

class MockContactManager: ContactManaging {
    required init(cnContact: CNContact?) {}

    var contact: Contact = Contact(firstName: "Mock", lastName: "", numbers: [Contact.PhoneNumber(label: "", number: "")], emails: [])

    func save() {}

    func delete() {}
}
