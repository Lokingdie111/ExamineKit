// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

class RegisterExaminer {
    
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
    /// ```swift
    /// RegisterExaminer.password(password: "12345678") // false
    /// RegisterExaminer.password(password: "12345678", uppercase: 0, lowercase: 0, specialCharactor: 0) // true
    /// RegisterExaminer.password(password: "12345678", uppercase: 0, lowercase: 0, specialCharactor: 0, minLength: 10) // false
    /// RegisterExaminer.password(password: "12345678") // false
    /// RegisterExaminer.password(password: "12345678") // false
    /// RegisterExaminer.password(password: "12345678") // false
    /// ```
    /// - Parameters:
    ///     - password: Password that needs to check vaild.
    ///     - minLength: Set password to be longer than this value.
    ///     - uppercase: Password needs to contain uppercase at least as this value.
    ///     - lowercase: Password needs to contain lowercase at least as this value.
    ///     - specialCharactor: Password needs to conatin specialCharactor at least as this value.
    /// - Returns: If this password satisfy options, returns true.
    public static func password(password: String, minLength: Int = 8, uppercase: Int = 1, lowercase: Int = 1, specialCharactor: Int = 1) -> Bool {
        
        return true
    }
}
