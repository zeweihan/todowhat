import SwiftUI

struct HomeView: View {
    @State private var showingPathSelection = false
    
    // In a real app, this state would come from the SwiftData / Supabase ViewModel
    let currentPathTitle = "Zen: The Gateless Gate"
    let currentDay = 4
    let totalDays = 30
    let currentStreak = 12
    let practitionerLevel = "APPRENTICE"
    
    var onStartSession: () -> Void
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.washi.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: Space.section) {
                        
                        // Header: Stats
                        HStack(spacing: Space.lg) {
                            StreakCounter(streak: currentStreak)
                            PractitionerBadge(level: practitionerLevel)
                            Spacer()
                        }
                        .padding(.horizontal, Space.lg)
                        .padding(.top, Space.md)
                        
                        // Current Path Label (with switch button)
                        VStack(spacing: Space.sm) {
                            Button(action: {
                                showingPathSelection = true
                            }) {
                                HStack(spacing: Space.xs) {
                                    Text(currentPathTitle)
                                        .font(.system(size: 15, weight: .medium))
                                        .foregroundColor(.sumi80)
                                    Image(systemName: "chevron.up.chevron.down")
                                        .font(.system(size: 12))
                                        .foregroundColor(.sumi40)
                                }
                            }
                            
                            Text("Day \(currentDay) of \(totalDays)")
                                .font(.custom("New York", size: 34))
                                .foregroundColor(.sumiInk)
                        }
                        
                        // Today's Passage Card
                        Button(action: onStartSession) {
                            PassagePreviewCard()
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.horizontal, Space.lg)
                        
                        Spacer()
                    }
                }
            }
            .navigationTitle("SumiDay")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "gearshape")
                            .foregroundColor(.sumiInk)
                    }
                }
            }
            .sheet(isPresented: $showingPathSelection) {
                // We reuse the PathSelectionView logic for swapping paths
                PathSelectionView {
                    showingPathSelection = false
                }
            }
        }
    }
}

// Subcomponents

struct StreakCounter: View {
    let streak: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack(spacing: 4) {
                Image(systemName: streak > 0 ? "flame.fill" : "flame")
                    .foregroundColor(streak > 0 ? .persimmon : .sumi40)
                
                Text("\(streak)")
                    .font(.custom("SF Mono", size: 22))
                    .foregroundColor(streak > 7 ? .persimmon : .sumiInk)
            }
            
            Text("DAY STREAK")
                .font(.system(size: 11, weight: .medium))
                .foregroundColor(.sumi40)
        }
    }
}

struct PractitionerBadge: View {
    let level: String
    
    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: "seal.fill")
                .font(.system(size: 14))
            Text(level)
                .font(.system(size: 13, weight: .medium))
        }
        .foregroundColor(.matcha)
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(Color.matchaLight)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.matcha, lineWidth: 1)
        )
    }
}

struct PassagePreviewCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: Space.lg) {
            Text("Case 4")
                .font(.custom("SF Mono", size: 13))
                .foregroundColor(.sumi40)
            
            Text("Bodhidharma's Empty Hands")
                .font(.custom("New York", size: 22))
                .fontWeight(.medium)
                .foregroundColor(.sumiInk)
                .lineSpacing(4)
                .multilineTextAlignment(.leading)
            
            Divider()
                .background(Color.sumi08)
            
            HStack {
                Text("Start Practice")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.sumi80)
                Spacer()
                Image(systemName: "arrow.right")
                    .foregroundColor(.persimmon)
            }
        }
        .padding(Space.lg)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(16)
        // According to system spec: "flat design — shadows are too decorative" (except maybe light elevation)
    }
}

#Preview {
    HomeView(onStartSession: {})
}
