import SwiftUI

struct PurchaseIntroView: View {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    @State private var isPurchasing = false
    @State private var showContent = false
    
    let features = [
        (icon: "text.book.closed", title: "7 curated classic passages", subtitle: "From the Gateless Gate, selected for modern readers"),
        (icon: "headphones", title: "Immersive audio introductions", subtitle: "Narrated context to deepen your understanding"),
        (icon: "bubble.left.and.bubble.right", title: "AI-guided Socratic reflections", subtitle: "A patient dialogue partner for your insights")
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: Space.xxl) {
                    // Header
                    VStack(alignment: .leading, spacing: Space.xs) {
                        Text("Beginner's Mind")
                            .sumiTextStyle(.hero)
                            .foregroundColor(.sumiPrimaryText)
                        
                        Text("A 7-day introduction to Zen practice. One stroke a day to ground your mornings before the world rushes in.")
                            .sumiTextStyle(.body)
                            .foregroundColor(.sumiSecondaryText)
                            .lineSpacing(4)
                    }
                    .sumiEntrance(delay: 0)
                    
                    // Feature cards
                    VStack(spacing: Space.lg) {
                        ForEach(Array(features.enumerated()), id: \.offset) { index, feature in
                            FeatureCard(
                                icon: feature.icon,
                                title: feature.title,
                                subtitle: feature.subtitle,
                                index: index
                            )
                        }
                    }
                    
                    // Trust signals
                    HStack(spacing: Space.lg) {
                        TrustPill(icon: "checkmark.shield", text: "No subscription")
                        TrustPill(icon: "arrow.counterclockwise", text: "Lifetime access")
                    }
                    .sumiEntrance(delay: 0.4)
                }
                .padding(.horizontal, Space.screenEdge)
                .padding(.top, Space.xxxl)
                .padding(.bottom, Space.xl)
            }
            
            Spacer()
            
            // Bottom action area
            VStack(spacing: Space.md) {
                VStack(spacing: Space.xs) {
                    HStack(alignment: .firstTextBaseline, spacing: Space.xs) {
                        Text("$0.99")
                            .sumiTextStyle(.title2)
                            .foregroundColor(.sumiPrimaryText)
                        Text("one-time")
                            .sumiTextStyle(.subheadline)
                            .foregroundColor(.sumiTertiaryText)
                    }
                    
                    Text("No subscription. No ads. Just practice.")
                        .sumiTextStyle(.caption)
                        .foregroundColor(.sumiQuaternaryText)
                }
                
                Button(action: {
                    isPurchasing = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                        isPurchasing = false
                        hasCompletedOnboarding = true
                    }
                }) {
                    ZStack {
                        if isPurchasing {
                            ProgressView()
                                .tint(.washi)
                        } else {
                            Text("Purchase Intro")
                        }
                    }
                }
                .buttonStyle(SumiPrimaryButtonStyle())
                .disabled(isPurchasing)
                
                Button(action: { /* restore */ }) {
                    Text("Restore Purchases")
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

struct FeatureCard: View {
    let icon: String
    let title: String
    let subtitle: String
    let index: Int
    
    var body: some View {
        HStack(spacing: Space.lg) {
            ZStack {
                RoundedRectangle(cornerRadius: Radius.md)
                    .fill(Color.sumiMatchaMuted)
                    .frame(width: 48, height: 48)
                
                Image(systemName: icon)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.sumiMatcha)
            }
            
            VStack(alignment: .leading, spacing: Space.xxs) {
                Text(title)
                    .sumiTextStyle(.callout)
                    .foregroundColor(.sumiPrimaryText)
                
                Text(subtitle)
                    .sumiTextStyle(.caption)
                    .foregroundColor(.sumiTertiaryText)
                    .lineLimit(2)
            }
            
            Spacer()
        }
        .padding(Space.lg)
        .sumiCard(style: .default)
        .sumiStaggered(index: index, baseDelay: 0.2)
    }
}

struct TrustPill: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: Space.xs) {
            Image(systemName: icon)
                .font(.system(size: 12))
            Text(text)
                .sumiTextStyle(.caption)
        }
        .foregroundColor(.sumiSecondaryText)
        .padding(.horizontal, Space.md)
        .padding(.vertical, Space.sm)
        .background(Color.sumiCardSurface)
        .cornerRadius(Radius.pill)
        .overlay(
            Capsule()
                .stroke(Color.sumiBorder, lineWidth: 1)
        )
    }
}

#Preview {
    PurchaseIntroView()
}
