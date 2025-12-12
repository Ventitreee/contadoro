import SwiftUI

enum Theme {
    static let neonPink = Color(red: 0.98, green: 0.23, blue: 0.68)
    static let neonGreen = Color(red: 0.22, green: 0.96, blue: 0.55)
    static let deepPurple = Color(red: 0.19, green: 0.08, blue: 0.38)
    static let mustard = Color(red: 0.98, green: 0.83, blue: 0.23)
    static let teal = Color(red: 0.05, green: 0.76, blue: 0.82)
    static let background = LinearGradient(
        colors: [deepPurple, Color(red: 0.14, green: 0.08, blue: 0.26)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}
