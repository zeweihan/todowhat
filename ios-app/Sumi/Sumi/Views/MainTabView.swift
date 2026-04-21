import SwiftUI

enum AppRoute: Hashable {
    case practice
    case journal
    case settings
    case onboarding
}

struct MainTabView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            PracticeView()
                .tabItem {
                    Image(systemName: selectedTab == 0 ? "sun.horizon.fill" : "sun.horizon")
                        .environment(\.symbolVariants, selectedTab == 0 ? .fill : .none)
                    Text("Practice")
                }
                .tag(0)
            
            PathwayView()
                .tabItem {
                    Image(systemName: selectedTab == 1 ? "map.fill" : "map")
                        .environment(\.symbolVariants, selectedTab == 1 ? .fill : .none)
                    Text("Journey")
                }
                .tag(1)
            
            JournalView()
                .tabItem {
                    Image(systemName: selectedTab == 2 ? "book.closed.fill" : "book.closed")
                        .environment(\.symbolVariants, selectedTab == 2 ? .fill : .none)
                    Text("Journal")
                }
                .tag(2)
        }
        .tint(Color.sumiPersimmon)
        .onAppear {
            // Style the tab bar for a more muted, postal look
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor(Color.sumiCardSurface)
            
            appearance.stackedLayoutAppearance.normal.iconColor = UIColor(Color.sumiTertiaryText)
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
                .foregroundColor: UIColor(Color.sumiTertiaryText)
            ]
            appearance.stackedLayoutAppearance.selected.iconColor = UIColor(Color.sumiPersimmon)
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
                .foregroundColor: UIColor(Color.sumiPersimmon)
            ]
            
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}

#Preview {
    MainTabView()
}
