import SwiftUI

struct JournalView: View {
    var body: some View {
        NavigationStack {
            List {
                Text("Journal entries will appear here")
                    .foregroundColor(.secondary)
            }
            .navigationTitle("Journal")
        }
    }
}

#Preview {
    JournalView()
}
