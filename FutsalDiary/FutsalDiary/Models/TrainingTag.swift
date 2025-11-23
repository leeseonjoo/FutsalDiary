import Foundation
import SwiftUI

/// A lightweight tag that can be attached to training entries for quick
/// filtering.
struct TrainingTag: Identifiable, Hashable, Codable {
    let id: UUID
    var name: String
    var colorHex: String

    init(id: UUID = UUID(), name: String, color: Color) {
        self.id = id
        self.name = name
        self.colorHex = color.toHex() ?? "#6C7A89"
    }
}

private extension Color {
    /// Returns a hex string representation if available. This keeps the model
    /// serializable even though we use `Color` in the UI layer.
    func toHex() -> String? {
        #if canImport(UIKit)
        let uiColor = UIColor(self)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        guard uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else { return nil }
        return String(format: "#%02lX%02lX%02lX", lroundf(Float(red * 255)), lroundf(Float(green * 255)), lroundf(Float(blue * 255)))
        #else
        return nil
        #endif
    }
}
