import SwiftUI

struct BrandMomentView: View {
    @State private var textOpacity: Double = 0
    @State private var strokeScale: CGFloat = 0.5
    @State private var strokeOpacity: Double = 0
    
    var onFinish: () -> Void
    
    var body: some View {
        ZStack {
            Color.washi.ignoresSafeArea()
            
            VStack(spacing: Space.lg) {
                // Mock ink stroke for the logo (Ensō)
                Circle()
                    .trim(from: 0.1, to: 0.9)
                    .stroke(Color.sumiInk, style: StrokeStyle(lineWidth: 12, lineCap: .round))
                    .frame(width: 80, height: 80)
                    .rotationEffect(.degrees(-90))
                    .scaleEffect(strokeScale)
                    .opacity(strokeOpacity)
                
                VStack(spacing: Space.sm) {
                    Text("SumiDay")
                        .font(.custom("New York", size: 34))
                        .fontWeight(.regular)
                        .foregroundColor(.sumiInk)
                        .tracking(-0.5)
                        
                    Text("One stroke a day.")
                        .font(.system(size: 15))
                        .foregroundColor(.sumi80)
                        .tracking(-0.2)
                }
                .opacity(textOpacity)
                .offset(y: textOpacity == 1 ? 0 : 10)
            }
        }
        .onAppear {
            // Ink splash animation
            withAnimation(.spring(dampingFraction: 0.7).speed(0.8)) {
                strokeScale = 1.0
                strokeOpacity = 1.0
            }
            
            // Text fade in
            withAnimation(.easeOut(duration: 0.8).delay(0.6)) {
                textOpacity = 1.0
            }
            
            // Auto transition to next screen after 3 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                onFinish()
            }
        }
    }
}

#Preview {
    BrandMomentView(onFinish: {})
}
