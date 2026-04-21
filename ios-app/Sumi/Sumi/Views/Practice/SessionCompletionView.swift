import SwiftUI

struct SessionCompletionView: View {
    @State private var splashScale: CGFloat = 0.3
    @State private var splashOpacity: Double = 0
    @State private var ringScale: CGFloat = 0.5
    @State private var textOpacity: Double = 0
    @State private var statsOffset: CGFloat = 30
    
    var onReturnHome: () -> Void
    
    var body: some View {
        ZStack {
            Color.sumiBackground.ignoresSafeArea()
            
            // Background ink wash effect
            Circle()
                .fill(Color.sumiPersimmon.opacity(0.04))
                .frame(width: 400, height: 400)
                .scaleEffect(ringScale)
                .blur(radius: 40)
            
            VStack(spacing: Space.sectionLarge) {
                // Ink Splash Celebration
                ZStack {
                    // Expanding ring
                    Circle()
                        .stroke(Color.sumiPersimmon.opacity(0.2), lineWidth: 2)
                        .frame(width: 140, height: 140)
                        .scaleEffect(ringScale)
                    
                    // Core splash
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [Color.sumiPersimmon, Color.sumiPersimmon.opacity(0.8)],
                                center: .center,
                                startRadius: 0,
                                endRadius: 60
                            )
                        )
                        .frame(width: 100, height: 100)
                        .sumiShadow(SumiShadow.large)
                    
                    Image(systemName: "checkmark")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(.washi)
                }
                .scaleEffect(splashScale)
                .opacity(splashOpacity)
                
                // Completion text
                VStack(spacing: Space.md) {
                    Text("Day 4 Completed")
                        .sumiTextStyle(.hero)
                        .foregroundColor(.sumiPrimaryText)
                    
                    Text("Your practice has been recorded")
                        .sumiTextStyle(.body)
                        .foregroundColor(.sumiSecondaryText)
                }
                .opacity(textOpacity)
                .offset(y: textOpacity == 1 ? 0 : 16)
                
                // Stats cards
                HStack(spacing: Space.lg) {
                    StatCard(
                        value: "13",
                        label: "Day Streak",
                        icon: "flame.fill",
                        color: .sumiPersimmon
                    )
                    
                    StatCard(
                        value: "4",
                        label: "Cases Read",
                        icon: "book.closed.fill",
                        color: .sumiMatcha
                    )
                }
                .padding(.horizontal, Space.screenEdge)
                .opacity(textOpacity)
                .offset(y: statsOffset)
            }
            
            VStack {
                Spacer()
                Button(action: onReturnHome) {
                    Text("Return to Journey")
                }
                .buttonStyle(SumiPrimaryButtonStyle())
                .padding(.horizontal, Space.screenEdge)
                .padding(.bottom, Space.xxl)
                .opacity(textOpacity)
            }
        }
        .onAppear {
            // Haptic
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
            
            withAnimation(.spring(response: 0.6, dampingFraction: 0.5)) {
                splashScale = 1.0
                splashOpacity = 1.0
            }
            
            withAnimation(.easeOut(duration: 1.0).delay(0.2)) {
                ringScale = 2.0
            }
            
            withAnimation(.easeOut(duration: 0.8).delay(0.4)) {
                textOpacity = 1.0
            }
            
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8).delay(0.5)) {
                statsOffset = 0
            }
        }
    }
}

struct StatCard: View {
    let value: String
    let label: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: Space.sm) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(color)
            
            Text(value)
                .sumiTextStyle(.title2)
                .foregroundColor(.sumiPrimaryText)
            
            Text(label)
                .sumiTextStyle(.caption)
                .foregroundColor(.sumiTertiaryText)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, Space.xl)
        .sumiCard(style: .filled)
    }
}

#Preview {
    SessionCompletionView(onReturnHome: {})
}
