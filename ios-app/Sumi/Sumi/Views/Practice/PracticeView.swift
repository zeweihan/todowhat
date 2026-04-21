import SwiftUI

enum PracticeRoute: Hashable {
    case passage
    case dialogue
    case completion
}

struct PracticeView: View {
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            HomeView {
                // Navigate to the start of the session
                navigationPath.append(PracticeRoute.passage)
            }
            .navigationDestination(for: PracticeRoute.self) { route in
                switch route {
                case .passage:
                    SessionPassageView {
                        navigationPath.append(PracticeRoute.dialogue)
                    }
                    .navigationBarBackButtonHidden(true)
                    // You might want a custom back button that prompts "Cancel practice?"
                case .dialogue:
                    SessionDialogueView {
                        navigationPath.append(PracticeRoute.completion)
                    }
                    .navigationBarBackButtonHidden(true)
                case .completion:
                    SessionCompletionView {
                        // Return to Home
                        navigationPath.removeLast(navigationPath.count)
                    }
                    .navigationBarBackButtonHidden(true)
                }
            }
        }
    }
}

#Preview {
    PracticeView()
}
