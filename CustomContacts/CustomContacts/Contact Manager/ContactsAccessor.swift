//
//  ContactsAccessor.swift
//  CustomContacts
//
//  Created by Quinton Pryce on 2020-06-14.
//  Copyright © 2020 TN. All rights reserved.
//

import Contacts
import Foundation

// TODO: Needs to be re-hashed. This is only a means to an end There is some duplication from multiple contact containers that needs to be handled. You should be able to see both contacts.
struct ContactsAccessor {
    private let store: CNContactStore

    init(store: CNContactStore = CNContactStore()) {
        self.store = store
    }

    var contacts: [CNContact] {
        let contactStore = CNContactStore()

        let keysToFetch: [CNKeyDescriptor] = [
            CNContactGivenNameKey as CNKeyDescriptor,
            CNContactFamilyNameKey as CNKeyDescriptor,
            CNContactEmailAddressesKey as CNKeyDescriptor,
            CNContactPhoneNumbersKey as CNKeyDescriptor
        ]

        // Get all the containers
        var allContainers: [CNContainer] = []
        do {
            allContainers = try contactStore.containers(matching: nil)
        } catch {
            print("Error fetching containers")
        }

        var results: [CNContact] = []

        // Iterate all containers and append their contacts to our results array
        for container in allContainers {
            let fetchPredicate = CNContact.predicateForContactsInContainer(withIdentifier: container.identifier)

            do {
                let containerResults = try contactStore.unifiedContacts(matching: fetchPredicate, keysToFetch: keysToFetch)
                results.append(contentsOf: containerResults)
            } catch {
                print("Error fetching results for container")
            }
        }

        return sortContacts(results)
    }

    var hasAccessToContacts: Bool {
        CNContactStore.authorizationStatus(for: .contacts) == .authorized
    }

    var canAskForAccessToContacts: Bool {
        CNContactStore.authorizationStatus(for: .contacts) == .notDetermined
    }

    func requestAccess(_ completion: @escaping (_ granted: Bool) -> Void) {
        store.requestAccess(for: .contacts) { granted, error in
            guard error == nil else { return }

            DispatchQueue.main.async {
                completion(granted)
            }
        }
    }

    private func sortContacts(_ contacts: [CNContact]) -> [CNContact] {
        return contacts.sorted { (contact1, contact2) -> Bool in
            if contact1.givenName < contact2.givenName {
                return true
            } else if contact1.givenName > contact2.givenName {
                return false
            } else {
                return contact1.familyName < contact2.familyName
            }
        }
    }
}
