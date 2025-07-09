// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

enum PasswordOptions {
    case uppercaseInclude(count: Int)
    case lowercaseInclude(count: Int)
    case specialCharactorInclude(count: Int)
    case length(count: Int)
}
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
    public static func password(password: String, options: )
}
