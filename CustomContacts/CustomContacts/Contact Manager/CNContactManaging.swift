//
import Contacts
import Foundation
//  CNContactManaging.swift
//  CustomContacts
//
//  Created by Quinton Pryce on 2020-02-11.
//  Copyright © 2020 TN. All rights reserved.
//
import UIKit

class Contact {
    class LabeledValue {
        var label: String
        var value: String

        init(label: String = "", value: String) {
            self.label = label
            self.value = value
        }
    }

    var firstName: String 
    var lastName: String 
    var numbers: [LabeledValue]
    var emails: [LabeledValue]

    init(firstName: String = "", lastName: String = "", numbers: [LabeledValue] = [], emails: [LabeledValue] = []) {
        self.firstName = firstName
        self.lastName = lastName
        self.numbers = numbers
        self.emails = emails
    }
}

protocol ContactManaging {
    var contact: Contact { get }
    func save()
    func delete()

    init(cnContact: CNContact?)
}

protocol ContactViewController {
    init(contactManager: ContactManaging)
}
