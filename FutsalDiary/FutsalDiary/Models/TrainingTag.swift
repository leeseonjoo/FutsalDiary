import Foundation
import SwiftUI

struct TrainingTag: Identifiable, Hashable {
    let id: UUID
    let name: String
    let color: Color

    init(id: UUID = UUID(), name: String, color: Color = .blue) {
        self.id = id
        self.name = name
        self.color = color
    }
}

extension TrainingTag {
    static let cardio = TrainingTag(name: "피지컬", color: .pink)
    static let tactics = TrainingTag(name: "전술", color: .green)
    static let recovery = TrainingTag(name: "회복", color: .orange)
}
