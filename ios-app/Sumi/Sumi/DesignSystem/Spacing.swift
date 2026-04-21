import SwiftUI

// MARK: - Spacing System
struct Space {
    static let xxs: CGFloat = 2
    static let xs: CGFloat = 4
    static let sm: CGFloat = 8
    static let md: CGFloat = 12
    static let lg: CGFloat = 16
    static let xl: CGFloat = 20
    static let xxl: CGFloat = 24
    static let xxxl: CGFloat = 32
    static let section: CGFloat = 40
    static let sectionLarge: CGFloat = 56
    static let screenEdge: CGFloat = 20
}

// MARK: - Corner Radius System
struct Radius {
    static let sm: CGFloat = 8
    static let md: CGFloat = 12
    static let lg: CGFloat = 16
    static let xl: CGFloat = 20
    static let xxl: CGFloat = 24
    static let pill: CGFloat = 999
}

// MARK: - Shadow System (Layered elements)
struct SumiShadow {
    static let small = ShadowStyle(color: Color.sumiShadow.opacity(0.04), radius: 8, x: 0, y: 4)
    static let medium = ShadowStyle(color: Color.sumiShadow.opacity(0.06), radius: 16, x: 0, y: 8)
    static let large = ShadowStyle(color: Color.sumiShadow.opacity(0.08), radius: 24, x: 0, y: 12)
    static let extraLarge = ShadowStyle(color: Color.sumiShadow.opacity(0.10), radius: 32, x: 0, y: 16)
}

struct ShadowStyle {
    let color: Color
    let radius: CGFloat
    let x: CGFloat
    let y: CGFloat
}

extension View {
    func sumiShadow(_ style: ShadowStyle) -> some View {
        self.shadow(color: style.color, radius: style.radius, x: style.x, y: style.y)
    }
}
