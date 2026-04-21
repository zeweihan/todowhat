import SwiftUI

struct SessionDialogueView: View {
    @State private var reflectionText: String = ""
    @State private var showAIResponse = false
    @State private var textOpacity: Double = 0
    
    let aiPrompt = "If Bodhidharma has no beard, what face is he showing the world right now?"
    let mockAIResponse = "To seek the beard is to miss the face. To seek the face is to miss the man. Sit with the question itself."
    
    var onFinish: () -> Void
    
    var body: some View {
        ZStack {
            Color.sumiBackground.ignoresSafeArea()
            
            VStack(spacing: 0) {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: Space.xxl) {
                        // Prompt Card
                        VStack(alignment: .leading, spacing: Space.lg) {
                            HStack(spacing: Space.sm) {
                                Image(systemName: "quote.opening")
                                    .font(.system(size: 14))
                                    .foregroundColor(.sumiPersimmon)
                                Text("Socratic Prompt")
                                    .sumiTextStyle(.label)
                                    .foregroundColor(.sumiPersimmon)
                            }
                            
                            Text(aiPrompt)
                                .sumiTextStyle(.title3)
                                .foregroundColor(.sumiPrimaryText)
                                .lineSpacing(8)
                        }
                        .padding(Space.lg)
                        .sumiCard(style: .filled)
                        .opacity(textOpacity)
                        
                        // User Reflection
                        if !showAIResponse {
                            VStack(alignment: .leading, spacing: Space.md) {
                                Text("Your Reflection")
                                    .sumiTextStyle(.label)
                                    .foregroundColor(.sumiTertiaryText)
                                
                                TextEditor(text: $reflectionText)
                                    .sumiTextStyle(.bodyLarge)
                                    .foregroundColor(.sumiPrimaryText)
                                    .scrollContentBackground(.hidden)
                                    .frame(minHeight: 120, maxHeight: 200)
                                    .padding(Space.md)
                                    .background(Color.sumiCardSurfaceSecondary)
                                    .cornerRadius(Radius.lg)
                            }
                            .opacity(textOpacity)
                        } else {
                            // Submitted reflection
                            VStack(alignment: .leading, spacing: Space.md) {
                                HStack(spacing: Space.sm) {
                                    Image(systemName: "person.fill")
                                        .font(.system(size: 12))
                                        .foregroundColor(.sumiTertiaryText)
                                    Text("Your Reflection")
                                        .sumiTextStyle(.caption)
                                        .foregroundColor(.sumiTertiaryText)
                                }
                                
                                Text(reflectionText)
                                    .sumiTextStyle(.bodyLarge)
                                    .foregroundColor(.sumiSecondaryText)
                                    .lineSpacing(6)
                                    .padding(.leading, Space.lg)
                                    .overlay(
                                        Rectangle()
                                            .fill(Color.sumiPersimmon.opacity(0.2))
                                            .frame(width: 3),
                                        alignment: .leading
                                    )
                            }
                            .padding(Space.lg)
                            .sumiCard(style: .default)
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                        }
                        
                        // AI Response
                        if showAIResponse {
                            VStack(alignment: .leading, spacing: Space.lg) {
                                HStack(spacing: Space.sm) {
                                    Image(systemName: "sparkles")
                                        .font(.system(size: 12))
                                        .foregroundColor(.sumiMatcha)
                                    Text("Sage")
                                        .sumiTextStyle(.caption)
                                        .foregroundColor(.sumiMatcha)
                                }
                                
                                Text(mockAIResponse)
                                    .sumiTextStyle(.title3)
                                    .foregroundColor(.sumiPrimaryText)
                                    .lineSpacing(8)
                            }
                            .padding(Space.lg)
                            .sumiCard(style: .elevated)
                            .overlay(
                                RoundedRectangle(cornerRadius: Radius.xl)
                                    .stroke(Color.sumiMatcha.opacity(0.12), lineWidth: 1)
                            )
                            .transition(.move(edge: .bottom).combined(with: .opacity))
                        }
                        
                        Spacer(minLength: Space.xxl)
                    }
                    .padding(.horizontal, Space.screenEdge)
                    .padding(.top, Space.xxl)
                }
                
                // Footer
                VStack(spacing: Space.lg) {
                    if !showAIResponse {
                        Button(action: {
                            withAnimation(.spring(response: 0.55, dampingFraction: 0.8)) {
                                showAIResponse = true
                            }
                        }) {
                            Text("Submit Reflection")
                        }
                        .buttonStyle(SumiPrimaryButtonStyle())
                        .disabled(reflectionText.isEmpty)
                        .opacity(reflectionText.isEmpty ? 0.5 : 1.0)
                    } else {
                        Button(action: onFinish) {
                            HStack(spacing: Space.sm) {
                                Text("Complete Session")
                                Image(systemName: "checkmark")
                            }
                        }
                        .buttonStyle(SumiPrimaryButtonStyle())
                    }
                }
                .padding(.horizontal, Space.screenEdge)
                .padding(.bottom, Space.xxl)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            withAnimation(.easeOut(duration: 0.6)) {
                textOpacity = 1.0
            }
        }
    }
}

#Preview {
    NavigationStack {
        SessionDialogueView(onFinish: {})
    }
}
