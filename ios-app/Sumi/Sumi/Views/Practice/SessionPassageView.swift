import SwiftUI

struct SessionPassageView: View {
    @State private var textBlocksOpacity: [Double] = [0, 0, 0, 0]
    @State private var audioProgress: Double = 0.0
    @State private var isPlaying = false
    
    let passageCitations = "The Gateless Gate, Case 4"
    let passageText = "Wakuan complained when he saw a picture of bearded Bodhidharma, 'Why hasn't that fellow a beard?'"
    let modernReading = "Why do we cling to labels and forms? The essence of what we are looking for has no specific shape."
    
    var onContinue: () -> Void
    
    var body: some View {
        ZStack {
            Color.sumiBackground.ignoresSafeArea()
            
            VStack(spacing: 0) {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: Space.xxl) {
                        // Citation
                        Text(passageCitations.uppercased())
                            .sumiTextStyle(.label)
                            .foregroundColor(.sumiQuaternaryText)
                            .opacity(textBlocksOpacity[0])
                        
                        // Passage text
                        Text(passageText)
                            .sumiTextStyle(.passage)
                            .foregroundColor(.sumiPrimaryText)
                            .lineSpacing(10)
                            .opacity(textBlocksOpacity[1])
                            .offset(y: textBlocksOpacity[1] == 1 ? 0 : 10)
                        
                        // Divider with ornament
                        HStack(spacing: Space.md) {
                            SumiDivider()
                            Image(systemName: "circle.fill")
                                .font(.system(size: 4))
                                .foregroundColor(.sumiDivider)
                            SumiDivider()
                        }
                        .opacity(textBlocksOpacity[2])
                        
                        // Modern reading
                        VStack(alignment: .leading, spacing: Space.md) {
                            Text("Modern Reading")
                                .sumiTextStyle(.label)
                                .foregroundColor(.sumiQuaternaryText)
                            
                            Text(modernReading)
                                .sumiTextStyle(.bodyLarge)
                                .foregroundColor(.sumiSecondaryText)
                                .lineSpacing(6)
                        }
                        .opacity(textBlocksOpacity[3])
                        .offset(y: textBlocksOpacity[3] == 1 ? 0 : 10)
                    }
                    .padding(.horizontal, Space.screenEdge)
                    .padding(.top, Space.xxl)
                    .padding(.bottom, Space.xxl)
                    .frame(maxWidth: 680, alignment: .leading)
                }
                
                // Audio Player & Continue Footer
                VStack(spacing: Space.lg) {
                    // Audio player bar
                    HStack(spacing: Space.lg) {
                        Button(action: {
                            isPlaying.toggle()
                            withAnimation(.easeInOut(duration: 0.3)) {
                                audioProgress = isPlaying ? 0.3 : 0.0
                            }
                        }) {
                            ZStack {
                                Circle()
                                    .fill(Color.sumiCardSurface)
                                    .frame(width: 48, height: 48)
                                    .overlay(
                                        Circle()
                                            .stroke(Color.sumiBorder, lineWidth: 1)
                                    )
                                
                                Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.sumiPrimaryText)
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: Space.sm) {
                            Text(isPlaying ? "Playing audio introduction..." : "Audio introduction")
                                .sumiTextStyle(.caption)
                                .foregroundColor(.sumiTertiaryText)
                            
                            GeometryReader { geometry in
                                ZStack(alignment: .leading) {
                                    Capsule()
                                        .fill(Color.sumiSand.opacity(0.3))
                                        .frame(height: 3)
                                    
                                    Capsule()
                                        .fill(Color.sumiPersimmon)
                                        .frame(width: geometry.size.width * CGFloat(audioProgress), height: 3)
                                }
                            }
                            .frame(height: 3)
                        }
                        
                        Text("3:24")
                            .sumiTextStyle(.caption)
                            .foregroundColor(.sumiTertiaryText)
                            .monospacedDigit()
                    }
                    .padding(Space.lg)
                    .sumiCard(style: .filled)
                    
                    Button(action: onContinue) {
                        HStack(spacing: Space.sm) {
                            Text("Continue to Dialogue")
                            Image(systemName: "arrow.right")
                        }
                    }
                    .buttonStyle(SumiPrimaryButtonStyle())
                }
                .padding(.horizontal, Space.screenEdge)
                .padding(.bottom, Space.xxl)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            for (index, _) in textBlocksOpacity.enumerated() {
                withAnimation(.easeOut(duration: 0.7).delay(Double(index) * 0.2)) {
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
