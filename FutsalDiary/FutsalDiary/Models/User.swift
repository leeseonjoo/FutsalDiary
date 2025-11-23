import Foundation

/// Represents an app user. The type is intentionally lightweight so views and
/// view models can depend on it without adding business logic that is still
/// undefined in this prototype phase.
struct User: Identifiable, Codable, Equatable {
    let id: UUID
    var username: String
    var displayName: String
    var email: String
    var createdAt: Date

    static let placeholder = User(
        id: UUID(),
        username: "guest",
        displayName: "게스트",
        email: "guest@example.com",
        createdAt: Date()
    )
}
