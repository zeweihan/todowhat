import SwiftUI

struct PathwayView: View {
    let completedDays = 4
    let totalDays = 30
    let trackWidth: CGFloat = 340
    let stepY: CGFloat = 70
    
    @State private var selectedDay: Int? = nil
    
    func stoneOffset(for day: Int) -> CGFloat {
        let index = Double(totalDays - day)
        let a = sin(index * 0.55 + 1.3) * 90
        let b = cos(index * 0.95 + 0.4) * 40
        let c = sin(index * 1.7 + 2.2) * 18
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
                            PathwayHeader(
                                title: "The Gateless Gate",
                                completedDays: completedDays,
                                totalDays: totalDays
                            )
                            .id("header")
                            .padding(.top, Space.xxxl)
                            .padding(.bottom, Space.section)
                            
                            ZenGarden(
                                totalDays: totalDays,
                                completedDays: completedDays,
                                trackWidth: trackWidth,
                                stepY: stepY,
                                stoneOffset: stoneOffset,
                                isMilestone: isMilestone,
                                onSelectDay: { day in
                                    if day <= completedDays { selectedDay = day }
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

// MARK: - Header

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
                    .stroke(Color.sumiInk, style: StrokeStyle(lineWidth: 10, lineCap: .round))
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

// MARK: - Zen Garden

struct ZenGarden: View {
    let totalDays: Int
    let completedDays: Int
    let trackWidth: CGFloat
    let stepY: CGFloat
    let stoneOffset: (Int) -> CGFloat
    let isMilestone: (Int) -> Bool
    let onSelectDay: (Int) -> Void
    
    private var centerX: CGFloat { trackWidth / 2 }
    private var trackHeight: CGFloat { CGFloat(totalDays - 1) * stepY + 100 }
    
    var body: some View {
        ZStack {
            // Sand garden background
            RoundedRectangle(cornerRadius: 28)
                .fill(Color.sumiParchment.opacity(0.6))
                .frame(width: trackWidth, height: trackHeight)
                .overlay(
                    RoundedRectangle(cornerRadius: 28)
                        .stroke(Color.sumiBorder, lineWidth: 1)
                )
            
            // Moss patches
            MossPatch(x: 30, y: 200, size: 45)
            MossPatch(x: trackWidth - 40, y: 480, size: 55)
            MossPatch(x: 45, y: 800, size: 40)
            MossPatch(x: trackWidth - 35, y: 1150, size: 50)
            MossPatch(x: 35, y: 1500, size: 42)
            
            // Scattered gravel
            ForEach(0..<20) { i in
                GravelPebble(
                    x: gravelPositions[i].x,
                    y: gravelPositions[i].y,
                    size: gravelPositions[i].size
                )
            }
            
            // Stepping stones
            ForEach((1...totalDays).reversed(), id: \.self) { day in
                let index = totalDays - day
                let y = CGFloat(index) * stepY + 44
                let offset = stoneOffset(day)
                let x = centerX + offset
                let completed = day <= completedDays
                let current = day == completedDays + 1
                let milestone = isMilestone(day)
                
                SteppingStone(
                    day: day,
                    isCompleted: completed,
                    isCurrent: current,
                    isMilestone: milestone
                )
                .position(x: x, y: y)
                .onTapGesture { onSelectDay(day) }
                .id(day)
                
                if milestone {
                    MilestoneTag(
                        day: day, totalDays: totalDays,
                        isCompleted: completed, isCurrent: current
                    )
                    .position(
                        x: x + (offset > 10 ? -82 : (offset < -10 ? 82 : 82)),
                        y: y
                    )
                }
                
                if current && !milestone {
                    CurrentTag()
                        .position(
                            x: x + (offset > 0 ? -72 : 72),
                            y: y
                        )
                }
            }
            
            // Entrance gate at bottom
            VStack(spacing: 4) {
                HStack(spacing: 12) {
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color.sumiSand)
                        .frame(width: 4, height: 24)
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color.sumiSand)
                        .frame(width: 4, height: 24)
                }
                Text("Entrance")
                    .sumiTextStyle(.caption2)
                    .foregroundColor(.sumiQuaternaryText)
            }
            .position(x: centerX + stoneOffset(1), y: trackHeight - 32)
        }
        .frame(width: trackWidth, height: trackHeight)
    }
    
    private var gravelPositions: [(x: CGFloat, y: CGFloat, size: CGFloat)] {
        [
            (50, 120, 5), (280, 180, 4), (40, 340, 6), (290, 400, 5),
            (55, 560, 4), (270, 620, 6), (45, 780, 5), (285, 840, 4),
            (60, 950, 6), (275, 1020, 5), (50, 1180, 4), (290, 1250, 5),
            (40, 1380, 6), (280, 1420, 4), (55, 1580, 5), (270, 1620, 6),
            (48, 1780, 4), (285, 1820, 5), (52, 1950, 6), (278, 1980, 4)
        ]
    }
}

// MARK: - Decorations

struct MossPatch: View {
    let x: CGFloat
    let y: CGFloat
    let size: CGFloat
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.sumiMatcha.opacity(0.08))
                .frame(width: size, height: size)
            Circle()
                .fill(Color.sumiMatcha.opacity(0.06))
                .frame(width: size * 0.7, height: size * 0.7)
                .offset(x: 3, y: -2)
        }
        .position(x: x, y: y)
    }
}

struct GravelPebble: View {
    let x: CGFloat
    let y: CGFloat
    let size: CGFloat
    
    var body: some View {
        Ellipse()
            .fill(Color.sumiClay.opacity(0.25))
            .frame(width: size, height: size * 0.8)
            .rotationEffect(.degrees(Double.random(in: -40...40)))
            .position(x: x, y: y)
    }
}

// MARK: - Stepping Stone (Irregular organic shape)

struct SteppingStone: View {
    let day: Int
    let isCompleted: Bool
    let isCurrent: Bool
    let isMilestone: Bool
    
    @State private var pulseScale: CGFloat = 1.0
    
    var body: some View {
        ZStack {
            // Ambient glow for current
            if isCurrent {
                IrregularStoneShape(seed: day + 100)
                    .fill(Color.sumiPersimmon.opacity(0.12))
                    .frame(width: stoneW + 22, height: stoneH + 18)
                    .scaleEffect(pulseScale)
            }
            
            // Milestone torii-style ring
            if isMilestone {
                IrregularStoneShape(seed: day + 50)
                    .stroke(milestoneRingColor, lineWidth: 2.5)
                    .frame(width: stoneW + 14, height: stoneH + 12)
            }
            
            // Stone body with 3D effect
            ZStack {
                // Bottom shadow (stone sitting in sand)
                IrregularStoneShape(seed: day)
                    .fill(Color.sumiInk.opacity(0.06))
                    .frame(width: stoneW + 2, height: stoneH + 2)
                    .offset(y: 2)
                
                // Main stone surface
                IrregularStoneShape(seed: day)
                    .fill(stoneFill)
                    .frame(width: stoneW, height: stoneH)
                
                // Top highlight for 3D depth
                IrregularStoneShape(seed: day)
                    .fill(Color.white.opacity(highlightOpacity))
                    .frame(width: stoneW * 0.55, height: stoneH * 0.35)
                    .offset(x: -stoneW * 0.08, y: -stoneH * 0.12)
                    .blendMode(.overlay)
                
                // Bottom shade
                IrregularStoneShape(seed: day)
                    .fill(Color.black.opacity(shadeOpacity))
                    .frame(width: stoneW * 0.7, height: stoneH * 0.4)
                    .offset(x: stoneW * 0.05, y: stoneH * 0.15)
                    .blendMode(.multiply)
            }
            .shadow(color: shadowColor, radius: shadowRadius, x: 0, y: shadowY)
            
            // Content
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
        }
        .frame(width: max(stoneW, stoneH) + 24, height: max(stoneW, stoneH) + 24)
        .contentShape(Rectangle())
        .onAppear {
            if isCurrent {
                withAnimation(.easeInOut(duration: 2.0).repeatForever(autoreverses: true)) {
                    pulseScale = 1.3
                }
            }
        }
    }
    
    var stoneW: CGFloat {
        if isCurrent { return 60 }
        if isCompleted { return 46 }
        return 38
    }
    
    var stoneH: CGFloat {
        if isCurrent { return 50 }
        if isCompleted { return 40 }
        return 32
    }
    
    var stoneFill: Color {
        if isCompleted {
            return Color.sumiInk
        }
        if isCurrent {
            return Color.sumiPersimmon
        }
        return Color.sumiCardSurface
    }
    
    var milestoneRingColor: Color {
        if isCompleted { return Color.sumiMatcha.opacity(0.5) }
        if isCurrent { return Color.sumiPersimmon.opacity(0.5) }
        return Color.sumiSand
    }
    
    var highlightOpacity: Double {
        if isCompleted { return 0.08 }
        if isCurrent { return 0.12 }
        return 0.15
    }
    
    var shadeOpacity: Double {
        if isCompleted { return 0.15 }
        if isCurrent { return 0.12 }
        return 0.06
    }
    
    var shadowColor: Color {
        if isCurrent { return Color.sumiPersimmon.opacity(0.22) }
        if isCompleted { return Color.sumiInk.opacity(0.18) }
        return Color.sumiInk.opacity(0.08)
    }
    
    var shadowRadius: CGFloat {
        if isCurrent { return 12 }
        if isCompleted { return 8 }
        return 4
    }
    
    var shadowY: CGFloat {
        if isCurrent { return 6 }
        if isCompleted { return 4 }
        return 2
    }
}

// MARK: - Irregular Stone Shape

struct IrregularStoneShape: Shape {
    let seed: Int
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let cx = rect.midX
        let cy = rect.midY
        let rx = rect.width / 2
        let ry = rect.height / 2
        let points = 10
        
        var vertices: [CGPoint] = []
        for i in 0..<points {
            let angle = Double(i) * 2 * .pi / Double(points) - .pi / 2
            // Deterministic "randomness" based on seed
            let variance = 0.18 * sin(Double(seed + i * 7) * 0.87)
            let rxi = rx * (1.0 + variance)
            let ryi = ry * (1.0 + variance * 0.7)
            let x = cx + cos(angle) * rxi
            let y = cy + sin(angle) * ryi
            vertices.append(CGPoint(x: x, y: y))
        }
        
        // Smooth through vertices using catmull-rom-like curves
        path.move(to: vertices[0])
        for i in 0..<points {
            let curr = vertices[i]
            let next = vertices[(i + 1) % points]
            let mid = CGPoint(x: (curr.x + next.x) / 2, y: (curr.y + next.y) / 2)
            path.addQuadCurve(to: mid, control: curr)
        }
        path.closeSubpath()
        return path
    }
}

// MARK: - Tags

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
