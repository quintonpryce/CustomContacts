//
//  Mocks.swift
//  CustomContacts
//
//  Created by Quinton Pryce on 2020-02-11.
//  Copyright © 2020 TN. All rights reserved.
//

import Foundation
import Contacts

class MockContactManager: ContactManaging {
    required init(cnContact: CNContact) {

    }

    var contact: Contact = Contact(firstName: "Mock", lastName: "", numbers: [Contact.PhoneNumber(label: "", number: "")], email: nil)


    func save() {

    }

    func delete() {

    }
}
