// The Swift Programming Language
// https://docs.swift.org/swift-book

class RegisterExaminer {
    /// Check is vaild email.
    ///
    ///
    /// ## Example:
    /// ```swift
    /// RegisterExaminer.email(targetString: "example@example.com") // true
    /// RegisterExaminer.email(targetString: "example@example.com", forceDomain: "@foo.com") // false
    /// ```
    /// - Parameters:
    ///     - targetString: Email that needs to check vaild.
    ///     - forceDomain: If you need check email use specific domain, set this parameter with out @ symbol
    /// - Returns: If is vaild returns true.
    public static func email(targetString: String, forceDomain: String? = nil) {
        if let forceDomain = forceDomain {
            // Using specific domain
            
        } else {
            // Not using specific domain
            
        }
    }
    
}
