import SwiftUI

struct SettingsView: View {
    @State private var practiceTime: Date = Calendar.current.date(from: DateComponents(hour: 7, minute: 0)) ?? Date()
    @State private var selectedLanguage = "en"
    @State private var pushEnabled = true
    @State private var soundEnabled = true
    @State private var hapticsEnabled = true
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.sumiBackground.ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: Space.section) {
                        // Header
                        HStack {
                            Text("Settings")
                                .sumiTextStyle(.hero)
                                .foregroundColor(.sumiPrimaryText)
                            Spacer()
                        }
                        .padding(.horizontal, Space.screenEdge)
                        .padding(.top, Space.md)
                        .sumiEntrance(delay: 0)
                        
                        // Practice Section
                        SettingsSection(title: "Practice") {
                            VStack(spacing: 0) {
                                SettingsToggleRow(
                                    icon: "bell",
                                    title: "Morning Reminder",
                                    isOn: $pushEnabled
                                )
                                
                                if pushEnabled {
                                    SettingsTimeRow(
                                        icon: "clock",
                                        title: "Practice Time",
                                        time: $practiceTime
                                    )
                                    .transition(.move(edge: .top).combined(with: .opacity))
                                }
                                
                                SettingsToggleRow(
                                    icon: "speaker.wave.2",
                                    title: "Sound Effects",
                                    isOn: $soundEnabled
                                )
                                
                                SettingsToggleRow(
                                    icon: "hand.tap",
                                    title: "Haptic Feedback",
                                    isOn: $hapticsEnabled
                                )
                            }
                            .sumiCard(style: .default, padding: 0)
                        }
                        
                        // Language Section
                        SettingsSection(title: "Language") {
                            VStack(spacing: 0) {
                                SettingsPickerRow(
                                    icon: "globe",
                                    title: "App Language",
                                    selection: $selectedLanguage,
                                    options: [
                                        ("en", "English"),
                                        ("es", "Español (Soon)"),
                                        ("zh", "中文 (Soon)")
                                    ]
                                )
                            }
                            .sumiCard(style: .default, padding: 0)
                        }
                        
                        // Subscription Section
                        SettingsSection(title: "Subscription") {
                            VStack(spacing: 0) {
                                SettingsInfoRow(
                                    icon: "checkmark.seal.fill",
                                    title: "Status",
                                    value: "Active: 7-Day Intro",
                                    valueColor: .sumiMatcha
                                )
                                
                                SettingsActionRow(icon: "creditcard", title: "Manage Subscription")
                                SettingsActionRow(icon: "arrow.counterclockwise", title: "Restore Purchases")
                            }
                            .sumiCard(style: .default, padding: 0)
                        }
                        
                        // About Section
                        SettingsSection(title: "About") {
                            VStack(spacing: Space.md) {
                                VStack(alignment: .leading, spacing: Space.sm) {
                                    Text("Not Medical Advice")
                                        .sumiTextStyle(.callout)
                                        .foregroundColor(.sumiSecondaryText)
                                    
                                    Text("SumiDay provides philosophical texts and AI-generated reflective dialogue based on classical traditions. It is not a substitute for professional mental health care, therapy, or medical advice. The AI 'Sage' is a roleplay mechanism and not a real person.")
                                        .sumiTextStyle(.caption)
                                        .foregroundColor(.sumiTertiaryText)
                                        .lineSpacing(4)
                                }
                                .padding(Space.lg)
                                .sumiCard(style: .filled)
                                
                                HStack(spacing: Space.sm) {
                                    Text("SumiDay v1.0")
                                        .sumiTextStyle(.caption2)
                                    Text("·")
                                        .sumiTextStyle(.caption2)
                                    Text("Made with care")
                                        .sumiTextStyle(.caption2)
                                }
                                .foregroundColor(.sumiQuaternaryText)
                                .frame(maxWidth: .infinity, alignment: .center)
                            }
                        }
                        
                        Spacer(minLength: Space.xxl)
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

// MARK: - Settings Components

struct SettingsSection<Content: View>: View {
    let title: String
    @ViewBuilder let content: Content
    
    var body: some View {
        VStack(alignment: .leading, spacing: Space.md) {
            Text(title)
                .sumiTextStyle(.label)
                .foregroundColor(.sumiTertiaryText)
                .padding(.horizontal, Space.screenEdge)
            
            content
        }
        .sumiEntrance(delay: 0.1)
    }
}

struct SettingsToggleRow: View {
    let icon: String
    let title: String
    @Binding var isOn: Bool
    
    var body: some View {
        HStack(spacing: Space.md) {
            Image(systemName: icon)
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.sumiSecondaryText)
                .frame(width: 28)
            
            Text(title)
                .sumiTextStyle(.body)
                .foregroundColor(.sumiPrimaryText)
            
            Spacer()
            
            Toggle("", isOn: $isOn)
                .tint(Color.sumiMatcha)
                .labelsHidden()
        }
        .padding(Space.lg)
        .background(Color.sumiCardSurface)
    }
}

struct SettingsTimeRow: View {
    let icon: String
    let title: String
    @Binding var time: Date
    
    var body: some View {
        HStack(spacing: Space.md) {
            Image(systemName: icon)
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.sumiSecondaryText)
                .frame(width: 28)
            
            Text(title)
                .sumiTextStyle(.body)
                .foregroundColor(.sumiPrimaryText)
            
            Spacer()
            
            DatePicker("", selection: $time, displayedComponents: .hourAndMinute)
                .datePickerStyle(.compact)
                .labelsHidden()
                .frame(width: 100)
        }
        .padding(Space.lg)
        .background(Color.sumiCardSurfaceSecondary)
    }
}

struct SettingsPickerRow: View {
    let icon: String
    let title: String
    @Binding var selection: String
    let options: [(String, String)]
    
    var body: some View {
        HStack(spacing: Space.md) {
            Image(systemName: icon)
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.sumiSecondaryText)
                .frame(width: 28)
            
            Text(title)
                .sumiTextStyle(.body)
                .foregroundColor(.sumiPrimaryText)
            
            Spacer()
            
            Picker("", selection: $selection) {
                ForEach(options, id: \.0) { option in
                    Text(option.1).tag(option.0)
                }
            }
            .pickerStyle(.menu)
            .tint(.sumiSecondaryText)
        }
        .padding(Space.lg)
        .background(Color.sumiCardSurface)
    }
}

struct SettingsInfoRow: View {
    let icon: String
    let title: String
    let value: String
    let valueColor: Color
    
    var body: some View {
        HStack(spacing: Space.md) {
            Image(systemName: icon)
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.sumiSecondaryText)
                .frame(width: 28)
            
            Text(title)
                .sumiTextStyle(.body)
                .foregroundColor(.sumiPrimaryText)
            
            Spacer()
            
            Text(value)
                .sumiTextStyle(.callout)
                .foregroundColor(valueColor)
        }
        .padding(Space.lg)
        .background(Color.sumiCardSurface)
    }
}

struct SettingsActionRow: View {
    let icon: String
    let title: String
    
    var body: some View {
        Button(action: {}) {
            HStack(spacing: Space.md) {
                Image(systemName: icon)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.sumiSecondaryText)
                    .frame(width: 28)
                
                Text(title)
                    .sumiTextStyle(.body)
                    .foregroundColor(.sumiPrimaryText)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.sumiQuaternaryText)
            }
            .padding(Space.lg)
            .background(Color.sumiCardSurface)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
}
