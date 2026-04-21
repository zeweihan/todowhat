import SwiftUI

struct JournalView: View {
    // Mock journal entries for preview
    let entries: [JournalEntry] = [
        JournalEntry(
            day: 4,
            passageTitle: "Bodhidharma's Empty Hands",
            excerpt: "I struggled with this one. I think it means that the true essence of someone doesn't exist in their physical appearance...",
            date: "Today",
            hasInsight: true
        ),
        JournalEntry(
            day: 3,
            passageTitle: "The Western Paradise",
            excerpt: "The mind is like a mirror — it reflects but does not hold. I realized I've been holding onto too many labels...",
            date: "Yesterday",
            hasInsight: true
        ),
        JournalEntry(
            day: 2,
            passageTitle: "Hyakujo's Fox",
            excerpt: "Cause and effect are not to be dismissed. Every action has weight, even the ones we forget.",
            date: "2 days ago",
            hasInsight: false
        ),
        JournalEntry(
            day: 1,
            passageTitle: "Joshu's Dog",
            excerpt: "Mu. The absence of answer is itself the answer. I sat with this for longer than expected.",
            date: "3 days ago",
            hasInsight: true
        )
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.sumiBackground.ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: Space.section) {
                        // Header
                        HStack {
                            VStack(alignment: .leading, spacing: Space.xxs) {
                                Text("Your Journal")
                                    .sumiTextStyle(.hero)
                                    .foregroundColor(.sumiPrimaryText)
                                
                                Text("\(entries.count) reflections recorded")
                                    .sumiTextStyle(.subheadline)
                                    .foregroundColor(.sumiTertiaryText)
                            }
                            Spacer()
                        }
                        .padding(.horizontal, Space.screenEdge)
                        .padding(.top, Space.md)
                        .sumiEntrance(delay: 0)
                        
                        // Entries list
                        VStack(spacing: Space.lg) {
                            ForEach(Array(entries.enumerated()), id: \.offset) { index, entry in
                                JournalEntryCard(entry: entry, index: index)
                            }
                        }
                        .padding(.horizontal, Space.screenEdge)
                        
                        Spacer(minLength: Space.xxl)
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct JournalEntry: Identifiable {
    let id = UUID()
    let day: Int
    let passageTitle: String
    let excerpt: String
    let date: String
    let hasInsight: Bool
}

struct JournalEntryCard: View {
    let entry: JournalEntry
    let index: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: Space.md) {
            // Header row
            HStack {
                HStack(spacing: Space.sm) {
                    Text("Day \(entry.day)")
                        .sumiTextStyle(.label)
                        .foregroundColor(.sumiQuaternaryText)
                    
                    if entry.hasInsight {
                        Image(systemName: "sparkles")
                            .font(.system(size: 10))
                            .foregroundColor(.sumiMatcha)
                    }
                }
                
                Spacer()
                
                Text(entry.date)
                    .sumiTextStyle(.caption2)
                    .foregroundColor(.sumiQuaternaryText)
            }
            
            // Passage title
            Text(entry.passageTitle)
                .sumiTextStyle(.cardTitle)
                .foregroundColor(.sumiPrimaryText)
            
            SumiDivider()
            
            // Excerpt
            Text(entry.excerpt)
                .sumiTextStyle(.body)
                .foregroundColor(.sumiSecondaryText)
                .lineLimit(3)
                .lineSpacing(4)
        }
        .padding(Space.lg)
        .sumiCard(style: .default)
        .sumiStaggered(index: index, baseDelay: 0.1)
    }
}

#Preview {
    JournalView()
}
