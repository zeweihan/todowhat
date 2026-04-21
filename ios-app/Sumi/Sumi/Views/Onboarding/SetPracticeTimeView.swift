import SwiftUI

struct SetPracticeTimeView: View {
    @State private var practiceTime: Date = Calendar.current.date(from: DateComponents(hour: 7, minute: 0)) ?? Date()
    var onContinue: (Date) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: Space.lg) {
            Text("Set your practice time")
                .font(.custom("New York", size: 34))
                .foregroundColor(.sumiInk)
                .padding(.top, Space.xl)
                .padding(.horizontal, Space.lg)
            
            Text("We'll send a gentle reminder each morning to ground your day.")
                .font(.system(size: 15))
                .foregroundColor(.sumi80)
                .padding(.horizontal, Space.lg)
            
            Spacer()
            
            DatePicker("", selection: $practiceTime, displayedComponents: .hourAndMinute)
                .datePickerStyle(.wheel)
                .labelsHidden()
                .frame(maxWidth: .infinity)
                .padding(.horizontal, Space.lg)
            
            Spacer()
            
            Button(action: {
                onContinue(practiceTime)
            }) {
                Text("Continue")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.washi)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(Color.persimmon)
                    .cornerRadius(14)
            }
            .padding(.horizontal, Space.lg)
            .padding(.bottom, Space.xl)
        }
        .background(Color.washi.ignoresSafeArea())
    }
}

#Preview {
    SetPracticeTimeView(onContinue: { _ in })
}
