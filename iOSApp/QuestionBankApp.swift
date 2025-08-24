import SwiftUI
import QuestionBankCore

@main
struct QuestionBankApp: App {
    @StateObject private var repository = QuestionRepository()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                TopicListView()
                    .environmentObject(repository)
            }
        }
    }
}
