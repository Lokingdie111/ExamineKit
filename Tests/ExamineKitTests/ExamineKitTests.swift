import Testing
@testable import ExamineKit

@Test func testEmailExaminerWithoutSpecific() async throws {
    #expect(RegisterExaminer.email(email: "example@example.com") == true)
    #expect(RegisterExaminer.email(email: "foo@@gmail.com") == false)
    #expect(RegisterExaminer.email(email: "foo@ho") == false)
    #expect(RegisterExaminer.email(email: "hei989@gmail.com") == true)
}

@Test func testEmailExaminerWithSpecific() async throws {
    #expect(RegisterExaminer.email(email: "exapmle@example.com", emailOptions: EmailOptions(specificDomain: "example.com")) == true)
    #expect(RegisterExaminer.email(email: "foo@example.com", emailOptions: EmailOptions(specificDomain: "foo.com")) == false)
    #expect(RegisterExaminer.email(email: "foo@foo.co.kr", emailOptions: EmailOptions(specificDomain: "foo.co")) == false)
    let re = RegisterExaminer(defaultEmailOption: EmailOptions(specificDomain: "foo.co.kr"))
    #expect(re.email(email: "example@foo.co.kr") == true)
    #expect(re.email(email: "example@foo.com") == false)
    #expect(re.email(email: "example@foo.com", emailOptions: EmailOptions(specificDomain: "foo.com")) == true)
    #expect(re.email(email: "example@example.com", emailOptions: EmailOptions(specificDomain: "foo.com")) == false)
}

@Test func testPassword() async throws {
    let r1 = RegisterExaminer.password(password: "Ab12345678!")
    #expect(r1.isEmpty)
    let r2 = RegisterExaminer.password(password: "")
    #expect(r2.contains(.unsatisfyMinLength))
    let r3 = RegisterExaminer.password(password: "Ab12345678")
    #expect(r3.contains(.unsatisfySpecialCharacter))
    let r4 = RegisterExaminer.password(password: "A12345678")
    #expect(r4.contains(.unsatisfyLowercase) && r4.contains(.unsatisfySpecialCharacter))
}
