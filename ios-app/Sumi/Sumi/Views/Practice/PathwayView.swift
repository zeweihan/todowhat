import SwiftUI

struct PathwayView: View {
    let completedDays = 4
    let totalDays = 30
    let trackWidth: CGFloat = 320
    let stepY: CGFloat = 62
    
    @State private var selectedDay: Int? = nil
    
    // Multi-frequency offset for natural winding path
    func stoneOffset(for day: Int) -> CGFloat {
        let index = Double(totalDays - day)
        let a = sin(index * 0.5) * 75
        let b = cos(index * 0.85) * 32
        let c = sin(index * 1.45) * 14
        return CGFloat(a + b + c)
    }
    
    func isMilestone(_ day: Int) -> Bool {
        day == 1 || day == totalDays || day % 7 == 0
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.sumiBackground.ignoresSafeArea()
                
                ScrollViewReader { proxy in
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 0) {
                            // Header
                            PathwayHeader(
                                title: "The Gateless Gate",
                                completedDays: completedDays,
                                totalDays: totalDays
                            )
                            .id("header")
                            .padding(.top, Space.xxxl)
                            .padding(.bottom, Space.section)
                            
                            // Zen Garden Track
                            ZenGardenTrack(
                                totalDays: totalDays,
                                completedDays: completedDays,
                                trackWidth: trackWidth,
                                stepY: stepY,
                                stoneOffset: stoneOffset,
                                isMilestone: isMilestone,
                                onSelectDay: { day in
                                    if day <= completedDays {
                                        selectedDay = day
                                    }
                                }
                            )
                            .padding(.horizontal, Space.screenEdge)
                            
                            Spacer(minLength: 120)
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
                Circle()
                    .stroke(Color.sumiDivider, lineWidth: 10)
                    .frame(width: 120, height: 120)
                
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(
                        Color.sumiInk,
                        style: StrokeStyle(lineWidth: 10, lineCap: .round)
                    )
                    .frame(width: 120, height: 120)
                    .rotationEffect(.degrees(-90))
                
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

// MARK: - Zen Garden Track

struct ZenGardenTrack: View {
    let totalDays: Int
    let completedDays: Int
    let trackWidth: CGFloat
    let stepY: CGFloat
    let stoneOffset: (Int) -> CGFloat
    let isMilestone: (Int) -> Bool
    let onSelectDay: (Int) -> Void
    
    private var centerX: CGFloat { trackWidth / 2 }
    private var trackHeight: CGFloat { CGFloat(totalDays - 1) * stepY + 80 }
    
    var body: some View {
        ZStack {
            // Background decorations (pebbles, sand ripples)
            GardenDecorations(trackWidth: trackWidth, trackHeight: trackHeight)
            
            // Connecting path (drawn behind stones)
            GardenPath(
                totalDays: totalDays,
                completedDays: completedDays,
                centerX: centerX,
                stepY: stepY,
                stoneOffset: stoneOffset
            )
            
            // Stones and labels
            ForEach((1...totalDays).reversed(), id: \.self) { day in
                let index = totalDays - day
                let y = CGFloat(index) * stepY + 36
                let offset = stoneOffset(day)
                let x = centerX + offset
                let completed = day <= completedDays
                let current = day == completedDays + 1
                let milestone = isMilestone(day)
                
                // Zen Stone
                ZenStone(
                    day: day,
                    isCompleted: completed,
                    isCurrent: current,
                    isMilestone: milestone
                )
                .position(x: x, y: y)
                .onTapGesture { onSelectDay(day) }
                .id(day)
                
                // Milestone label
                if milestone {
                    MilestoneTag(
                        day: day,
                        totalDays: totalDays,
                        isCompleted: completed,
                        isCurrent: current
                    )
                    .position(
                        x: x + (offset > 8 ? -78 : (offset < -8 ? 78 : 78)),
                        y: y
                    )
                }
                
                // Current badge
                if current && !milestone {
                    CurrentTag()
                        .position(
                            x: x + (offset > 0 ? -68 : 68),
                            y: y
                        )
                }
            }
            
            // Entrance label at bottom
            VStack(spacing: 4) {
                Image(systemName: "arrow.down")
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundColor(.sumiQuaternaryText)
                Text("Entrance")
                    .sumiTextStyle(.caption2)
                    .foregroundColor(.sumiQuaternaryText)
            }
            .position(x: centerX + stoneOffset(1), y: trackHeight - 24)
        }
        .frame(width: trackWidth, height: trackHeight)
    }
}

// MARK: - Garden Decorations

struct GardenDecorations: View {
    let trackWidth: CGFloat
    let trackHeight: CGFloat
    
    var body: some View {
        ZStack {
            // Scattered pebbles
            Pebble(x: 40, y: 180, size: 8, opacity: 0.25)
            Pebble(x: trackWidth - 35, y: 260, size: 6, opacity: 0.2)
            Pebble(x: 55, y: 420, size: 10, opacity: 0.22)
            Pebble(x: trackWidth - 50, y: 540, size: 7, opacity: 0.18)
            Pebble(x: 35, y: 720, size: 9, opacity: 0.24)
            Pebble(x: trackWidth - 40, y: 850, size: 6, opacity: 0.2)
            Pebble(x: 60, y: 980, size: 8, opacity: 0.22)
            Pebble(x: trackWidth - 45, y: 1120, size: 7, opacity: 0.18)
            Pebble(x: 45, y: 1280, size: 9, opacity: 0.24)
            Pebble(x: trackWidth - 55, y: 1380, size: 6, opacity: 0.2)
            
            // Subtle sand ripples (very faint arcs)
            Ripple(x: trackWidth/2, y: 300, width: 260, opacity: 0.06)
            Ripple(x: trackWidth/2, y: 700, width: 280, opacity: 0.05)
            Ripple(x: trackWidth/2, y: 1100, width: 250, opacity: 0.06)
            Ripple(x: trackWidth/2, y: 1500, width: 270, opacity: 0.05)
        }
    }
}

struct Pebble: View {
    let x: CGFloat
    let y: CGFloat
    let size: CGFloat
    let opacity: Double
    
    var body: some View {
        Ellipse()
            .fill(Color.sumiSand.opacity(opacity))
            .frame(width: size, height: size * 0.85)
            .rotationEffect(.degrees(Double.random(in: -30...30)))
            .position(x: x, y: y)
    }
}

struct Ripple: View {
    let x: CGFloat
    let y: CGFloat
    let width: CGFloat
    let opacity: Double
    
    var body: some View {
        Ellipse()
            .stroke(Color.sumiSand.opacity(opacity), lineWidth: 1)
            .frame(width: width, height: width * 0.35)
            .position(x: x, y: y)
    }
}

// MARK: - Garden Path

struct GardenPath: View {
    let totalDays: Int
    let completedDays: Int
    let centerX: CGFloat
    let stepY: CGFloat
    let stoneOffset: (Int) -> CGFloat
    
    var body: some View {
        ZStack {
            // Full trail (dashed, subtle)
            Path { path in
                addPoints(to: &path, days: (1...totalDays).reversed())
            }
            .stroke(
                Color.sumiSand.opacity(0.5),
                style: StrokeStyle(lineWidth: 2, dash: [3, 5])
            )
            
            // Walked trail (solid, darker)
            if completedDays > 0 {
                Path { path in
                    addPoints(to: &path, days: (1...completedDays).reversed())
                }
                .stroke(Color.sumiInk.opacity(0.22), lineWidth: 3)
            }
            
            // Current step highlight (persimmon glow line from last completed to current)
            if completedDays < totalDays {
                Path { path in
                    let fromDay = completedDays + 1
                    let toDay = completedDays
                    let fromIndex = totalDays - fromDay
                    let toIndex = totalDays - toDay
                    let fromY = CGFloat(fromIndex) * stepY + 36
                    let toY = CGFloat(toIndex) * stepY + 36
                    let fromX = centerX + stoneOffset(fromDay)
                    let toX = centerX + stoneOffset(toDay)
                    path.move(to: CGPoint(x: fromX, y: fromY))
                    path.addLine(to: CGPoint(x: toX, y: toY))
                }
                .stroke(Color.sumiPersimmon.opacity(0.35), lineWidth: 3)
            }
        }
    }
    
    func addPoints(to path: inout Path, days: ReversedCollection<ClosedRange<Int>>) {
        var first = true
        for day in days {
            let index = totalDays - day
            let y = CGFloat(index) * stepY + 36
            let x = centerX + stoneOffset(day)
            let point = CGPoint(x: x, y: y)
            if first {
                path.move(to: point)
                first = false
            } else {
                path.addLine(to: point)
            }
        }
    }
}

// MARK: - Zen Stone

struct ZenStone: View {
    let day: Int
    let isCompleted: Bool
    let isCurrent: Bool
    let isMilestone: Bool
    
    @State private var pulseScale: CGFloat = 1.0
    
    var body: some View {
        ZStack {
            // Pulse glow for current
            if isCurrent {
                Ellipse()
                    .fill(Color.sumiPersimmon.opacity(0.12))
                    .frame(width: 78, height: 70)
                    .scaleEffect(pulseScale)
            }
            
            // Milestone outer ring
            if isMilestone {
                Ellipse()
                    .stroke(milestoneRingColor, lineWidth: 2)
                    .frame(width: stoneWidth + 12, height: stoneHeight + 10)
                    .rotationEffect(.degrees(rotation))
            }
            
            // Main stone (irregular ellipse)
            Ellipse()
                .fill(stoneFill)
                .frame(width: stoneWidth, height: stoneHeight)
                .rotationEffect(.degrees(rotation))
                .overlay(
                    Ellipse()
                        .stroke(stoneStroke, lineWidth: stoneStrokeWidth)
                        .rotationEffect(.degrees(rotation))
                )
                .shadow(color: shadowColor, radius: shadowRadius, x: 0, y: shadowY)
            
            // Content (not rotated, stays upright)
            Group {
                if isCompleted {
                    Image(systemName: "checkmark")
                        .font(.system(size: 13, weight: .bold))
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
            .offset(y: isCurrent ? 0 : 0) // ensures text is centered
        }
        .frame(width: 70, height: 70) // tap target
        .contentShape(Rectangle())
        .onAppear {
            if isCurrent {
                withAnimation(.easeInOut(duration: 1.8).repeatForever(autoreverses: true)) {
                    pulseScale = 1.25
                }
            }
        }
    }
    
    var stoneWidth: CGFloat {
        if isCurrent { return 58 }
        if isCompleted { return 44 }
        return 36
    }
    
    var stoneHeight: CGFloat {
        if isCurrent { return 50 }
        if isCompleted { return 38 }
        return 30
    }
    
    var rotation: Double {
        // Each stone has a slightly different tilt, like real stepping stones
        Double((day * 7) % 5) * 10 - 20
    }
    
    var stoneFill: Color {
        if isCompleted { return .sumiInk }
        if isCurrent { return .sumiPersimmon }
        return .sumiCardSurface
    }
    
    var stoneStroke: Color {
        if isCompleted || isCurrent { return .clear }
        return .sumiSand
    }
    
    var stoneStrokeWidth: CGFloat {
        if isCompleted || isCurrent { return 0 }
        return 1.5
    }
    
    var milestoneRingColor: Color {
        if isCompleted { return .sumiMatcha.opacity(0.45) }
        if isCurrent { return .sumiPersimmon.opacity(0.45) }
        return .sumiSand
    }
    
    var shadowColor: Color {
        if isCurrent { return .sumiPersimmon.opacity(0.28) }
        if isCompleted { return .sumiInk.opacity(0.14) }
        return .sumiInk.opacity(0.06)
    }
    
    var shadowRadius: CGFloat {
        if isCurrent { return 14 }
        if isCompleted { return 10 }
        return 5
    }
    
    var shadowY: CGFloat {
        if isCurrent { return 8 }
        if isCompleted { return 5 }
        return 3
    }
}

// MARK: - Milestone Tag

struct MilestoneTag: View {
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
                .foregroundColor(tagColor)
        }
        .padding(.horizontal, Space.md)
        .padding(.vertical, Space.sm)
        .background(tagBackground)
        .cornerRadius(Radius.pill)
        .sumiShadow(SumiShadow.small)
    }
    
    var tagColor: Color {
        if isCompleted { return .sumiSecondaryText }
        if isCurrent { return .sumiPersimmon }
        return .sumiTertiaryText
    }
    
    var tagBackground: Color {
        if isCompleted { return .sumiMatchaMuted }
        if isCurrent { return .sumiPersimmonMuted }
        return .sumiCardSurface
    }
}

struct CurrentTag: View {
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
