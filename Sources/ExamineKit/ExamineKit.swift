// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

struct PasswordOptions {
    var minLength: Int = 8
    var uppercase: Int = 1
    var lowercase: Int = 1
    var specialCharacter: Int = 1
    var numberConatian: Int = 1
    var banned: String = ""
}

struct EmailOptions {
    var specificDomain: String? = nil
}

class RegisterExaminer {
    /// Store default option
    private let passwordOption: PasswordOptions
    private let emailOption: EmailOptions
    
    /// Check is vaild email.
    ///
    /// ## Example:
    /// ```swift
    /// RegisterExaminer.email(email: "example@example.com") // true
    /// RegisterExaminer.email(email: "example@example.com", specificDomain: "foo.com") // false
    /// ```
    /// ## Common mistakes:
    /// ```swift
    /// // Use specificDomain value without "@" symbol
    /// RegisgerExaminer.email(email: "example@example.com", specificDomain: "@foo.com")
    /// ```
    /// - Parameters:
    ///     - email: Email that needs to check vaild.
    ///     - specificDomain: If you need check email use specific domain, set this parameter with out @ symbol
    /// - Returns: If is vaild, returns true.
    ///
    public static func email(email: String, specificDomain: String? = nil) -> Bool {
        let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let matches = detector?.matches(in: email, options: [], range: NSRange(location: 0, length: email.utf16.count)) ?? []
        
        let result =  matches.contains {
            $0.url?.scheme == "mailto" && $0.range.length == email.utf16.count
        }
        
        // Return false if email is not vaild
        if result == false {
            return result
        }
        if let specificDomain = specificDomain {
            // Using specific domain
            return result && email.contains(specificDomain)
        } else {
            // Not using specific domain
            return result
        }
    }
    
    /// Check  is vaild password.
    ///
    /// ## Default Option:
    /// - minLength: 8
    /// - uppercase: 1
    /// - lowercase: 1
    /// - specialCharactor: 1
    /// ## Examples:
    /// - Parameters:
    ///     - password: Password that needs to check vaild.
    ///     - passwordOptions: give password options to check password vaild.
    ///         If this parameters not given it will use Default Option.
    ///
    public static func password(password: String, passwordOptions: PasswordOptions? = nil) -> Bool {
        var d: PasswordOptions
        if let passwordOptions = passwordOptions {
            // PasswordOptions given
            d = passwordOptions
        } else {
            // PasswordOptions not given
            d = PasswordOptions()
        }
        
        return checkPassword(password: password, option: d)
    }
    
    /// Check  is vaild password.
    ///
    /// ## Default Option:
    /// - minLength: 8
    /// - uppercase: 1
    /// - lowercase: 1
    /// - specialCharactor: 1
    /// - If you set default password option when you create instance, follow that option.
    /// ## Examples:
    /// - Parameters:
    ///     - password: Password that needs to check vaild.
    ///     - passwordOptions: give password options to check password vaild.
    ///         If this parameters not given it will use default Value.
    ///
    public func password(password: String, passwordOptions: PasswordOptions? = nil) -> Bool {
        var d: PasswordOptions
        if let passwordOptions = passwordOptions {
            // PasswordOptions given
            d = passwordOptions
        } else {
            // PasswordOptions not given
            d = self.passwordOption
        }
        
        // Use d for passwordOption
        return RegisterExaminer.checkPassword(password: password, option: d)
    }
    
    /// Core password Checker
    private static func checkPassword(password: String, option: PasswordOptions) -> Bool {
        // check banned
        let bannedList: [String] = option.banned.components(separatedBy: " ")
        // edit this string to change lower, upper, special charctors
        let uppercaseList = "ABCDEFGHIJKLNMOPQRSTUVWXYZ"
        let lowercaseList = "abcdefghijklmnopqrstuvwxyz"
        let specialCharacters = "!@#$%^&*()-_=+[]{}|;:'\",.<>?/\\`~"
        let numberList = "0123456789"
        
        for ban in bannedList {
            if password.contains(ban) {
                return false
            }
        }
        // check minlength
        if password.count < option.minLength {
            return false
        }
        // check numbercontain
        var numberCount = 0
        for char in numberList {
            if password.contains(String(char)) {
                numberCount += 1
            }
        }
        if numberCount < option.numberConatian {
            return false
        }
        // check uppercase
        var upperCount = 0
        for char in uppercaseList {
            if password.contains(String(char)) {
                upperCount += 1
            }
        }
        if upperCount < option.uppercase {
            return false
        }
        
        // check lowercase
        var lowerCount = 0
        for char in lowercaseList {
            if password.contains(String(char)) {
                lowerCount += 1
            }
        }
        
        if lowerCount < option.lowercase {
            return false
        }
        
        // check special
        var specCount = 0
        for char in specialCharacters {
            if password.contains(String(char)) {
                specCount += 1
            }
        }
        if specCount < option.specialCharacter {
            return false
        }
        return true
    }
    
    init(defaultEmailOption: EmailOptions = EmailOptions(), defaultPasswordOption: PasswordOptions = PasswordOptions()) {
        self.emailOption = defaultEmailOption
        self.passwordOption = defaultPasswordOption
    }
}
