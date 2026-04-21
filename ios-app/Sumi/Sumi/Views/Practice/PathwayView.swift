import SwiftUI

struct PathwayView: View {
    let completedDays = 4
    let totalDays = 30
    
    @State private var selectedDay: Int? = nil
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.washi.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 0) {
                        
                        Text("The Gateless Gate")
                            .font(.custom("New York", size: 34))
                            .foregroundColor(.sumiInk)
                            .padding(.top, Space.xl)
                            .padding(.bottom, Space.xxl)
                            
                        // Generate the meandering path
                        ForEach((1...totalDays).reversed(), id: \.self) { day in
                            PathwayNode(
                                day: day,
                                isCompleted: day <= completedDays,
                                isCurrent: day == completedDays + 1,
                                offset: CGFloat(sin(Double(day) * 0.8) * 80) // Meandering effect
                            )
                            .onTapGesture {
                                if day <= completedDays {
                                    selectedDay = day
                                }
                            }
                        }
                    }
                    .padding(.bottom, 100)
                }
            }
            .navigationBarHidden(true)
            .sheet(item: Binding<PathwayDayIdentifier?>(
                get: { selectedDay.map { PathwayDayIdentifier(id: $0) } },
                set: { selectedDay = $0?.id }
            )) { identifier in
                PathwayDayDetailView(day: identifier.id)
            }
        }
    }
}

struct PathwayDayIdentifier: Identifiable {
    let id: Int
}

struct PathwayNode: View {
    let day: Int
    let isCompleted: Bool
    let isCurrent: Bool
    let offset: CGFloat
    
    var body: some View {
        VStack(spacing: 0) {
            
            // The connecting line
            if day < 30 {
                Rectangle()
                    .fill(isCompleted ? Color.sumi80 : Color.sumi08)
                    .frame(width: 2, height: 60)
                    .offset(x: offset)
            }
            
            // The node
            ZStack {
                Circle()
                    .fill(isCompleted ? Color.sumiInk : (isCurrent ? Color.persimmon : Color.washiDark.opacity(0.1)))
                    .frame(width: 50, height: 50)
                
                if isCompleted {
                    Image(systemName: "checkmark")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.washi)
                } else if isCurrent {
                    Text("\(day)")
                        .font(.custom("SF Mono", size: 16))
                        .foregroundColor(.washi)
                } else {
                    Text("\(day)")
                        .font(.custom("SF Mono", size: 16))
                        .foregroundColor(.sumi40)
                }
            }
            .offset(x: offset)
            .overlay(
                // Optional label for milestone days
                Group {
                    if day == 1 || day % 7 == 0 {
                        Text("Day \(day)")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(isCompleted ? .sumiInk : .sumi40)
                            .offset(x: offset + 60)
                    }
                }
                , alignment: .trailing
            )
        }
    }
}

#Preview {
    PathwayView()
}
