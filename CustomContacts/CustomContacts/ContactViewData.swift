//
//  ContactViewData.swift
//  CustomContacts
//
//  Created by Quinton Pryce on 2020-06-14.
//  Copyright © 2020 TN. All rights reserved.
//

import Foundation

struct ContactSectionData {
    let title: String
    let detail: String
    let didUpdate: (String) -> Void
}

struct ContactViewData {
    let data: [[ContactSectionData]]
    let sectionHeaders: [String]

    init(contact: Contact) {
        let nameSection = [
            ContactSectionData(title: "First name", detail: contact.firstName) { contact.firstName = $0 },
            ContactSectionData(title: "Last name", detail: contact.lastName) { contact.lastName = $0 }
        ]

        let numberSection = contact.numbers.map { number -> ContactSectionData in
            ContactSectionData(title: number.label, detail: number.value) { number.value = $0 }
        }

        let emailsSection = contact.emails.map { email -> ContactSectionData in
            ContactSectionData(title: email.label, detail: email.value) { email.value = $0 }
        }

        data = [
            nameSection,
            numberSection,
            emailsSection
        ]

        sectionHeaders = [
            "Name",
            "Phone numbers",
            "Emails"
        ]
    }
}
