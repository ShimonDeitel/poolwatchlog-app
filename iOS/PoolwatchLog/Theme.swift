import SwiftUI

/// Bespoke palette for Poolwatch Log — tuned for its own domain, not shared.
enum Theme {
    static let accent = Color(red: 0.05, green: 0.45, blue: 0.65)
    static let accentSoft = Color(red: 0.30, green: 0.80, blue: 0.90)
    static let background = Color(red: 0.03, green: 0.08, blue: 0.11)
    static let card = Color(red: 0.03, green: 0.08, blue: 0.11).opacity(0.92)

    static let titleFont = Font.system(.largeTitle, design: .serif).weight(.bold)
    static let headlineFont = Font.system(.headline, design: .rounded)
    static let bodyFont = Font.system(.body, design: .rounded)
    static let captionFont = Font.system(.caption, design: .rounded)
}
