//
//  ContactPickerIntention.swift
//  kLibrary
//
//  Created by Ky Nguyen on 1/26/16.
//  Copyright © 2016 Ky Nguyen. All rights reserved.
//
//
//import UIKit
//import AddressBook
//
//struct Contact {
//    
//    var name = ""
//    var phone = ""
//}
//
//class knContactPicker: NSObject, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
//
//    @IBOutlet weak var searchBar: UISearchBar!
//    
//    @IBOutlet weak var tableView: UITableView!
//    
//    fileprivate var sourceContactsBook = [String : [Contact]]()
//    fileprivate var contactsBook = [String : [Contact]]()
//    fileprivate var contactGroup = [Contact]()
//    
//    fileprivate var peopleSectionTitles = [String]()
//    
//    fileprivate func openSettings() {
//        let url = URL(string: UIApplicationOpenSettingsURLString)
//        UIApplication.shared.openURL(url!)
//    }
//        
//    func getAllContacts() {
//        
//        setupUI()
//        
//        // make sure user hadn't previously denied access
//        let status = ABAddressBookGetAuthorizationStatus()
//        if status == .denied || status == .restricted {
//            // user previously denied, to tell them to fix that in settings
//            return
//        }
//      
//        var error: Unmanaged<CFError>?
//        let addressBook: ABAddressBook? = ABAddressBookCreateWithOptions(nil, &error)?.takeRetainedValue()
//
//        // request permission to use it
//        ABAddressBookRequestAccessWithCompletion(addressBook) {
//            granted, error in
//            
//            if granted == false {
//                // warn the user that because they just denied permission, this functionality won't work
//                // also let them know that they have to fix this in settings
//            
//                return
//            }
//
//            var currentCharacter = "A"
//            
//            let allContacts = ABAddressBookCopyArrayOfAllPeople(addressBook).takeRetainedValue() as Array
//
//            for i in 0 ..< allContacts.count {
//                
//                let currentContact: ABRecord = allContacts[i]
//                let currentName = self.getNameFromContact(currentContact)
//                let nameFirstChar = self.getNameFirstCharFromString(currentName)
//                
//                if i == 0 {
//                    
//                    currentCharacter = nameFirstChar
//                }
//                
//                if nameFirstChar != currentCharacter {
//
//                    self.storeContactToBookWithGroup(currentCharacter)
//                    currentCharacter = nameFirstChar
//                    self.contactGroup = [Contact]()
//                }
//                
//                let phoneNumberList = self.getPhoneNumbersFromContact(currentContact)
//                if let list = phoneNumberList {
//                    
//                    for phone in list {
//                        
//                        self.saveContactToGroupWithName(currentName, phone: phone)
//                    }
//                }
//            }
//            
//            self.prepareDataForTableView()
//        }
//    }
//    
//    fileprivate func setupUI() {
//        
//        searchBar.delegate = self
//        searchBar.returnKeyType = UIReturnKeyType.done
//        
//        tableView.delegate = self
//        tableView.dataSource = self
//    }
//    
//    fileprivate func getNameFromContact(_ currentContact: ABRecord) -> String {
//        
//        let firstName = ABRecordCopyValue(currentContact, kABPersonFirstNameProperty)
//        let lastName = ABRecordCopyValue(currentContact, kABPersonLastNameProperty)
//        
//        var currentName = ""
//        if firstName == nil && lastName == nil { // prevent anonymous contact
//            
//            currentName = ""
//        }
//        else {
//            
//            currentName = ABRecordCopyCompositeName(currentContact).takeRetainedValue() as String
//        }
//        
//        return currentName
//    }
//    
//    fileprivate func getNameFirstCharFromString(_ name: String) -> String {
//        
//        var nameFirstChar = name
//        if name == "" {
//            
//            nameFirstChar = "#"
//        }
//        else {
//            
//            nameFirstChar = (name as NSString).substring(to: 1).uppercased()
//        }
//        
//        if nameFirstChar.isALetter() == false {
//            
//            nameFirstChar = "#"
//        }
//        
//        return nameFirstChar
//    }
//    
//    func getEmail(_ currentContact: ABRecord) -> String {
//        
//        let email:ABMultiValue = ABRecordCopyValue(currentContact, kABPersonEmailProperty).takeRetainedValue()
//        
//        var emailString = ""
//        
//        if ABMultiValueGetCount(email) > 0{
//        
//            emailString = ABMultiValueCopyValueAtIndex(email, 0).takeRetainedValue() as! String
//        }
//
//        return emailString
//    }
//    
//    fileprivate func getPhoneNumbersFromContact(_ currentContact: ABRecord) -> [String]? {
//        
//        var phoneNumberList = [String]()
//        let phones:ABMultiValue = ABRecordCopyValue(currentContact, kABPersonPhoneProperty).takeRetainedValue()
//        let count = ABMultiValueGetCount(phones)
//        for j in 0 ..< count {
//            let mobileLabel = ABMultiValueCopyLabelAtIndex(phones, j).takeRetainedValue()
//            
//            if mobileLabel == kABPersonPhoneMobileLabel ||
//                mobileLabel == kABHomeLabel ||
//                mobileLabel == kABPersonPhoneMainLabel ||
//                mobileLabel == kABPersonPhoneIPhoneLabel ||
//                mobileLabel == kABOtherLabel ||
//                mobileLabel == kABWorkLabel {
//                    
//                    let phone = ABMultiValueCopyValueAtIndex(phones, j).takeRetainedValue() as! String
//                    phoneNumberList.append(phone)
//            }
//        }
//        
//        return phoneNumberList
//    }
//    
//    fileprivate func prepareDataForTableView() {
//        
//        self.peopleSectionTitles = [String](self.contactsBook.keys)
//        self.peopleSectionTitles = self.peopleSectionTitles.sorted()
//        
//        DispatchQueue.main.async(execute: { () -> Void in
//            
//            self.tableView.reloadData()
//        })
//    }
//    
//    fileprivate func saveContactToGroupWithName(_ name: String, phone: String) {
//        
//        var contactItem = Contact()
//        contactItem.name = name
//        contactItem.phone = phone
//        self.contactGroup.append(contactItem)
//    }
//    
//    fileprivate func storeContactToBookWithGroup(_ currentCharacter: String) {
//        
//        if let group = contactsBook[currentCharacter] {
//            
//            for contact in group {
//                
//                contactGroup.append(contact)
//            }
//        }
//
//        contactGroup.sort { (contact1, contact2) -> Bool in
//            
//            if contact1.name < contact2.name {
//                
//                return true
//            }
//            else {
//                
//                return false
//            }
//        }
//        
//        contactsBook[currentCharacter] = contactGroup
//        sourceContactsBook = contactsBook
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        
//        return peopleSectionTitles.count
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        
//        let sectionTitle = peopleSectionTitles[section]
//        return contactsBook[sectionTitle]!.count
//    }
//    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        
//        return peopleSectionTitles[section]
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
//        
//        let person = getPersonInfo(indexPath)
//        
//        let name = person.name
//
//        if name == "" {
//            
//            cell.textLabel?.text = person.phone
//            cell.detailTextLabel?.text = ""
//        }
//        else {
//            
//            cell.textLabel?.text = name
//            cell.detailTextLabel?.text = person.phone
//        }
//        
//        return cell
//    }
//
//    func getPersonInfo(_ indexPath: IndexPath) -> Contact {
//        
//        let sectionTitle = peopleSectionTitles[(indexPath as NSIndexPath).section]
//        return contactsBook[sectionTitle]![(indexPath as NSIndexPath).row]
//    }
//
//    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
//        
//        return peopleSectionTitles
//    }
//    
//    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
//        
//        return peopleSectionTitles.index(of: title)!
//    }
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        
//        if searchText.characters.count == 0 {
//            
//            contactsBook = sourceContactsBook
//        }
//        else {
//            
//            var allContacts = [Contact]()
//            for contacts in sourceContactsBook.values {
//                
//                allContacts.append(contentsOf: contacts)
//            }
//            
//            let foundContacts = allContacts.filter({ (contact) -> Bool in
//                
//                contact.name.contains(searchText)
//            })
//            
//            contactsBook = ["" : foundContacts]
//        }
//        
//        prepareDataForTableView()
//    }
//    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        
//        searchBar.resignFirstResponder()
//    }
//    
//    
//}
//
//extension String {
//
//    func isALetter() -> Bool {
//        
//        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
//        return letters.contains(self)
//    }
//}
//
//
