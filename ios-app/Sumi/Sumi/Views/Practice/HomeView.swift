import SwiftUI

struct HomeView: View {
    @State private var showingPathSelection = false
    @State private var showContent = false
    
    let currentPathTitle = "Zen: The Gateless Gate"
    let currentDay = 4
    let totalDays = 30
    let currentStreak = 12
    let practitionerLevel = "APPRENTICE"
    
    var onStartSession: () -> Void
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.sumiBackground.ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: Space.section) {
                        // Custom Header
                        HStack {
                            VStack(alignment: .leading, spacing: Space.xxs) {
                                Text(greeting())
                                    .sumiTextStyle(.subheadline)
                                    .foregroundColor(.sumiTertiaryText)
                                Text("Today")
                                    .sumiTextStyle(.title2)
                                    .foregroundColor(.sumiPrimaryText)
                            }
                            
                            Spacer()
                            
                            NavigationLink(destination: SettingsView()) {
                                Image(systemName: "gearshape")
                                    .font(.system(size: 18, weight: .medium))
                                    .foregroundColor(.sumiPrimaryText)
                                    .frame(width: 40, height: 40)
                                    .background(Color.sumiCardSurface)
                                    .cornerRadius(Radius.lg)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: Radius.lg)
                                            .stroke(Color.sumiBorder, lineWidth: 1)
                                    )
                            }
                        }
                        .padding(.horizontal, Space.screenEdge)
                        .padding(.top, Space.md)
                        
                        // Stats Row
                        HStack(spacing: Space.md) {
                            StreakPill(streak: currentStreak)
                            LevelPill(level: practitionerLevel)
                            Spacer()
                        }
                        .padding(.horizontal, Space.screenEdge)
                        .sumiEntrance(delay: 0.1)
                        
                        // Path context
                        VStack(spacing: Space.sm) {
                            Button(action: { showingPathSelection = true }) {
                                HStack(spacing: Space.xs) {
                                    Text(currentPathTitle)
                                        .sumiTextStyle(.callout)
                                        .foregroundColor(.sumiSecondaryText)
                                    Image(systemName: "chevron.up.chevron.down")
                                        .font(.system(size: 10, weight: .semibold))
                                        .foregroundColor(.sumiTertiaryText)
                                }
                            }
                            .buttonStyle(SumiGhostButtonStyle())
                            
                            Text("Day \(currentDay) of \(totalDays)")
                                .sumiTextStyle(.largeTitle)
                                .foregroundColor(.sumiPrimaryText)
                            
                            // Progress bar
                            GeometryReader { geo in
                                ZStack(alignment: .leading) {
                                    Capsule()
                                        .fill(Color.sumiSand.opacity(0.4))
                                        .frame(height: 4)
                                    
                                    Capsule()
                                        .fill(Color.sumiPersimmon)
                                        .frame(width: geo.size.width * CGFloat(currentDay) / CGFloat(totalDays), height: 4)
                                }
                            }
                            .frame(height: 4)
                            .padding(.horizontal, Space.screenEdge)
                            .padding(.top, Space.sm)
                        }
                        .sumiEntrance(delay: 0.15)
                        
                        // Today's Passage Card
                        Button(action: onStartSession) {
                            PassagePreviewCard(day: currentDay)
                        }
                        .buttonStyle(SumiScaleButtonStyle())
                        .padding(.horizontal, Space.screenEdge)
                        .sumiEntrance(delay: 0.25)
                        
                        // Recent reflections teaser (if any)
                        if currentStreak > 0 {
                            VStack(alignment: .leading, spacing: Space.md) {
                                Text("Recent Insights")
                                    .sumiTextStyle(.label)
                                    .foregroundColor(.sumiTertiaryText)
                                    .padding(.horizontal, Space.screenEdge)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: Space.md) {
                                        InsightCard(
                                            day: 3,
                                            excerpt: "To seek the beard is to miss the face...",
                                            date: "Yesterday"
                                        )
                                        InsightCard(
                                            day: 2,
                                            excerpt: "The mind is like a mirror...",
                                            date: "2 days ago"
                                        )
                                    }
                                    .padding(.horizontal, Space.screenEdge)
                                }
                            }
                            .sumiEntrance(delay: 0.35)
                        }
                        
                        Spacer(minLength: Space.xxl)
                    }
                }
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $showingPathSelection) {
                PathSelectionView {
                    showingPathSelection = false
                }
            }
        }
    }
    
    func greeting() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 5..<12: return "Good morning"
        case 12..<17: return "Good afternoon"
        case 17..<22: return "Good evening"
        default: return "Good night"
        }
    }
}

struct StreakPill: View {
    let streak: Int
    
    var body: some View {
        HStack(spacing: Space.xs) {
            Image(systemName: streak > 0 ? "flame.fill" : "flame")
                .font(.system(size: 14))
                .foregroundColor(streak > 0 ? .sumiPersimmon : .sumiTertiaryText)
            
            Text("\(streak)")
                .sumiTextStyle(.callout)
                .foregroundColor(.sumiPrimaryText)
        }
        .padding(.horizontal, Space.md)
        .padding(.vertical, Space.sm)
        .background(Color.sumiCardSurface)
        .cornerRadius(Radius.pill)
        .overlay(
            Capsule()
                .stroke(Color.sumiBorder, lineWidth: 1)
        )
    }
}

struct LevelPill: View {
    let level: String
    
    var body: some View {
        HStack(spacing: Space.xs) {
            Image(systemName: "seal.fill")
                .font(.system(size: 12))
                .foregroundColor(.sumiMatcha)
            
            Text(level)
                .sumiTextStyle(.caption)
                .foregroundColor(.sumiMatcha)
        }
        .padding(.horizontal, Space.md)
        .padding(.vertical, Space.sm)
        .background(Color.sumiMatchaMuted)
        .cornerRadius(Radius.pill)
    }
}

struct PassagePreviewCard: View {
    let day: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: Space.lg) {
            HStack {
                VStack(alignment: .leading, spacing: Space.xxs) {
                    Text("CASE \(day)")
                        .sumiTextStyle(.label)
                        .foregroundColor(.sumiQuaternaryText)
                    
                    Text("Bodhidharma's Empty Hands")
                        .sumiTextStyle(.title2)
                        .foregroundColor(.sumiPrimaryText)
                        .lineLimit(2)
                }
                
                Spacer()
                
                // Decorative day badge
                ZStack {
                    Circle()
                        .fill(Color.sumiPersimmonMuted)
                        .frame(width: 48, height: 48)
                    Text("\(day)")
                        .sumiTextStyle(.callout)
                        .foregroundColor(.sumiPersimmon)
                }
            }
            
            SumiDivider()
            
            HStack(spacing: Space.sm) {
                Image(systemName: "headphones")
                    .font(.system(size: 14))
                    .foregroundColor(.sumiTertiaryText)
                Text("4 min audio · Guided reflection")
                    .sumiTextStyle(.caption)
                    .foregroundColor(.sumiTertiaryText)
                
                Spacer()
                
                HStack(spacing: Space.xs) {
                    Text("Begin")
                        .sumiTextStyle(.callout)
                        .foregroundColor(.sumiPersimmon)
                    Image(systemName: "arrow.right")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.sumiPersimmon)
                }
            }
        }
        .padding(Space.lg)
        .sumiCard(style: .elevated)
    }
}

struct InsightCard: View {
    let day: Int
    let excerpt: String
    let date: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: Space.md) {
            HStack {
                Text("Day \(day)")
                    .sumiTextStyle(.label)
                    .foregroundColor(.sumiQuaternaryText)
                Spacer()
                Text(date)
                    .sumiTextStyle(.caption2)
                    .foregroundColor(.sumiQuaternaryText)
            }
            
            Text("\(excerpt)")
                .sumiTextStyle(.body)
                .foregroundColor(.sumiSecondaryText)
                .lineLimit(3)
                .multilineTextAlignment(.leading)
        }
        .padding(Space.lg)
        .frame(width: 240, alignment: .leading)
        .sumiCard(style: .filled)
    }
}

#Preview {
    HomeView(onStartSession: {})
}
