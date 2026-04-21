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
                    // Active state will use the fill variant automatically in iOS 17 if available
                    Image(systemName: selectedTab == 0 ? "sun.horizon.fill" : "sun.horizon")
                    Text("Practice")
                }
                .tag(0)
                
            PathwayView()
                .tabItem {
                    Image(systemName: selectedTab == 1 ? "map.fill" : "map")
                    Text("Journey")
                }
                .tag(1)
        }
        .tint(Color.persimmon)
    }
}

#Preview {
    MainTabView()
}
