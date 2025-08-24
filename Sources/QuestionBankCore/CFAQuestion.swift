import Foundation

public struct CFAQuestion: Codable, Identifiable {
    public let id: UUID
    public let topic: Topic
    public let text: String
    public let options: [String]
    public let correctIndex: Int
    public let explanation: String

    public init(id: UUID = UUID(),
                topic: Topic,
                text: String,
                options: [String],
                correctIndex: Int,
                explanation: String) {
        self.id = id
        self.topic = topic
        self.text = text
        self.options = options
        self.correctIndex = correctIndex
        self.explanation = explanation
    }

    public enum Topic: String, Codable, CaseIterable {
        case ethics = "Ethics"
        case quantitativeMethods = "Quantitative Methods"
        case economics = "Economics"
        case financialReportingAnalysis = "Financial Reporting & Analysis"
        case corporateFinance = "Corporate Finance"
        case equity = "Equity"
        case fixedIncome = "Fixed Income"
        case derivatives = "Derivatives"
        case alternativeInvestments = "Alternative Investments"
        case portfolioManagement = "Portfolio Management"
    }
}
