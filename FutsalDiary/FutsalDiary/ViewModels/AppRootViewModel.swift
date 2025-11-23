import Foundation

/// Coordinates the high level navigation states of the app.
@MainActor
final class AppRootViewModel: ObservableObject {
    enum AppState {
        case splash
        case authenticated(User)
        case loggedOut
    }

    @Published private(set) var state: AppState = .splash
    private let authService: AuthService

    init(authService: AuthService = AuthService()) {
        self.authService = authService
    }

    func completeSplash() {
        // For now, always go to login. This can be expanded when persistence is
        // added.
        state = .loggedOut
    }

    func setAuthenticated(user: User) {
        state = .authenticated(user)
    }
}
