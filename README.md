# ExamineKit
Powerful Examining Kit In Swift

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
