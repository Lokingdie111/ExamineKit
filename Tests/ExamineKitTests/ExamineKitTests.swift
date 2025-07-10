import Testing
@testable import ExamineKit

@Test func testEmailExaminerWithoutSpecific() async throws {
    #expect(RegisterExaminer.email(email: "example@example.com") == true)
    #expect(RegisterExaminer.email(email: "foo@@gmail.com") == false)
    #expect(RegisterExaminer.email(email: "foo@ho") == false)
    #expect(RegisterExaminer.email(email: "hei989@gmail.com") == true)
}

@Test func testEmailExaminerWithSpecific() async throws {
    #expect(RegisterExaminer.email(email: "exapmle@example.com", specificDomain: "example.com") == true)
    #expect(RegisterExaminer.email(email: "foo@example.com", specificDomain: "foo.com") == false)
}

@Test func testPasswordStatic() async throws {
    #expect(RegisterExaminer.password(password: "12345678") == false)
    #expect(RegisterExaminer.password(password: "Ab1$") == false)
    #expect(RegisterExaminer.password(password: "Abbabababa!") == false)
    #expect(RegisterExaminer.password(password: "Abbabababa!", passwordOptions: PasswordOptions(numberConatian: 0)) == true)
}

@Test func testPasswordInstance() async throws {
    
}
