import XCTest
@testable import QuestionBankCore

final class QuestionBankCoreTests: XCTestCase {
    func testQuestionFiltering() {
        let repo = QuestionRepository()
        let quantQuestions = repo.questions(for: .quantitativeMethods)
        XCTAssertTrue(quantQuestions.allSatisfy { $0.topic == .quantitativeMethods })
    }

    func testTVMCalculator() {
        let fv = TVMCalculator.futureValue(presentValue: 1000, rate: 0.05, periods: 2)
        XCTAssertEqual(round(fv), 1103)
    }
}
