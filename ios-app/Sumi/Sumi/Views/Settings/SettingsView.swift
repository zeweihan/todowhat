import SwiftUI

struct SettingsView: View {
    @State private var practiceTime: Date = Calendar.current.date(from: DateComponents(hour: 7, minute: 0)) ?? Date()
    @State private var selectedLanguage = "en"
    @State private var pushEnabled = true
    
    var body: some View {
        Form {
            Section(header: Text("Preferences").font(.system(size: 13, weight: .medium)).foregroundColor(.sumi40)) {
                
                Toggle("Morning Reminder", isOn: $pushEnabled)
                    .tint(.matcha)
                
                if pushEnabled {
                    DatePicker("Practice Time", selection: $practiceTime, displayedComponents: .hourAndMinute)
                        .datePickerStyle(.compact)
                }
                
                Picker("Language", selection: $selectedLanguage) {
                    Text("English").tag("en")
                    Text("Español (Próximamente)").tag("es")
                    Text("中文 (即将推出)").tag("zh")
                }
            }
            .listRowBackground(Color.washi)
            
            Section(header: Text("Subscription").font(.system(size: 13, weight: .medium)).foregroundColor(.sumi40)) {
                HStack {
                    Text("Status")
                    Spacer()
                    Text("Active: 7-Day Intro")
                        .foregroundColor(.sumi80)
                }
                
                Button("Manage Subscription") {
                    // Open RevenueCat portal or App Store settings
                }
                .foregroundColor(.sumiInk)
                
                Button("Restore Purchases") {
                    // StoreKit restore logic
                }
                .foregroundColor(.sumiInk)
            }
            .listRowBackground(Color.washi)
            
            Section {
                VStack(alignment: .leading, spacing: Space.sm) {
                    Text("Not Medical Advice")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.sumi40)
                    
                    Text("SumiDay provides philosophical texts and AI-generated reflective dialogue based on classical traditions. It is not a substitute for professional mental health care, therapy, or medical advice. The AI 'Sage' is a roleplay mechanism and not a real person.")
                        .font(.system(size: 11))
                        .lineSpacing(4)
                        .foregroundColor(.sumi40)
                }
                .padding(.vertical, 4)
            }
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets())
        }
        .scrollContentBackground(.hidden)
        .background(Color(UIColor.secondarySystemBackground).ignoresSafeArea())
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
}
