//
//  Extensions.swift
//  TokiChat
//
//  Created by Petar Lemajic on 11/19/18.
//  Copyright © 2018 Metalic_archaea. All rights reserved.
//

import Foundation

extension String {
    //Email regex
    public func isValidEmailAddress() -> Bool {
        let emailRegex = "^[\\w!#$%&'*+/=?`{|}~^-]+(?:\\.[\\w!#$%&'*+/=?`{|}~^-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,6}$"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
    //Password regex
    public func isValidPassword() -> Bool {
        let passwordRegex = "^(?!.*(/|\\|\"|;|,|:))(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%&?+-=*<>.]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
    }
    //Valid name and surname regex
    public func isValidNameOrSurname() -> Bool {
        let nameOrLastNameRegex = "^[A-Za-z äöüÄÖÜß,./'-]{3,100}$"
        return NSPredicate(format: "SELF MATCHES %@", nameOrLastNameRegex).evaluate(with: self)
    }
    //Address regex
    public func isValidAddress() -> Bool {
        let addressRegex = "^[A-Za-z0-9 äöüÄÖÜß-]{3,100}$"
        return NSPredicate(format: "SELF MATCHES %@", addressRegex).evaluate(with: self)
    }
    
    static func randomCharacters(withLength length: Int = 20) -> String {
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString: String = ""
        
        for _ in 0..<length {
            let randomValue = arc4random_uniform(UInt32(base.count))
            randomString += "\(base[base.index(base.startIndex, offsetBy: Int(randomValue))])"
        }
        return randomString
    }
}
