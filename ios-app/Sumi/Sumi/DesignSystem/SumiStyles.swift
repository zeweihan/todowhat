import SwiftUI

// MARK: - Card Modifiers
struct SumiCardModifier: ViewModifier {
    var style: CardStyle = .default
    var padding: CGFloat = Space.lg
    
    enum CardStyle {
        case `default`      // White/off-white with subtle border
        case elevated       // + shadow for floating feel
        case filled         // Secondary background, no border
        case prominent      // Elevated + stronger border
    }
    
    func body(content: Content) -> some View {
        switch style {
        case .default:
            content
                .padding(padding)
                .background(Color.sumiCardSurface)
                .cornerRadius(Radius.xl)
                .overlay(
                    RoundedRectangle(cornerRadius: Radius.xl)
                        .stroke(Color.sumiBorder, lineWidth: 1)
                )
        case .elevated:
            content
                .padding(padding)
                .background(Color.sumiCardSurface)
                .cornerRadius(Radius.xl)
                .sumiShadow(SumiShadow.medium)
                .overlay(
                    RoundedRectangle(cornerRadius: Radius.xl)
                        .stroke(Color.sumiBorder, lineWidth: 0.5)
                )
        case .filled:
            content
                .padding(padding)
                .background(Color.sumiCardSurfaceSecondary)
                .cornerRadius(Radius.xl)
        case .prominent:
            content
                .padding(padding)
                .background(Color.sumiCardSurfaceElevated)
                .cornerRadius(Radius.xl)
                .sumiShadow(SumiShadow.large)
                .overlay(
                    RoundedRectangle(cornerRadius: Radius.xl)
                        .stroke(Color.sumiBorderStrong, lineWidth: 1)
                )
        }
    }
}

extension View {
    func sumiCard(style: SumiCardModifier.CardStyle = .default, padding: CGFloat = Space.lg) -> some View {
        modifier(SumiCardModifier(style: style, padding: padding))
    }
}

// MARK: - Button Styles
struct SumiPrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .sumiTextStyle(.cardTitle)
            .foregroundColor(.washi)
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(Color.sumiPersimmon)
            .cornerRadius(Radius.lg)
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .opacity(configuration.isPressed ? 0.92 : 1.0)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct SumiSecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .sumiTextStyle(.cardTitle)
            .foregroundColor(.sumiPrimaryText)
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(Color.sumiCardSurface)
            .cornerRadius(Radius.lg)
            .overlay(
                RoundedRectangle(cornerRadius: Radius.lg)
                    .stroke(Color.sumiBorderStrong, lineWidth: 1)
            )
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct SumiGhostButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .sumiTextStyle(.body)
            .foregroundColor(.sumiSecondaryText)
            .padding(.vertical, Space.md)
            .padding(.horizontal, Space.lg)
            .background(Color.sumiInk.opacity(configuration.isPressed ? 0.04 : 0))
            .cornerRadius(Radius.md)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}

struct SumiScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .opacity(configuration.isPressed ? 0.9 : 1.0)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

// MARK: - Entrance Animations
struct SumiEntranceModifier: ViewModifier {
    let delay: Double
    let offset: CGFloat
    @State private var isVisible = false
    
    func body(content: Content) -> some View {
        content
            .opacity(isVisible ? 1 : 0)
            .offset(y: isVisible ? 0 : offset)
            .animation(.spring(response: 0.55, dampingFraction: 0.85).delay(delay), value: isVisible)
            .onAppear {
                isVisible = true
            }
    }
}

struct SumiStaggeredListModifier: ViewModifier {
    let baseDelay: Double
    let index: Int
    @State private var isVisible = false
    
    func body(content: Content) -> some View {
        content
            .opacity(isVisible ? 1 : 0)
            .offset(y: isVisible ? 0 : 12)
            .animation(.spring(response: 0.5, dampingFraction: 0.8).delay(baseDelay + Double(index) * 0.06), value: isVisible)
            .onAppear {
                isVisible = true
            }
    }
}

extension View {
    func sumiEntrance(delay: Double = 0, offset: CGFloat = 20) -> some View {
        modifier(SumiEntranceModifier(delay: delay, offset: offset))
    }
    
    func sumiStaggered(index: Int, baseDelay: Double = 0.1) -> some View {
        modifier(SumiStaggeredListModifier(baseDelay: baseDelay, index: index))
    }
}

// MARK: - Page Background
struct SumiPageBackground: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            Color.sumiBackground.ignoresSafeArea()
            content
        }
    }
}

extension View {
    func sumiPageBackground() -> some View {
        modifier(SumiPageBackground())
    }
}

// MARK: - Divider
struct SumiDivider: View {
    var body: some View {
        Rectangle()
            .fill(Color.sumiDivider)
            .frame(height: 1)
    }
}

// MARK: - Selection Ring
struct SumiSelectionRing: ViewModifier {
    var isSelected: Bool
    
    func body(content: Content) -> some View {
        content
            .overlay(
                RoundedRectangle(cornerRadius: Radius.xl)
                    .stroke(isSelected ? Color.sumiMatcha : Color.clear, lineWidth: 2)
            )
            .overlay(
                RoundedRectangle(cornerRadius: Radius.xl)
                    .fill(isSelected ? Color.sumiMatcha.opacity(0.04) : Color.clear)
            )
    }
}

extension View {
    func sumiSelectionRing(isSelected: Bool) -> some View {
        modifier(SumiSelectionRing(isSelected: isSelected))
    }
}
