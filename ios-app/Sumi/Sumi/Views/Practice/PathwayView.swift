import SwiftUI

struct PathwayView: View {
    let completedDays = 4
    let totalDays = 30
    
    @State private var selectedDay: Int? = nil
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.sumiBackground.ignoresSafeArea()
                
                ScrollViewReader { proxy in
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 0) {
                            // Header with progress ring
                            PathwayHeader(
                                title: "The Gateless Gate",
                                completedDays: completedDays,
                                totalDays: totalDays
                            )
                            .id("header")
                            .padding(.top, Space.xxxl)
                            .padding(.bottom, Space.sectionLarge)
                            
                            // The path
                            VStack(spacing: 0) {
                                ForEach((1...totalDays).reversed(), id: \.self) { day in
                                    PathwayStep(
                                        day: day,
                                        totalDays: totalDays,
                                        completedDays: completedDays,
                                        isCompleted: day <= completedDays,
                                        isCurrent: day == completedDays + 1
                                    )
                                    .id(day)
                                    .onTapGesture {
                                        if day <= completedDays {
                                            selectedDay = day
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal, Space.screenEdge)
                            
                            Spacer(minLength: 100)
                        }
                    }
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                            withAnimation(.easeOut(duration: 0.6)) {
                                proxy.scrollTo(completedDays + 1, anchor: .center)
                            }
                        }
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

// MARK: - Header with Progress Ring

struct PathwayHeader: View {
    let title: String
    let completedDays: Int
    let totalDays: Int
    
    var progress: Double {
        Double(completedDays) / Double(totalDays)
    }
    
    var body: some View {
        VStack(spacing: Space.lg) {
            Text(title)
                .sumiTextStyle(.hero)
                .foregroundColor(.sumiPrimaryText)
            
            ZStack {
                // Background ring
                Circle()
                    .stroke(Color.sumiDivider, lineWidth: 10)
                    .frame(width: 132, height: 132)
                
                // Progress ring
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(
                        Color.sumiInk,
                        style: StrokeStyle(lineWidth: 10, lineCap: .round)
                    )
                    .frame(width: 132, height: 132)
                    .rotationEffect(.degrees(-90))
                
                // Center content
                VStack(spacing: Space.xxs) {
                    Text("\(completedDays)/\(totalDays)")
                        .sumiTextStyle(.title2)
                        .foregroundColor(.sumiPrimaryText)
                    Text("completed")
                        .sumiTextStyle(.caption)
                        .foregroundColor(.sumiTertiaryText)
                }
            }
            .sumiShadow(SumiShadow.small)
        }
    }
}

// MARK: - Pathway Step

struct PathwayStep: View {
    let day: Int
    let totalDays: Int
    let completedDays: Int
    let isCompleted: Bool
    let isCurrent: Bool
    
    var isLocked: Bool { !isCompleted && !isCurrent }
    var isMilestone: Bool { day == 1 || day == totalDays || day % 7 == 0 }
    
    var body: some View {
        HStack(spacing: 0) {
            // Left: labels for completed/current milestones
            Group {
                if isMilestone && (isCompleted || isCurrent) {
                    MilestoneLabel(
                        day: day,
                        totalDays: totalDays,
                        isCompleted: isCompleted,
                        isCurrent: isCurrent
                    )
                    .frame(maxWidth: .infinity, alignment: .trailing)
                } else if isCurrent {
                    CurrentLabel()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                } else {
                    Spacer()
                }
            }
            .frame(width: 100)
            
            // Center: node column
            VStack(spacing: 0) {
                // Connector above
                if day < totalDays {
                    PathwayConnector(
                        fromCompleted: day < completedDays,
                        toCurrent: day == completedDays
                    )
                }
                
                PathwayNodeCircle(
                    day: day,
                    isCompleted: isCompleted,
                    isCurrent: isCurrent,
                    isMilestone: isMilestone
                )
            }
            .frame(width: 80)
            
            // Right: labels for locked milestones
            Group {
                if isMilestone && isLocked {
                    MilestoneLabel(
                        day: day,
                        totalDays: totalDays,
                        isCompleted: isCompleted,
                        isCurrent: isCurrent
                    )
                    .frame(maxWidth: .infinity, alignment: .leading)
                } else {
                    Spacer()
                }
            }
            .frame(width: 100)
        }
        .frame(height: stepHeight)
        .sumiStaggered(index: totalDays - day, baseDelay: 0.03)
    }
    
    var stepHeight: CGFloat {
        if isCurrent { return 84 }
        if isMilestone { return 76 }
        return 64
    }
}

// MARK: - Connector

struct PathwayConnector: View {
    let fromCompleted: Bool
    let toCurrent: Bool
    
    var body: some View {
        Rectangle()
            .fill(connectorColor)
            .frame(width: connectorWidth, height: stepSpacing)
    }
    
    var connectorColor: Color {
        if fromCompleted { return .sumiInk }
        if toCurrent { return .sumiPersimmon.opacity(0.5) }
        return .sumiDivider
    }
    
    var connectorWidth: CGFloat {
        if fromCompleted || toCurrent { return 3 }
        return 1
    }
    
    var stepSpacing: CGFloat {
        40
    }
}

// MARK: - Node Circle

struct PathwayNodeCircle: View {
    let day: Int
    let isCompleted: Bool
    let isCurrent: Bool
    let isMilestone: Bool
    
    @State private var pulseScale: CGFloat = 1.0
    
    var body: some View {
        ZStack {
            // Pulse glow for current
            if isCurrent {
                Circle()
                    .fill(Color.sumiPersimmon.opacity(0.15))
                    .frame(width: 80, height: 80)
                    .scaleEffect(pulseScale)
            }
            
            // Milestone decorative ring
            if isMilestone {
                Circle()
                    .stroke(milestoneRingColor, lineWidth: 2)
                    .frame(width: nodeSize + 10, height: nodeSize + 10)
            }
            
            // Main node
            Circle()
                .fill(nodeFill)
                .frame(width: nodeSize, height: nodeSize)
                .overlay(
                    Circle()
                        .stroke(nodeStroke, lineWidth: nodeStrokeWidth)
                )
                .shadow(color: shadowColor, radius: shadowRadius, x: 0, y: shadowY)
            
            // Inner content
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
                    .sumiTextStyle(.caption)
                    .foregroundColor(.sumiTertiaryText)
            }
        }
        .onAppear {
            if isCurrent {
                withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                    pulseScale = 1.2
                }
            }
        }
    }
    
    var nodeSize: CGFloat {
        if isCurrent { return 56 }
        if isCompleted { return 42 }
        return 34
    }
    
    var nodeFill: Color {
        if isCompleted { return .sumiInk }
        if isCurrent { return .sumiPersimmon }
        return .sumiCardSurface
    }
    
    var nodeStroke: Color {
        if isCompleted || isCurrent { return .clear }
        return .sumiSand
    }
    
    var nodeStrokeWidth: CGFloat {
        if isCompleted || isCurrent { return 0 }
        return 1.5
    }
    
    var milestoneRingColor: Color {
        if isCompleted { return .sumiMatcha.opacity(0.5) }
        if isCurrent { return .sumiPersimmon.opacity(0.5) }
        return .sumiSand
    }
    
    var shadowColor: Color {
        if isCurrent { return .sumiPersimmon.opacity(0.25) }
        if isCompleted { return .sumiInk.opacity(0.12) }
        return .clear
    }
    
    var shadowRadius: CGFloat {
        if isCurrent { return 16 }
        if isCompleted { return 8 }
        return 0
    }
    
    var shadowY: CGFloat {
        if isCurrent { return 8 }
        if isCompleted { return 4 }
        return 0
    }
}

// MARK: - Labels

struct MilestoneLabel: View {
    let day: Int
    let totalDays: Int
    let isCompleted: Bool
    let isCurrent: Bool
    
    var label: String {
        if day == 1 { return "Start" }
        if day == totalDays { return "The Gate" }
        return "Week \(day / 7)"
    }
    
    var body: some View {
        HStack(spacing: Space.sm) {
            if isCompleted {
                Image(systemName: "seal.fill")
                    .font(.system(size: 10))
                    .foregroundColor(.sumiMatcha)
            } else if isCurrent {
                Image(systemName: "location.fill")
                    .font(.system(size: 10))
                    .foregroundColor(.sumiPersimmon)
            }
            
            Text(label)
                .sumiTextStyle(.caption)
                .foregroundColor(labelColor)
        }
        .padding(.horizontal, Space.md)
        .padding(.vertical, Space.sm)
        .background(labelBackground)
        .cornerRadius(Radius.pill)
    }
    
    var labelColor: Color {
        if isCompleted { return .sumiSecondaryText }
        if isCurrent { return .sumiPersimmon }
        return .sumiTertiaryText
    }
    
    var labelBackground: Color {
        if isCompleted { return .sumiMatchaMuted }
        if isCurrent { return .sumiPersimmonMuted }
        return .sumiCardSurfaceSecondary
    }
}

struct CurrentLabel: View {
    var body: some View {
        HStack(spacing: Space.xs) {
            Circle()
                .fill(Color.sumiPersimmon)
                .frame(width: 6, height: 6)
            Text("Current")
                .sumiTextStyle(.caption)
                .foregroundColor(.sumiPersimmon)
        }
        .padding(.horizontal, Space.md)
        .padding(.vertical, Space.sm)
        .background(Color.sumiPersimmonMuted)
        .cornerRadius(Radius.pill)
    }
}

struct PathwayDayIdentifier: Identifiable {
    let id: Int
}

#Preview {
    PathwayView()
}
