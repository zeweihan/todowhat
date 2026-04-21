import SwiftUI

// MARK: - Hex Initialization helper
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// MARK: - UIColor dynamic provider helper
extension Color {
    init(light lightHex: String, dark darkHex: String) {
        self.init(UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? UIColor(Color(hex: darkHex)) : UIColor(Color(hex: lightHex))
        })
    }
}

// MARK: - SumiDay Brand Colors
extension Color {
    /// Screen background. Light: Washi (#F2EDE4), Dark: Sumi Ink (#1A1614)
    static let sumiBackground = Color(light: "#F2EDE4", dark: "#1A1614")
    
    /// Card surface. Light: White, Dark: Washi Dark (#2A2420)
    static let sumiCardSurface = Color(light: "#FFFFFF", dark: "#2A2420")
    
    /// Primary text. Light: Sumi Ink (#1A1614), Dark: Washi (#F2EDE4)
    static let sumiPrimaryText = Color(light: "#1A1614", dark: "#F2EDE4")
    
    /// Secondary text.
    static let sumiSecondaryText = Color(light: "#1A1614CC", dark: "#F2EDE4CC")
    
    /// Tertiary text.
    static let sumiTertiaryText = Color(light: "#1A161466", dark: "#F2EDE466")
    
    /// Dividers and hairlines.
    static let sumiDivider = Color(light: "#1A161414", dark: "#F2EDE414")
    
    /// Primary action and positive states. Matcha.
    static let sumiMatcha = Color(light: "#6B8F71", dark: "#7FA882")
    
    /// Matcha Light (15% opacity overlay for badges/progress).
    static let sumiMatchaLight = Color(light: "#6B8F7126", dark: "#7FA88226")
    
    /// Persimmon (Use sparingly! Ink mark / notifications / primary button).
    static let sumiPersimmon = Color(light: "#C65D2A", dark: "#D4703A")
    
    /// Persimmon overlay for button pressed states.
    static let sumiPersimmonLight = Color(light: "#C65D2A1A", dark: "#D4703A1A")
}
