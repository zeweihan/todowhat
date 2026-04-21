import SwiftUI

struct PathwayView: View {
    let completedDays = 4
    let totalDays = 30
    
    @State private var selectedDay: Int? = nil
    @State private var showContent = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.sumiBackground.ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        // Header
                        VStack(spacing: Space.sm) {
                            Text("The Gateless Gate")
                                .sumiTextStyle(.hero)
                                .foregroundColor(.sumiPrimaryText)
                            
                            Text("\(completedDays) of \(totalDays) days completed")
                                .sumiTextStyle(.subheadline)
                                .foregroundColor(.sumiTertiaryText)
                        }
                        .padding(.top, Space.xxxl)
                        .padding(.bottom, Space.sectionLarge)
                        .sumiEntrance(delay: 0)
                        
                        // Path nodes
                        ForEach((1...totalDays).reversed(), id: \.self) { day in
                            PathwayNode(
                                day: day,
                                isCompleted: day <= completedDays,
                                isCurrent: day == completedDays + 1,
                                offset: CGFloat(sin(Double(day) * 0.8) * 60),
                                index: totalDays - day
                            )
                            .onTapGesture {
                                if day <= completedDays {
                                    selectedDay = day
                                }
                            }
                        }
                        
                        Spacer(minLength: 100)
                    }
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
    let index: Int
    
    var body: some View {
        VStack(spacing: 0) {
            // Connecting line
            if day < 30 {
                Rectangle()
                    .fill(lineColor)
                    .frame(width: isCompleted ? 3 : 2, height: 48)
                    .offset(x: offset)
            }
            
            // Node
            HStack(spacing: 0) {
                Spacer()
                
                ZStack {
                    // Glow for current node
                    if isCurrent {
                        Circle()
                            .fill(Color.sumiPersimmon.opacity(0.15))
                            .frame(width: 64, height: 64)
                            .scaleEffect(1.0)
                            .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: isCurrent)
                    }
                    
                    Circle()
                        .fill(nodeFill)
                        .frame(width: nodeSize, height: nodeSize)
                        .sumiShadow(nodeShadow)
                    
                    if isCompleted {
                        Image(systemName: "checkmark")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.washi)
                    } else if isCurrent {
                        Text("\(day)")
                            .sumiTextStyle(.callout)
                            .foregroundColor(.washi)
                    } else {
                        Text("\(day)")
                            .sumiTextStyle(.subheadline)
                            .foregroundColor(.sumiTertiaryText)
                    }
                }
                
                // Milestone label
                if isMilestone {
                    HStack(spacing: Space.sm) {
                        Text(milestoneLabel)
                            .sumiTextStyle(.caption)
                            .foregroundColor(isCompleted ? .sumiPrimaryText : .sumiTertiaryText)
                        
                        if day == completedDays + 1 {
                            Text("Current")
                                .sumiTextStyle(.caption2)
                                .foregroundColor(.sumiPersimmon)
                                .padding(.horizontal, Space.sm)
                                .padding(.vertical, Space.xxs)
                                .background(Color.sumiPersimmonMuted)
                                .cornerRadius(Radius.pill)
                        }
                    }
                    .padding(.leading, Space.lg)
                    .frame(width: 140, alignment: .leading)
                } else {
                    Spacer().frame(width: 140)
                }
                
                Spacer()
            }
            .offset(x: offset)
        }
        .sumiStaggered(index: index, baseDelay: 0.05)
    }
    
    var isMilestone: Bool {
        day == 1 || day == totalDays || day % 7 == 0 || day == completedDays + 1
    }
    
    var milestoneLabel: String {
        if day == 1 { return "Start" }
        if day == totalDays { return "Complete" }
        return "Week \(day / 7)"
    }
    
    var lineColor: Color {
        if isCompleted { return .sumiInk }
        if isCurrent { return .sumiPersimmon.opacity(0.4) }
        return .sumiDivider
    }
    
    var nodeFill: Color {
        if isCompleted { return .sumiInk }
        if isCurrent { return .sumiPersimmon }
        return .sumiCardSurface
    }
    
    var nodeSize: CGFloat {
        if isCurrent { return 48 }
        if isCompleted { return 40 }
        return 36
    }
    
    var nodeShadow: ShadowStyle {
        if isCurrent { return SumiShadow.medium }
        if isCompleted { return SumiShadow.small }
        return SumiShadow.small
    }
}

#Preview {
    PathwayView()
}
