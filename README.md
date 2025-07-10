# ExamineKit
Powerful Examining Kit In Swift

## Installation
### Add Package with SPM (Swfit Package Manager)

1. Copy this github url
2. Open SPM in Xcode
    - Xcode -> File -> Add Package Dependencies...
3. Paste url in search box
4. Select target.
5. Done!

## Information
- minimum deployment target
    - ios17
## RegisterExaminer
### methods
#### email
check email is vaild.
example
```swift
RegisterExaminer.email(email: "example@example.com") // true
RegisterExaminer.email(email: "exampl@gmail@com") // false
RegisterExaminer.email(email: "example@example.com", specificDomain: "foo.com") // false
```
#### password
#### age
#### gender
