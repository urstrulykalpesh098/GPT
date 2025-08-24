import Foundation

public final class QuestionRepository {
    private var questions: [CFAQuestion] = []

    public init() {
        loadQuestions()
    }

    private func loadQuestions() {
        guard let url = Bundle.module.url(forResource: "questions", withExtension: "json") else {
            print("Questions resource not found.")
            return
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            questions = try decoder.decode([CFAQuestion].self, from: data)
        } catch {
            print("Failed to load questions: \(error)")
        }
    }

    public func questions(for topic: CFAQuestion.Topic) -> [CFAQuestion] {
        questions.filter { $0.topic == topic }
    }

    public func randomQuestion(for topic: CFAQuestion.Topic) -> CFAQuestion? {
        questions(for: topic).randomElement()
    }
}
