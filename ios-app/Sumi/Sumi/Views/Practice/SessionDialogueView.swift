import SwiftUI

struct SessionDialogueView: View {
    @State private var reflectionText: String = ""
    @State private var showAIResponse = false
    @State private var isPulsing = false
    
    // In a real app, this data is passed down
    let aiPrompt = "If Bodhidharma has no beard, what face is he showing the world right now?"
    let mockAIResponse = "To seek the beard is to miss the face. To seek the face is to miss the man. Sit with the question itself."
    
    var onFinish: () -> Void
    
    var body: some View {
        ZStack {
            Color.washi.ignoresSafeArea()
            
            VStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: Space.lg) {
                        
                        // Socratic Prompt
                        HStack(alignment: .top, spacing: Space.sm) {
                            Image(systemName: "questionmark.bubble")
                                .foregroundColor(.sumi40)
                                .padding(.top, 4)
                            
                            Text(aiPrompt)
                                .font(.custom("New York", size: 20))
                                .lineSpacing(12)
                                .foregroundColor(.sumiInk)
                        }
                        
                        // User Reflection
                        if !showAIResponse {
                            TextField("Your reflection...", text: $reflectionText, axis: .vertical)
                                .font(.system(size: 15))
                                .foregroundColor(.sumiInk)
                                .lineLimit(5...10)
                                .padding()
                                .background(Color.washiDark.opacity(0.05))
                                .cornerRadius(12)
                        } else {
                            Text(reflectionText)
                                .font(.system(size: 15))
                                .foregroundColor(.sumi80)
                                .padding(.leading, Space.xl)
                                .overlay(
                                    Rectangle()
                                        .fill(Color.sumi08)
                                        .frame(width: 2),
                                    alignment: .leading
                                )
                        }
                        
                        // AI Response
                        if showAIResponse {
                            VStack(alignment: .leading, spacing: Space.md) {
                                Divider().background(Color.sumi08)
                                
                                Text(mockAIResponse)
                                    .font(.custom("New York", size: 20))
                                    .lineSpacing(12)
                                    .foregroundColor(.sumiInk)
                                    .transition(.opacity) // 900ms deliberate fade occurs via the animation block
                            }
                        } else if !reflectionText.isEmpty && showAIResponse == false {
                            // Waiting pulse dot before submit goes through
                            // In real app, this triggers during SSE network fetch
                        }
                    }
                    .padding(Space.lg)
                }
                
                // Footer
                VStack(spacing: Space.sm) {
                    if !showAIResponse {
                        Button(action: {
                            // Submitting logic
                            withAnimation(.spring(dampingFraction: 0.7).speed(0.5)) {
                                showAIResponse = true
                            }
                        }) {
                            Text("Submit Reflection")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(.washi)
                                .frame(maxWidth: .infinity)
                                .frame(height: 56)
                                .background(reflectionText.isEmpty ? Color.sumi08 : Color.persimmon)
                                .cornerRadius(14)
                        }
                        .disabled(reflectionText.isEmpty)
                    } else {
                        Button(action: onFinish) {
                            Text("Complete Session")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(.washi)
                                .frame(maxWidth: .infinity)
                                .frame(height: 56)
                                .background(Color.persimmon)
                                .cornerRadius(14)
                        }
                    }
                }
                .padding(.horizontal, Space.lg)
                .padding(.bottom, Space.xl)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        SessionDialogueView(onFinish: {})
    }
}
