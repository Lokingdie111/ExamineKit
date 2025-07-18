// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public struct PasswordOptions {
    var minLength: Int = 8
    var uppercase: Int = 1
    var lowercase: Int = 1
    var specialCharacter: Int = 1
    var number: Int = 1
    var banned: String = ""
    
    public init() {}
}

/// Indicates which conditions the password does not satisfy.
/// - unsatisfyMinLength: Password unsatisfy rule of minLength
/// - unsatisfyLowercase: Password unsatisfy rule of lowercase
/// - unsatisfyUppercase: Password unsatisfy rule of uppercase
/// - unsatisfySpecialCharacter: Password unsatisfy rule of specialCharactor
/// - unsatisfyNumber: Password unssatisfy rule of number
/// - containBannedWord: Password contain bannedWord
public enum PasswordError {
    case unsatisfyMinLength
    case unsatisfyLowercase
    case unsatisfyUppercase
    case unsatisfySpecialCharacter
    case unsatisfyNumber
    case containBannedWord
}

public struct EmailOptions {
    var specificDomain: String? = nil
    
    public init(specificDomain: String? = nil) {
        self.specificDomain = specificDomain
    }
}

public class RegisterExaminer {
    /// Store default option
    private let passwordOption: PasswordOptions
    private let emailOption: EmailOptions
    
    /// Check is vaild email.
    ///
    /// - Parameters:
    ///     - email: Email that needs to check vaild.
    ///     - emailOptions: Set options
    ///         - specificDomain: Set specific domain email needs to use.
    /// - Returns: If is vaild, returns true.
    ///
    public static func email(email: String, emailOptions: EmailOptions = EmailOptions()) -> Bool {
        let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let matches = detector?.matches(in: email, options: [], range: NSRange(location: 0, length: email.utf16.count)) ?? []
        
        let result =  matches.contains {
            $0.url?.scheme == "mailto" && $0.range.length == email.utf16.count
        }
        // Return false if email is not vaild
        if result == false {
            return result
        }
        if let specificDomain = emailOptions.specificDomain {
            // Using specific domain
            let domain = email.split(separator: "@").last
            if let domain = domain {
                if domain == specificDomain {
                    return result && true
                } else {
                    return false
                }
            } else {
                return false
            }
        } else {
            // Not using specific domain
            return result
        }
    }
    /// Check is vaild email.
    ///
    /// - Parameters:
    ///     - email: Email that needs to check vaild.
    ///     - emailOptions: Set options
    ///         - specificDomain: Set specific domain email needs to use.
    /// - Returns: If is vaild, returns true.
    ///
    public func email(email: String, emailOptions: EmailOptions? = nil) -> Bool {
        if let emailOptions = emailOptions {
            return RegisterExaminer.email(email: email, emailOptions: emailOptions)
        } else {
            return RegisterExaminer.email(email: email, emailOptions: self.emailOption)
        }
    }
    /// Check  is vaild password.
    ///
    /// ## Default Option:
    /// - minLength: 8
    /// - uppercase: 1
    /// - numberContain: 1
    /// - lowercase: 1
    /// - specialCharactor: 1
    /// - banned: Empty
    /// ## Examples:
    /// - Parameters:
    ///     - password: Password that needs to check vaild.
    ///     - passwordOptions: give password options to check password vaild.
    ///         If this parameters not given it will use Default Option.
    /// - Returns: Retrun array of PasswordError enum. If array is emtpy, password is vaild.
    public static func password(password: String, passwordOptions: PasswordOptions? = nil) -> [PasswordError] {
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
    /// - numberContain: 1
    /// - specialCharactor: 1
    /// - banned: Emtpy
    /// - If you set default password option when you create instance, follow that option.
    /// ## Examples:
    /// - Parameters:
    ///     - password: Password that needs to check vaild.
    ///     - passwordOptions: give password options to check password vaild.
    ///         If this parameters not given it will use default Value.
    /// - Returns: Return array of PasswordError enum. If array is empty, password is vaild.
    public func password(password: String, passwordOptions: PasswordOptions? = nil) -> [PasswordError] {
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
    private static func checkPassword(password: String, option: PasswordOptions) -> [PasswordError] {
        var result: [PasswordError] = []
        // check banned
        let bannedList: [String] = option.banned.components(separatedBy: " ")
        // edit this string to change lower, upper, special charctors
        let uppercaseList = "ABCDEFGHIJKLNMOPQRSTUVWXYZ"
        let lowercaseList = "abcdefghijklmnopqrstuvwxyz"
        let specialCharacters = "!@#$%^&*()-_=+[]{}|;:'\",.<>?/\\`~"
        let numberList = "0123456789"
        
        for ban in bannedList {
            if password.contains(ban) {
                result.append(.containBannedWord)
            }
        }
        
        // check minlength
        if password.count < option.minLength {
            result.append(.unsatisfyMinLength)
            
        }
        // check numbercontain
        var numberCount = 0
        for char in password {
            if numberList.contains(String(char)) {
                numberCount += 1
            }
        }
        if numberCount < option.number {
            result.append(.unsatisfyNumber)
        }
        // check uppercase
        var upperCount = 0
        for char in password {
            if uppercaseList.contains(String(char)) {
                upperCount += 1
            }
        }
        if upperCount < option.uppercase {
            result.append(.unsatisfyUppercase)
        }
        
        // check lowercase
        var lowerCount = 0
        for char in password {
            if lowercaseList.contains(String(char)) {
                lowerCount += 1
            }
        }
        
        if lowerCount < option.lowercase {
            result.append(.unsatisfyLowercase)
        }
        
        // check special
        var specCount = 0
        for char in password {
            if specialCharacters.contains(String(char)) {
                specCount += 1
            }
        }
        if specCount < option.specialCharacter {
            result.append(.unsatisfySpecialCharacter)
        }
        return result
    }
    
    
    
    
    
    
    
    public init(defaultEmailOption: EmailOptions = EmailOptions(), defaultPasswordOption: PasswordOptions = PasswordOptions()) {
        self.emailOption = defaultEmailOption
        self.passwordOption = defaultPasswordOption
    }
}
