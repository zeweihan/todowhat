import SwiftUI

struct SessionCompletionView: View {
    @State private var splashScale: CGFloat = 0.5
    @State private var splashOpacity: Double = 0
    @State private var textOpacity: Double = 0
    
    var onReturnHome: () -> Void
    
    var body: some View {
        ZStack {
            Color.washi.ignoresSafeArea()
            
            VStack(spacing: Space.section) {
                // Ink Splash Celebration
                ZStack {
                    Circle()
                        .fill(Color.persimmon)
                        .frame(width: 120, height: 120)
                        .scaleEffect(splashScale)
                        .opacity(splashOpacity)
                    
                    Image(systemName: "checkmark")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.washi)
                        .scaleEffect(splashScale)
                        .opacity(splashOpacity)
                }
                
                VStack(spacing: Space.md) {
                    Text("Day 4 Completed")
                        .font(.custom("New York", size: 34))
                        .foregroundColor(.sumiInk)
                    
                    VStack(spacing: 4) {
                        Text("13")
                            .font(.custom("SF Mono", size: 28))
                            .foregroundColor(.persimmon)
                        Text("DAY STREAK")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(.sumi40)
                    }
                }
                .opacity(textOpacity)
                .offset(y: textOpacity == 1 ? 0 : 20)
            }
            
            VStack {
                Spacer()
                Button(action: onReturnHome) {
                    Text("Return to Journey")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.washi)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(Color.persimmon)
                        .cornerRadius(14)
                }
                .padding(.horizontal, Space.lg)
                .padding(.bottom, Space.xl)
            }
            .opacity(textOpacity)
        }
        .onAppear {
            withAnimation(.spring(dampingFraction: 0.5).speed(0.8)) {
                splashScale = 1.0
                splashOpacity = 1.0
            }
            withAnimation(.easeOut(duration: 0.8).delay(0.4)) {
                textOpacity = 1.0
            }
            
            // Haptic trigger
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
        }
    }
}

#Preview {
    SessionCompletionView(onReturnHome: {})
}
