import SwiftUI

struct PathwayDayDetailView: View {
    let day: Int
    @Environment(\.dismiss) private var dismiss
    
    let passageCitations = "The Gateless Gate, Case 4"
    let passageText = "Wakuan complained when he saw a picture of bearded Bodhidharma, 'Why hasn't that fellow a beard?'"
    let aiPrompt = "If Bodhidharma has no beard, what face is he showing the world right now?"
    let userReflection = "I struggled with this one. I think it means that the true essence of someone doesn't exist in their physical appearance or the labels we put on them."
    let aiResponse = "To seek the beard is to miss the face. To seek the face is to miss the man. Sit with the question itself."
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.sumiBackground.ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: Space.xxl) {
                        // Passage Card
                        VStack(alignment: .leading, spacing: Space.lg) {
                            HStack {
                                Text(passageCitations.uppercased())
                                    .sumiTextStyle(.label)
                                    .foregroundColor(.sumiQuaternaryText)
                                Spacer()
                                DayBadge(day: day)
                            }
                            
                            Text(passageText)
                                .sumiTextStyle(.passage)
                                .foregroundColor(.sumiPrimaryText)
                                .lineSpacing(8)
                        }
                        .padding(Space.lg)
                        .sumiCard(style: .elevated)
                        
                        // Dialogue Flow
                        VStack(alignment: .leading, spacing: Space.xl) {
                            // Socratic Prompt
                            DialogueCard(role: .prompt, text: aiPrompt)
                            
                            // User Reflection
                            DialogueCard(role: .user, text: userReflection)
                            
                            // AI Response
                            DialogueCard(role: .sage, text: aiResponse)
                        }
                    }
                    .padding(.horizontal, Space.screenEdge)
                    .padding(.vertical, Space.xxl)
                }
            }
            .navigationTitle("Day \(day)")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.sumiSecondaryText)
                            .frame(width: 32, height: 32)
                            .background(Color.sumiCardSurface)
                            .cornerRadius(Radius.lg)
                            .overlay(
                                RoundedRectangle(cornerRadius: Radius.lg)
                                    .stroke(Color.sumiBorder, lineWidth: 1)
                            )
                    }
                }
            }
        }
    }
}

enum DialogueRole {
    case prompt
    case user
    case sage
}

struct DialogueCard: View {
    let role: DialogueRole
    let text: String
    
    var body: some View {
        HStack(alignment: .top, spacing: Space.md) {
            // Avatar / Indicator
            ZStack {
                switch role {
                case .prompt:
                    Circle()
                        .fill(Color.sumiPersimmonMuted)
                        .frame(width: 36, height: 36)
                    Image(systemName: "questionmark")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.sumiPersimmon)
                case .user:
                    Circle()
                        .fill(Color.sumiCardSurfaceSecondary)
                        .frame(width: 36, height: 36)
                    Image(systemName: "person")
                        .font(.system(size: 14))
                        .foregroundColor(.sumiSecondaryText)
                case .sage:
                    Circle()
                        .fill(Color.sumiMatchaMuted)
                        .frame(width: 36, height: 36)
                    Image(systemName: "sparkles")
                        .font(.system(size: 14))
                        .foregroundColor(.sumiMatcha)
                }
            }
            
            VStack(alignment: .leading, spacing: Space.xs) {
                Text(roleLabel)
                    .sumiTextStyle(.caption)
                    .foregroundColor(roleColor)
                
                Text(text)
                    .sumiTextStyle(role == .sage ? .title3 : .bodyLarge)
                    .foregroundColor(.sumiPrimaryText)
                    .lineSpacing(6)
            }
            
            Spacer()
        }
        .padding(Space.lg)
        .background(roleBackground)
        .cornerRadius(Radius.xl)
        .overlay(
            RoundedRectangle(cornerRadius: Radius.xl)
                .stroke(role == .sage ? Color.sumiMatcha.opacity(0.15) : Color.clear, lineWidth: 1)
        )
    }
    
    var roleLabel: String {
        switch role {
        case .prompt: return "Socratic Prompt"
        case .user: return "Your Reflection"
        case .sage: return "Sage"
        }
    }
    
    var roleColor: Color {
        switch role {
        case .prompt: return .sumiPersimmon
        case .user: return .sumiTertiaryText
        case .sage: return .sumiMatcha
        }
    }
    
    var roleBackground: Color {
        switch role {
        case .prompt: return .sumiCardSurface
        case .user: return .sumiCardSurfaceSecondary
        case .sage: return .sumiCardSurface
        }
    }
}

struct DayBadge: View {
    let day: Int
    
    var body: some View {
        Text("Day \(day)")
            .sumiTextStyle(.caption)
            .foregroundColor(.sumiSecondaryText)
            .padding(.horizontal, Space.md)
            .padding(.vertical, Space.xs)
            .background(Color.sumiCardSurfaceSecondary)
            .cornerRadius(Radius.pill)
    }
}

#Preview {
    PathwayDayDetailView(day: 4)
}
