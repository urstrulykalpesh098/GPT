import SwiftUI
import QuestionBankCore

struct TopicListView: View {
    @EnvironmentObject var repository: QuestionRepository

    var body: some View {
        List {
            ForEach(CFAQuestion.Topic.allCases, id: \.self) { topic in
                NavigationLink(topic.rawValue) {
                    if let question = repository.randomQuestion(for: topic) {
                        QuestionView(question: question)
                    } else {
                        Text("No questions available.")
                    }
                }
            }
        }
        .navigationTitle("CFA Level I")
    }
}
