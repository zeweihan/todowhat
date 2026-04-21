import SwiftUI

struct SetPracticeTimeView: View {
    @State private var practiceTime: Date = Calendar.current.date(from: DateComponents(hour: 7, minute: 0)) ?? Date()
    @State private var selectedPeriod: String = "Morning"
    
    var onContinue: (Date) -> Void
    
    let periods = [
        (name: "Dawn", icon: "sun.haze", hour: 5),
        (name: "Morning", icon: "sunrise", hour: 7),
        (name: "Noon", icon: "sun.max", hour: 12),
        (name: "Evening", icon: "sunset", hour: 18),
        (name: "Night", icon: "moon", hour: 21)
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: Space.xs) {
                Text("Set your practice time")
                    .sumiTextStyle(.hero)
                    .foregroundColor(.sumiPrimaryText)
                
                Text("We'll send a gentle reminder to ground your day.")
                    .sumiTextStyle(.body)
                    .foregroundColor(.sumiSecondaryText)
            }
            .padding(.horizontal, Space.screenEdge)
            .padding(.top, Space.xxxl)
            .padding(.bottom, Space.xxl)
            .sumiEntrance(delay: 0)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: Space.xl) {
                    // Quick-select period chips
                    VStack(alignment: .leading, spacing: Space.md) {
                        Text("Quick Select")
                            .sumiTextStyle(.label)
                            .foregroundColor(.sumiTertiaryText)
                        
                        HStack(spacing: Space.sm) {
                            ForEach(periods, id: \.name) { period in
                                PeriodChip(
                                    name: period.name,
                                    icon: period.icon,
                                    isSelected: selectedPeriod == period.name
                                ) {
                                    selectedPeriod = period.name
                                    practiceTime = Calendar.current.date(from: DateComponents(hour: period.hour, minute: 0)) ?? Date()
                                }
                            }
                        }
                    }
                    .padding(.horizontal, Space.screenEdge)
                    
                    // Time picker card
                    VStack(spacing: Space.lg) {
                        HStack {
                            Image(systemName: "bell")
                                .font(.system(size: 16))
                                .foregroundColor(.sumiSecondaryText)
                            Text("Custom Time")
                                .sumiTextStyle(.callout)
                                .foregroundColor(.sumiSecondaryText)
                            Spacer()
                        }
                        
                        DatePicker("", selection: $practiceTime, displayedComponents: .hourAndMinute)
                            .datePickerStyle(.wheel)
                            .labelsHidden()
                            .frame(maxWidth: .infinity)
                    }
                    .sumiCard(style: .filled)
                    .padding(.horizontal, Space.screenEdge)
                }
                .padding(.bottom, Space.xl)
            }
            
            Spacer()
            
            VStack(spacing: Space.md) {
                Button(action: {
                    onContinue(practiceTime)
                }) {
                    Text("Continue")
                }
                .buttonStyle(SumiPrimaryButtonStyle())
            }
            .padding(.horizontal, Space.screenEdge)
            .padding(.bottom, Space.xxl)
            .sumiEntrance(delay: 0.2)
        }
        .sumiPageBackground()
    }
}

struct PeriodChip: View {
    let name: String
    let icon: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: Space.xs) {
                Image(systemName: icon)
                    .font(.system(size: 20, weight: .light))
                Text(name)
                    .sumiTextStyle(.caption)
            }
            .foregroundColor(isSelected ? .washi : .sumiSecondaryText)
            .frame(maxWidth: .infinity)
            .padding(.vertical, Space.md)
            .background(isSelected ? Color.sumiInk : Color.sumiCardSurface)
            .cornerRadius(Radius.lg)
            .overlay(
                RoundedRectangle(cornerRadius: Radius.lg)
                    .stroke(isSelected ? Color.clear : Color.sumiBorder, lineWidth: 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
        .scaleEffect(isSelected ? 1.0 : 0.98)
        .animation(.easeOut(duration: 0.2), value: isSelected)
    }
}

#Preview {
    SetPracticeTimeView(onContinue: { _ in })
}
