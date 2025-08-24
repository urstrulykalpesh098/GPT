import SwiftUI
import QuestionBankCore

struct QuestionView: View {
    @State var question: CFAQuestion
    @State private var selectedIndex: Int? = nil
    @State private var explanationText: String = ""
    @State private var showExplanation = false
    @State private var isLoading = false

    let chatGPTClient = ChatGPTClient {
        KeychainHelper.shared.apiKey
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(question.text)
                .font(.title3)

            ForEach(question.options.indices, id: \.self) { idx in
                Button(action: { select(idx) }) {
                    HStack {
                        Text(question.options[idx])
                        Spacer()
                    }
                    .padding()
                    .background(color(for: idx))
                    .cornerRadius(8)
                }
                .disabled(selectedIndex != nil)
            }

            if isLoading {
                ProgressView()
            } else if showExplanation {
                Text(explanationText)
                    .padding()
            }

            Spacer()
        }
        .padding()
        .navigationTitle(question.topic.rawValue)
    }

    func select(_ idx: Int) {
        selectedIndex = idx
        showExplanation = true
        if idx == question.correctIndex {
            explanationText = "Correct! \(question.explanation)"
        } else {
            explanationText = "Incorrect. \(question.explanation)"
            Task {
                do {
                    isLoading = true
                    let gptExplanation = try await chatGPTClient.explanation(for: question, chosenIndex: idx)
                    explanationText += "\n\n\(gptExplanation)"
                } catch {
                    explanationText += "\n\n(OpenAI explanation unavailable.)"
                }
                isLoading = false
            }
        }
    }

    func color(for index: Int) -> Color {
        guard let selected = selectedIndex else {
            return Color.blue.opacity(0.1)
        }
        if index == selected {
            return index == question.correctIndex ? .green.opacity(0.3) : .red.opacity(0.3)
        } else if index == question.correctIndex {
            return .green.opacity(0.3)
        } else {
            return Color.blue.opacity(0.1)
        }
    }
}
