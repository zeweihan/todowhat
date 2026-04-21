import SwiftUI

struct SessionPassageView: View {
    @State private var textBlocksOpacity: [Double] = [0, 0, 0, 0]
    @State private var audioProgress: Double = 0.0
    
    // In a real app, this data is passed down
    let passageCitations = "The Gateless Gate, Case 4"
    let passageText = "Wakuan complained when he saw a picture of bearded Bodhidharma, 'Why hasn't that fellow a beard?'"
    let modernReading = "Why do we cling to labels and forms? The essence of what we are looking for has no specific shape."
    
    var onContinue: () -> Void
    
    var body: some View {
        ZStack {
            Color.washi.ignoresSafeArea()
            
            VStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: Space.lg) {
                        
                        Text(passageCitations)
                            .font(.custom("SF Mono", size: 13))
                            .foregroundColor(.sumi40)
                            .opacity(textBlocksOpacity[0])
                        
                        Text(passageText)
                            .font(.custom("New York", size: 20))
                            .lineSpacing(12) // 32pt total line height approx
                            .foregroundColor(.sumiInk)
                            .opacity(textBlocksOpacity[1])
                            .offset(y: textBlocksOpacity[1] == 1 ? 0 : 8)
                        
                        Divider().background(Color.sumi08)
                            .opacity(textBlocksOpacity[2])
                        
                        Text(modernReading)
                            .font(.system(size: 15))
                            .lineSpacing(7) // 22pt total line height approx
                            .foregroundColor(.sumi80)
                            .opacity(textBlocksOpacity[3])
                            .offset(y: textBlocksOpacity[3] == 1 ? 0 : 8)
                            
                    }
                    .padding(Space.lg)
                    // The text line lengths are restricted on iPad/Mac but fine on iPhone
                    .frame(maxWidth: 680, alignment: .leading)
                }
                
                // Audio Player & Continue Footer
                VStack(spacing: Space.md) {
                    HStack(spacing: Space.md) {
                        Button(action: {
                            // Toggle play/pause mock
                            withAnimation {
                                audioProgress = audioProgress > 0 ? 0 : 1.0
                            }
                        }) {
                            Image(systemName: audioProgress > 0 ? "pause.circle.fill" : "play.circle.fill")
                                .font(.system(size: 40))
                                .foregroundColor(.sumiInk)
                        }
                        
                        // Progress bar filling with matcha
                        GeometryReader { geometry in
                            ZStack(alignment: .leading) {
                                Capsule()
                                    .fill(Color.matchaLight)
                                    .frame(height: 4)
                                
                                Capsule()
                                    .fill(Color.matcha)
                                    .frame(width: geometry.size.width * CGFloat(audioProgress), height: 4)
                            }
                        }
                        .frame(height: 40)
                    }
                    
                    Button(action: onContinue) {
                        Text("Continue to Dialogue")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.washi)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(Color.persimmon)
                            .cornerRadius(14)
                    }
                }
                .padding(.horizontal, Space.lg)
                .padding(.bottom, Space.xl)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            // Ink wash reveal effect
            for (index, _) in textBlocksOpacity.enumerated() {
                withAnimation(.easeOut(duration: 0.6).delay(Double(index) * 0.15)) {
                    textBlocksOpacity[index] = 1.0
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        SessionPassageView(onContinue: {})
    }
}
