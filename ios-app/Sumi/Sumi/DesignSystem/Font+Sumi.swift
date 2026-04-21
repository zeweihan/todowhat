import SwiftUI

// MARK: - SumiDay Typography
extension Font {
    
    enum SumiTextStyle {
        /// App Name / Hero (New York, Regular, 34pt)
        case hero
        /// Passage Text (New York, Regular, 20pt)
        case passage
        /// Section Header (New York, Medium, 22pt)
        case sectionHeader
        /// Card Title (SF Pro, Semibold, 17pt)
        case cardTitle
        /// Body / Caption (SF Pro, Regular, 15pt)
        case body
        /// Label / Tag (SF Pro, Medium, 13pt)
        case label
        /// Citation / Mono (SF Mono, Regular, 13pt)
        case citation
        /// Micro / Legal (SF Pro, Regular, 11pt)
        case micro
    }
    
    static func sumi(_ style: SumiTextStyle) -> Font {
        switch style {
        case .hero:
            return Font.custom("NewYork-Regular", size: 34) // Requires standard setup or fallback to system serif
        case .passage:
            return Font.custom("NewYork-Regular", size: 20)
        case .sectionHeader:
            return Font.custom("NewYork-Medium", size: 22)
        case .cardTitle:
            return Font.system(size: 17, weight: .semibold, design: .default)
        case .body:
            return Font.system(size: 15, weight: .regular, design: .default)
        case .label:
            return Font.system(size: 13, weight: .medium, design: .default)
        case .citation:
            return Font.system(size: 13, weight: .regular, design: .monospaced)
        case .micro:
            return Font.system(size: 11, weight: .regular, design: .default)
        }
    }
}

// MARK: - Typography View Modifiers for correct line height and tracking
struct SumiTextModifier: ViewModifier {
    let style: Font.SumiTextStyle
    
    func body(content: Content) -> some View {
        switch style {
        case .hero:
            content
                .font(.sumi(.hero))
                .lineSpacing(41 - 34)
                .tracking(-0.5)
        case .passage:
            content
                .font(.sumi(.passage))
                .lineSpacing(32 - 20) // PRD: 32pt line height
                .tracking(-0.3)
        case .sectionHeader:
            content
                .font(.sumi(.sectionHeader))
                .lineSpacing(28 - 22)
                .tracking(-0.2)
        case .cardTitle:
            content
                .font(.sumi(.cardTitle))
                .lineSpacing(22 - 17)
                .tracking(-0.4)
        case .body:
            content
                .font(.sumi(.body))
                .lineSpacing(22 - 15)
                .tracking(-0.2)
        case .label:
            content
                .font(.sumi(.label))
                .lineSpacing(18 - 13)
        case .citation:
            content
                .font(.sumi(.citation))
                .lineSpacing(18 - 13)
        case .micro:
            content
                .font(.sumi(.micro))
                .lineSpacing(16 - 11)
        }
    }
}

extension View {
    func sumiTextStyle(_ style: Font.SumiTextStyle) -> some View {
        self.modifier(SumiTextModifier(style: style))
    }
}
