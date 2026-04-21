import SwiftUI

struct PurchaseIntroView: View {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    @State private var isPurchasing = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: Space.lg) {
            Text("Beginner's Mind")
                .font(.custom("New York", size: 34))
                .foregroundColor(.sumiInk)
                .padding(.top, Space.xl)
                .padding(.horizontal, Space.lg)
            
            Text("A 7-day introduction to Zen practice. One stroke a day to ground your mornings before the world rushes in.")
                .font(.system(size: 15))
                .foregroundColor(.sumi80)
                .lineSpacing(4)
                .padding(.horizontal, Space.lg)
            
            VStack(spacing: Space.md) {
                FeatureRow(icon: "sun.max", text: "7 curated classic passages")
                FeatureRow(icon: "headphones", text: "Immersive audio introductions")
                FeatureRow(icon: "sparkles", text: "AI-guided Socratic reflections")
            }
            .padding(.horizontal, Space.lg)
            .padding(.top, Space.md)
            
            Spacer()
            
            VStack(spacing: Space.sm) {
                // Subscription or path buyout details would connect here with StoreKit
                Text("$0.99 one-time purchase")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.sumi40)
                
                Button(action: {
                    isPurchasing = true
                    // Simulate a network request / StoreKit sheet then complete
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
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
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(.washi)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(Color.persimmon)
                    .cornerRadius(14)
                }
                .disabled(isPurchasing)
                
                Text("Restore Purchases")
                    .font(.system(size: 13))
                    .foregroundColor(.sumi80)
                    .padding(.top, Space.sm)
                    .onTapGesture {
                        // Handle restore
                    }
            }
            .padding(.horizontal, Space.lg)
            .padding(.bottom, Space.xl)
        }
        .background(Color.washi.ignoresSafeArea())
    }
}

struct FeatureRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: Space.md) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(.sumiInk)
                .frame(width: 24)
            
            Text(text)
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.sumi80)
            
            Spacer()
        }
    }
}

#Preview {
    PurchaseIntroView()
}
