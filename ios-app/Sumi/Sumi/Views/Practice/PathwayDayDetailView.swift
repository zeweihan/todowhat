import SwiftUI

struct PathwayDayDetailView: View {
    let day: Int
    @Environment(\.dismiss) private var dismiss
    
    // In a real app, you would fetch this by the specific `day` parameter
    let passageCitations = "The Gateless Gate, Case 4"
    let passageText = "Wakuan complained when he saw a picture of bearded Bodhidharma, 'Why hasn't that fellow a beard?'"
    let aiPrompt = "If Bodhidharma has no beard, what face is he showing the world right now?"
    let userReflection = "I struggled with this one. I think it means that the true essence of someone doesn't exist in their physical appearance or the labels we put on them."
    let aiResponse = "To seek the beard is to miss the face. To seek the face is to miss the man. Sit with the question itself."
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.washi.ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: Space.xl) {
                        
                        // Passage Review
                        VStack(alignment: .leading, spacing: Space.sm) {
                            Text(passageCitations)
                                .font(.custom("SF Mono", size: 13))
                                .foregroundColor(.sumi40)
                            
                            Text(passageText)
                                .font(.custom("New York", size: 20))
                                .lineSpacing(8)
                                .foregroundColor(.sumiInk)
                        }
                        
                        Divider().background(Color.sumi08)
                        
                        // Reflection Log
                        VStack(alignment: .leading, spacing: Space.lg) {
                            
                            // Socratic Prompt
                            HStack(alignment: .top, spacing: Space.sm) {
                                Image(systemName: "questionmark.bubble")
                                    .foregroundColor(.sumi40)
                                    .padding(.top, 4)
                                
                                Text(aiPrompt)
                                    .font(.custom("New York", size: 18))
                                    .lineSpacing(8)
                                    .foregroundColor(.sumiInk)
                            }
                            
                            // User
                            Text(userReflection)
                                .font(.system(size: 15))
                                .foregroundColor(.sumi80)
                                .padding(.leading, Space.xl)
                                .overlay(
                                    Rectangle()
                                        .fill(Color.sumi08)
                                        .frame(width: 2),
                                    alignment: .leading
                                )
                            
                            // AI
                            VStack(alignment: .leading, spacing: Space.sm) {
                                Text("Sage")
                                    .font(.custom("SF Mono", size: 11))
                                    .foregroundColor(.sumi40)
                                
                                Text(aiResponse)
                                    .font(.custom("New York", size: 18))
                                    .lineSpacing(8)
                                    .foregroundColor(.sumiInk)
                            }
                            .padding(.leading, Space.xl)
                        }
                    }
                    .padding(Space.lg)
                }
            }
            .navigationTitle("Day \(day) Record")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Close") {
                        dismiss()
                    }
                    .foregroundColor(.sumiInk)
                }
            }
        }
    }
}

#Preview {
    PathwayDayDetailView(day: 4)
}
