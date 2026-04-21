import SwiftUI

struct BrandMomentView: View {
    @State private var textOpacity: Double = 0
    @State private var strokeScale: CGFloat = 0.6
    @State private var strokeOpacity: Double = 0
    @State private var glowOpacity: Double = 0
    
    var onFinish: () -> Void
    
    var body: some View {
        ZStack {
            Color.sumiBackground.ignoresSafeArea()
            
            VStack(spacing: Space.xxl) {
                ZStack {
                    // Soft glow behind the Ensō
                    Circle()
                        .fill(Color.sumiPersimmon.opacity(0.08))
                        .frame(width: 140, height: 140)
                        .scaleEffect(strokeScale)
                        .opacity(glowOpacity)
                    
                    // Ink stroke — Ensō
                    Circle()
                        .trim(from: 0.05, to: 0.95)
                        .stroke(
                            Color.sumiInk,
                            style: StrokeStyle(lineWidth: 10, lineCap: .round)
                        )
                        .frame(width: 88, height: 88)
                        .rotationEffect(.degrees(-90))
                        .scaleEffect(strokeScale)
                        .opacity(strokeOpacity)
                }
                
                VStack(spacing: Space.sm) {
                    Text("SumiDay")
                        .sumiTextStyle(.hero)
                        .foregroundColor(.sumiPrimaryText)
                    
                    Text("One stroke a day")
                        .sumiTextStyle(.body)
                        .foregroundColor(.sumiSecondaryText)
                }
                .opacity(textOpacity)
                .offset(y: textOpacity == 1 ? 0 : 12)
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.7)) {
                strokeScale = 1.0
                strokeOpacity = 1.0
            }
            withAnimation(.easeOut(duration: 1.0).delay(0.3)) {
                glowOpacity = 1.0
            }
            withAnimation(.easeOut(duration: 0.8).delay(0.6)) {
                textOpacity = 1.0
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.8) {
                onFinish()
            }
        }
    }
}

#Preview {
    BrandMomentView(onFinish: {})
}
