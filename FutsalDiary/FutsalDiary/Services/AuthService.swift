import Foundation

/// A tiny in-memory auth service used to unblock UI development.
final class AuthService {
    private var storedUsers: [User] = [
        .init(id: UUID(), username: "admin", displayName: "관리자", email: "admin@example.com", createdAt: Date())
    ]

    func login(username: String, password: String) async throws -> User {
        // In a real implementation the password would be verified server-side.
        guard let user = storedUsers.first(where: { $0.username == username }) else {
            throw AuthServiceError.invalidCredentials
        }
        return user
    }

    func register(username: String, email: String, displayName: String) async throws -> User {
        let newUser = User(id: UUID(), username: username, displayName: displayName, email: email, createdAt: Date())
        storedUsers.append(newUser)
        return newUser
    }
}

enum AuthServiceError: Error {
    case invalidCredentials
}
