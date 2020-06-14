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

struct Contact {
    struct PhoneNumber {
        var label: String = ""
        var number: String = ""
    }

    var firstName: String = ""
    var lastName: String = ""
    var numbers: [PhoneNumber] = []
    var emails: [String] = []
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
