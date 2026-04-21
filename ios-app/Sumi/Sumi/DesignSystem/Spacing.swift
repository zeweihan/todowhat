import SwiftUI

// Spacing System based on visual-system.md
struct Space {
    static let xs: CGFloat = 4
    static let sm: CGFloat = 8
    static let md: CGFloat = 16
    static let lg: CGFloat = 24
    static let xl: CGFloat = 32
    static let xxl: CGFloat = 48
    static let section: CGFloat = 64
}

// Additional derived color palettes from visual-system.md
extension Color {
    static let sumi80 = Color.sumiInk.opacity(0.8)
    static let sumi40 = Color.sumiInk.opacity(0.4)
    static let sumi08 = Color.sumiInk.opacity(0.08)
    
    static let matchaLight = Color.matcha.opacity(0.15)
    static let persimmonLight = Color.persimmon.opacity(0.10)
}
