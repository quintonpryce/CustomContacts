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
}

struct ContactViewData {
    let data: [[ContactSectionData]]
    let sectionHeaders: [String]

    init(contact: Contact) {
        let nameSection = [
            ContactSectionData(title: "First name", detail: contact.firstName),
            ContactSectionData(title: "Last name", detail: contact.lastName)
        ]

        let phoneNumbersSection = contact.numbers.map { phoneNumber -> ContactSectionData in
            ContactSectionData(title: phoneNumber.label, detail: phoneNumber.number)
        }

        let emailsSection = contact.emails.map { email -> ContactSectionData in
            ContactSectionData(title: "", detail: email)
        }

        data = [
            nameSection,
            phoneNumbersSection,
            emailsSection
        ]

        sectionHeaders = [
            "Name",
            "Phone numbers",
            "Emails"
        ]
    }
}
