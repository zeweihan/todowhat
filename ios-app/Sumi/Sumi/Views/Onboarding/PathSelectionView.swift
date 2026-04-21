import SwiftUI

struct PathSelectionView: View {
    var onContinue: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: Space.xs) {
                Text("Choose your path")
                    .sumiTextStyle(.hero)
                    .foregroundColor(.sumiPrimaryText)
                
                Text("Select a tradition to begin your practice")
                    .sumiTextStyle(.body)
                    .foregroundColor(.sumiSecondaryText)
            }
            .padding(.horizontal, Space.screenEdge)
            .padding(.top, Space.xxxl)
            .padding(.bottom, Space.xxl)
            .sumiEntrance(delay: 0)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: Space.lg) {
                    PathCard(
                        title: "Zen",
                        subtitle: "The Gateless Gate",
                        description: "Thirty koans from the classic Chinese Zen tradition. Direct, paradoxical, and quietly revolutionary.",
                        isAvailable: true,
                        icon: "leaf",
                        index: 0
                    )
                    
                    PathCard(
                        title: "Tao",
                        subtitle: "Coming Soon",
                        description: "The Tao Te Ching reimagined as a daily meditation on effortless action.",
                        isAvailable: false,
                        icon: "water.waves",
                        index: 1
                    )
                    
                    PathCard(
                        title: "Analects",
                        subtitle: "Coming Soon",
                        description: "Confucian reflections on virtue, relationships, and social harmony.",
                        isAvailable: false,
                        icon: "scroll",
                        index: 2
                    )
                    
                    PathCard(
                        title: "Stoic",
                        subtitle: "Coming Soon",
                        description: "Marcus Aurelius and Epictetus for clarity in chaotic times.",
                        isAvailable: false,
                        icon: "building.columns",
                        index: 3
                    )
                }
                .padding(.horizontal, Space.screenEdge)
                .padding(.bottom, Space.xl)
            }
            
            VStack(spacing: Space.md) {
                Button(action: onContinue) {
                    Text("Begin with Zen")
                }
                .buttonStyle(SumiPrimaryButtonStyle())
                
                Button(action: { /* help me choose */ }) {
                    Text("Help me choose")
                }
                .buttonStyle(SumiGhostButtonStyle())
            }
            .padding(.horizontal, Space.screenEdge)
            .padding(.bottom, Space.xxl)
            .sumiEntrance(delay: 0.3)
        }
        .sumiPageBackground()
    }
}

struct PathCard: View {
    let title: String
    let subtitle: String
    let description: String
    let isAvailable: Bool
    let icon: String
    let index: Int
    
    var body: some View {
        HStack(spacing: Space.lg) {
            ZStack {
                Circle()
                    .fill(isAvailable ? Color.sumiMatchaMuted : Color.sumiCardSurfaceSecondary)
                    .frame(width: 52, height: 52)
                
                Image(systemName: icon)
                    .font(.system(size: 22, weight: .light))
                    .foregroundColor(isAvailable ? Color.sumiMatcha : Color.sumiTertiaryText)
            }
            
            VStack(alignment: .leading, spacing: Space.xs) {
                HStack(spacing: Space.sm) {
                    Text(title)
                        .sumiTextStyle(.cardTitle)
                        .foregroundColor(isAvailable ? .sumiPrimaryText : .sumiTertiaryText)
                    
                    if !isAvailable {
                        Text("Soon")
                            .sumiTextStyle(.caption2)
                            .foregroundColor(.sumiQuaternaryText)
                            .padding(.horizontal, Space.sm)
                            .padding(.vertical, Space.xxs)
                            .background(Color.sumiCardSurfaceSecondary)
                            .cornerRadius(Radius.pill)
                    }
                }
                
                Text(subtitle)
                    .sumiTextStyle(.subheadline)
                    .foregroundColor(isAvailable ? .sumiSecondaryText : .sumiQuaternaryText)
                
                if isAvailable {
                    Text(description)
                        .sumiTextStyle(.caption)
                        .foregroundColor(.sumiTertiaryText)
                        .lineLimit(2)
                        .padding(.top, Space.xxs)
                }
            }
            
            Spacer()
            
            Image(systemName: isAvailable ? "checkmark.circle.fill" : "lock.fill")
                .font(.system(size: 22))
                .foregroundColor(isAvailable ? .sumiMatcha : .sumiSand)
        }
        .padding(Space.lg)
        .sumiCard(style: isAvailable ? .elevated : .filled)
        .sumiSelectionRing(isSelected: isAvailable)
        .opacity(isAvailable ? 1.0 : 0.65)
        .sumiStaggered(index: index, baseDelay: 0.15)
    }
}

#Preview {
    PathSelectionView(onContinue: {})
}
