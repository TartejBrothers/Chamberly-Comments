import SwiftUI

@main
struct task_1App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(MessageFieldViewModel())
        }
    }
}
