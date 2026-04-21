import SwiftUI

// MARK: - SumiDay Typography
extension Font {
    
    enum SumiTextStyle {
        // Display / Hero
        case display       // 48pt, New York, tight tracking
        case hero          // 34pt, New York
        case largeTitle    // 32pt, New York
        
        // Headings
        case title         // 28pt, New York Medium
        case title2        // 22pt, New York Medium
        case title3        // 20pt, New York Regular
        
        // UI Text
        case cardTitle     // 17pt, SF Pro Semibold
        case bodyLarge     // 17pt, SF Pro Regular
        case body          // 15pt, SF Pro Regular
        case callout       // 14pt, SF Pro Medium
        case subheadline   // 13pt, SF Pro Regular
        case caption       // 12pt, SF Pro Medium
        case caption2      // 11pt, SF Pro Regular
        
        // Special
        case label         // 13pt, SF Pro Medium, uppercase tracking
        case citation      // 12pt, SF Mono Regular
        case passage       // 20pt, New York Regular (for longform reading)
    }
    
    static func sumi(_ style: SumiTextStyle) -> Font {
        switch style {
        case .display:
            return Font.custom("NewYork-Regular", size: 48).fallback(to: .system(size: 48, weight: .regular, design: .serif))
        case .hero:
            return Font.custom("NewYork-Regular", size: 34).fallback(to: .system(size: 34, weight: .regular, design: .serif))
        case .largeTitle:
            return Font.custom("NewYork-Regular", size: 32).fallback(to: .system(size: 32, weight: .regular, design: .serif))
        case .title:
            return Font.custom("NewYork-Medium", size: 28).fallback(to: .system(size: 28, weight: .medium, design: .serif))
        case .title2:
            return Font.custom("NewYork-Medium", size: 22).fallback(to: .system(size: 22, weight: .medium, design: .serif))
        case .title3:
            return Font.custom("NewYork-Regular", size: 20).fallback(to: .system(size: 20, weight: .regular, design: .serif))
        case .cardTitle:
            return Font.system(size: 17, weight: .semibold, design: .default)
        case .bodyLarge:
            return Font.system(size: 17, weight: .regular, design: .default)
        case .body:
            return Font.system(size: 15, weight: .regular, design: .default)
        case .callout:
            return Font.system(size: 14, weight: .medium, design: .default)
        case .subheadline:
            return Font.system(size: 13, weight: .regular, design: .default)
        case .caption:
            return Font.system(size: 12, weight: .medium, design: .default)
        case .caption2:
            return Font.system(size: 11, weight: .regular, design: .default)
        case .label:
            return Font.system(size: 13, weight: .medium, design: .default)
        case .citation:
            return Font.system(size: 12, weight: .regular, design: .monospaced)
        case .passage:
            return Font.custom("NewYork-Regular", size: 20).fallback(to: .system(size: 20, weight: .regular, design: .serif))
        }
    }
}

// MARK: - Font fallback helper
private extension Font {
    func fallback(to font: Font) -> Font {
        // SwiftUI will automatically fall back if custom font is unavailable
        // This is a semantic wrapper for clarity
        return self
    }
}

// MARK: - Typography View Modifiers
struct SumiTextModifier: ViewModifier {
    let style: Font.SumiTextStyle
    
    func body(content: Content) -> some View {
        switch style {
        case .display:
            content
                .font(.sumi(.display))
                .lineSpacing(52 - 48)
                .tracking(-1.0)
        case .hero:
            content
                .font(.sumi(.hero))
                .lineSpacing(40 - 34)
                .tracking(-0.5)
        case .largeTitle:
            content
                .font(.sumi(.largeTitle))
                .lineSpacing(38 - 32)
                .tracking(-0.4)
        case .title:
            content
                .font(.sumi(.title))
                .lineSpacing(34 - 28)
                .tracking(-0.3)
        case .title2:
            content
                .font(.sumi(.title2))
                .lineSpacing(28 - 22)
                .tracking(-0.2)
        case .title3:
            content
                .font(.sumi(.title3))
                .lineSpacing(28 - 20)
                .tracking(-0.2)
        case .cardTitle:
            content
                .font(.sumi(.cardTitle))
                .lineSpacing(22 - 17)
                .tracking(-0.4)
        case .bodyLarge:
            content
                .font(.sumi(.bodyLarge))
                .lineSpacing(24 - 17)
                .tracking(-0.2)
        case .body:
            content
                .font(.sumi(.body))
                .lineSpacing(22 - 15)
                .tracking(-0.2)
        case .callout:
            content
                .font(.sumi(.callout))
                .lineSpacing(20 - 14)
                .tracking(-0.1)
        case .subheadline:
            content
                .font(.sumi(.subheadline))
                .lineSpacing(18 - 13)
        case .caption:
            content
                .font(.sumi(.caption))
                .lineSpacing(16 - 12)
                .tracking(0.0)
        case .caption2:
            content
                .font(.sumi(.caption2))
                .lineSpacing(14 - 11)
                .tracking(0.2)
        case .label:
            content
                .font(.sumi(.label))
                .lineSpacing(18 - 13)
                .tracking(0.5)
                .textCase(.uppercase)
        case .citation:
            content
                .font(.sumi(.citation))
                .lineSpacing(16 - 12)
                .tracking(0.0)
        case .passage:
            content
                .font(.sumi(.passage))
                .lineSpacing(32 - 20)
                .tracking(-0.3)
        }
    }
}

extension View {
    func sumiTextStyle(_ style: Font.SumiTextStyle) -> some View {
        self.modifier(SumiTextModifier(style: style))
    }
}
