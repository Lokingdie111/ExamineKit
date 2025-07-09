import Testing
@testable import ExamineKit

@Test func testEmailExaminerWithoutSpecific() async throws {
    #expect(RegisterExaminer.email(targetString: "example@example.com") == true)
    #expect(RegisterExaminer.email(targetString: "foo@@gmail.com") == false)
    #expect(RegisterExaminer.email(targetString: "foo@ho") == false)
    #expect(RegisterExaminer.email(targetString: "hei989@gmail.com") == true)
}

@Test func testEmailExaminerWithSpecific() async throws {
    #expect(RegisterExaminer.email(targetString: "exapmle@example.com", specificDomain: "example.com") == true)
    #expect(RegisterExaminer.email(targetString: "foo@example.com", specificDomain: "foo.com") == false)
}

