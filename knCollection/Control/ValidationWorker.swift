//
//  ValidationWorker.swift
//  Fixir
//
//  Created by Ky Nguyen on 3/7/17.
//  Copyright © 2017 Ky Nguyen. All rights reserved.
//

import Foundation


enum knErrorCode : String {
    case loginFail
    case invalidEmail
    case invalidPassword
    case notFound
    case timeOut
    case serverError
    case empty
    case emailExist
    case weakPassword
    case notSure
    case facebookCancel
    case cantGetUploadedUrl
    case uploadFail
}

struct knError {
    
    var code: knErrorCode?
    var message: String?
}

struct knValidationWorker {
    
    var responseToResult: ((knError?) -> Void)?
    
    func validateEmailSilently(_ email: String) {
        
        if email.length == 0 {
            responseToResult?(knError(code: .invalidEmail, message: "Email can't be blank"))
            return
        }
        
        if isValidEmail(email: email) == false {
            responseToResult?(knError(code: .invalidEmail, message: "Invalid format"))
            return
        }
        
        responseToResult?(nil)
    }
    
    func validateEmailFormat(_ email: String) {
        if email.length == 0 {
            responseToResult?(knError(code: .invalidEmail, message: "Email can't be blank"))
            return
        }
        
        if isValidEmail(email: email) == false {
            responseToResult?(knError(code: .invalidEmail, message: "Invalid format"))
            return
        }
        
        responseToResult?(nil)
    }
    
    func validateEmail(_ email: String) {
        
        if email.length == 0 {
            responseToResult?(knError(code: .invalidEmail, message: "Email can't be blank"))
            return
        }
        
        if isValidEmail(email: email) == false {
            responseToResult?(knError(code: .invalidEmail, message: "Invalid format"))
            return
        }
        
        self.responseToResult?(nil)
    }

    private func isValidEmail(email: String?) -> Bool {
        
        guard email != nil else { return false }
        return email!.isValidEmail()
    }
    
    
    func validatePassword(_ password: String) {
        
        if password.length == 0 {
            responseToResult?(knError(code: .notSure, message: "Password can't be blank"))
            return
        }
        
        let isValid = password.length >= 6
        if isValid == true {
            responseToResult?(nil)
        }
        else {
            let error = knError(code: .weakPassword, message: "Too weak. At least 6 characters")
            responseToResult?(error)
        }
    }
    
    func validateName(_ name: String) {
        if name.length == 0 {
            responseToResult?(knError(code: .notSure, message: "Name can't be blank"))
            return
        }
        
        responseToResult?(nil)
        
    }
    
    func validatePhone(_ phone: String) {
        
        if phone.length == 0 {
            responseToResult?(knError(code: .notSure, message: "Phone can't be blank"))
            return
        }

        
        /* SG Phone Number */
        let newPhone = phone.replacingOccurrences(of: "+65", with: "")
        if (newPhone.startsWith("8") || newPhone.startsWith("9")) && newPhone.length == 8 {
            responseToResult?(nil)
        }
        else {
            responseToResult?(knError(code: .notSure, message: "Invalid phone number"))
        }
    }
    
    func validatePlateNumber(_ plateNumber: String) {
        
        if plateNumber.length == 0 {
            responseToResult?(knError(code: .notSure, message: "Plate number can't be blank"))
            return
        }
        
        
        let regex = try! NSRegularExpression(pattern: "^B[A-Z]{2}-[0-9]{3}$", options: .caseInsensitive)
        let range = NSRange(location: 0, length: plateNumber.length)
        let matchRange = regex.rangeOfFirstMatch(in: plateNumber, options: .withTransparentBounds, range: range)
        
        if matchRange.location == NSNotFound {
            responseToResult?(knError(code: .notSure, message: "Invalid plate number"))
        }
        else {
            responseToResult?(nil)
        }
    }
    
    func validateVIN(_ VIN: String) {
        
        if VIN.length == 0 {
            responseToResult?(knError(code: .notSure, message: "VIN number can't be blank"))
            return
        }
        
        
        let regex = try! NSRegularExpression(pattern: "^[A-HJ-NPR-Za-hj-npr-z\\d]{8}[\\dX][A-HJ-NPR-Za-hj-npr-z\\d]{2}\\d{6}$", options: .caseInsensitive)
        let range = NSRange(location: 0, length: VIN.length)
        let matchRange = regex.rangeOfFirstMatch(in: VIN, options: .withTransparentBounds, range: range)
        
        if matchRange.location == NSNotFound {
            responseToResult?(knError(code: .notSure, message: "Invalid VIN number"))
        }
        else {
            responseToResult?(nil)
        }
        
    }
    
    func validateNRIC(_ NRIC: String) {
        
        if NRIC.length == 0 {
            responseToResult?(knError(code: .notSure, message: "NRIC can't be blank"))
            return
        }
        
        if NRIC.length < 5 {
            let error = knError(code: .notSure, message: "Invalid NRIC")
            responseToResult?(error)
            return
        }
        
        let isValid = NRIC.length == 5
        if isValid == true {
            responseToResult?(nil)
            return
        }
        
        
        
    }
    
    func validateYear(_ year: String) {

        let inputYear = Int(year) ?? 0
        let currentYear = Date.currentYear
        
        if inputYear == 0 {
            responseToResult?(nil)
        }
        
        let isValid = inputYear < currentYear
        
        if isValid == true {
            responseToResult?(nil)
        }
        else {
            let error = knError(code: .notSure, message: "Year can't be in the future")
            responseToResult?(error)
        }
    }
    
}
