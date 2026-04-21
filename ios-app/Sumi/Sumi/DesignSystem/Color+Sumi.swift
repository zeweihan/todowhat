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
    // MARK: Backgrounds (Muted postal washi layers)
    static let sumiBackground = Color(light: "#F2EDE4", dark: "#1A1614")
    static let sumiBackgroundSecondary = Color(light: "#EBE7DE", dark: "#231F1B")
    static let sumiBackgroundTertiary = Color(light: "#E5E1D7", dark: "#2C2621")
    
    // MARK: Card Surfaces (Layered elements for card-based design)
    static let sumiCardSurface = Color(light: "#FFFFFF", dark: "#2A2420")
    static let sumiCardSurfaceSecondary = Color(light: "#FAF8F4", dark: "#332C27")
    static let sumiCardSurfaceTertiary = Color(light: "#F5F2EC", dark: "#3A332D")
    static let sumiCardSurfaceElevated = Color(light: "#FFFFFF", dark: "#35302A")
    
    // MARK: Text (Monochromatic ink scale)
    static let sumiPrimaryText = Color(light: "#1A1614", dark: "#F2EDE4")
    static let sumiSecondaryText = Color(light: "#5A544D", dark: "#B5ADA3")
    static let sumiTertiaryText = Color(light: "#9A938A", dark: "#8C857B")
    static let sumiQuaternaryText = Color(light: "#B5ADA3", dark: "#6A645C")
    
    // MARK: Dividers and borders
    static let sumiDivider = Color(light: "#1A16140D", dark: "#F2EDE40D")
    static let sumiBorder = Color(light: "#1A16140F", dark: "#F2EDE40F")
    static let sumiBorderStrong = Color(light: "#1A16141A", dark: "#F2EDE41A")
    
    // MARK: Accent colors (Used sparingly)
    static let sumiMatcha = Color(light: "#6B8F71", dark: "#7FA882")
    static let sumiMatchaLight = Color(light: "#6B8F711A", dark: "#7FA8821A")
    static let sumiMatchaMuted = Color(light: "#E8F0E9", dark: "#2A3D2C")
    
    static let sumiPersimmon = Color(light: "#C65D2A", dark: "#D4703A")
    static let sumiPersimmonLight = Color(light: "#C65D2A1A", dark: "#D4703A1A")
    static let sumiPersimmonMuted = Color(light: "#F5E8E0", dark: "#4A2A1A")
    
    // MARK: Muted postal palette (Monochromatic warmth)
    static let sumiStone = Color(light: "#8C857B", dark: "#A69E93")
    static let sumiSand = Color(light: "#D9D4CA", dark: "#5A544D")
    static let sumiWarmGray = Color(light: "#B5ADA3", dark: "#8C857B")
    static let sumiParchment = Color(light: "#F7F5F0", dark: "#2E2822")
    static let sumiClay = Color(light: "#C4BDB3", dark: "#7A7369")
    
    // MARK: Shadow
    static let sumiShadow = Color(light: "#1A1614", dark: "#000000")
}
