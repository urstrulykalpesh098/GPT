import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

public protocol ChatGPTClientProtocol {
    func explanation(for question: CFAQuestion, chosenIndex: Int) async throws -> String
}

public final class ChatGPTClient: ChatGPTClientProtocol {
    private let session: URLSession
    private let apiKeyProvider: () -> String?

    public init(session: URLSession = URLSession.shared, apiKeyProvider: @escaping () -> String?) {
        self.session = session
        self.apiKeyProvider = apiKeyProvider
    }

    public func explanation(for question: CFAQuestion, chosenIndex: Int) async throws -> String {
        guard let apiKey = apiKeyProvider() else {
            throw ChatGPTError.missingAPIKey
        }

        let url = URL(string: "https://api.openai.com/v1/chat/completions")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let prompt = """
        You are a tutor helping a student preparing for the CFA Level I exam.
        Question: \(question.text)
        Options: \(question.options)
        Student's answer index: \(chosenIndex)
        Correct answer index: \(question.correctIndex)
        Provide a concise explanation why the student's choice is wrong and how to remember the correct concept.
        """

        let body: [String: Any] = [
            "model": "gpt-4o-mini",
            "messages": [
                ["role": "user", "content": prompt]
            ]
        ]

        request.httpBody = try JSONSerialization.data(withJSONObject: body)

        let (data, _) = try await session.data(for: request)
        struct Response: Decodable {
            let choices: [Choice]
            struct Choice: Decodable {
                let message: Message
                struct Message: Decodable {
                    let content: String
                }
            }
        }

        let result = try JSONDecoder().decode(Response.self, from: data)
        return result.choices.first?.message.content ?? "No explanation available."
    }

    public enum ChatGPTError: Error {
        case missingAPIKey
    }
}
