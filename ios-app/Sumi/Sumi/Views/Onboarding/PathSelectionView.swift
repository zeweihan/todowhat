import SwiftUI

struct PathSelectionView: View {
    var onContinue: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: Space.lg) {
            Text("Choose your path")
                .font(.custom("New York", size: 34))
                .foregroundColor(.sumiInk)
                .padding(.top, Space.xl)
                .padding(.horizontal, Space.lg)
            
            ScrollView {
                VStack(spacing: Space.md) {
                    PathCard(
                        title: "Zen",
                        subtitle: "The Gateless Gate",
                        isAvailable: true,
                        icon: "leaf"
                    )
                    
                    PathCard(title: "Tao", subtitle: "Coming Soon", isAvailable: false, icon: "water.waves")
                    PathCard(title: "Analects", subtitle: "Coming Soon", isAvailable: false, icon: "scroll")
                    PathCard(title: "Stoic", subtitle: "Coming Soon", isAvailable: false, icon: "building.columns")
                }
                .padding(.horizontal, Space.lg)
            }
            
            VStack(spacing: Space.sm) {
                Button(action: {
                    // MVP: trigger the mock help flow or just auto-select Zen
                }) {
                    Text("Help me choose")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(.sumi80)
                }
                .padding(.bottom, Space.xs)
                
                Button(action: onContinue) {
                    Text("Begin with Zen")
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
        .background(Color.washi.ignoresSafeArea())
    }
}

struct PathCard: View {
    let title: String
    let subtitle: String
    let isAvailable: Bool
    let icon: String
    
    var body: some View {
        HStack(spacing: Space.md) {
            Image(systemName: icon)
                .font(.system(size: 24, weight: .light))
                .foregroundColor(isAvailable ? .sumiInk : .sumi40)
                .frame(width: 32)
            
            VStack(alignment: .leading, spacing: Space.xs) {
                Text(title)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(isAvailable ? .sumiInk : .sumi40)
                
                Text(subtitle)
                    .font(.system(size: 13))
                    .foregroundColor(isAvailable ? .sumi80 : .sumi40)
            }
            
            Spacer()
            
            if !isAvailable {
                Image(systemName: "lock")
                    .foregroundColor(.sumi40)
            } else {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.matcha)
            }
        }
        .padding(Space.lg)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(isAvailable ? Color.matcha : Color.clear, lineWidth: 2)
        )
    }
}

#Preview {
    PathSelectionView(onContinue: {})
}
