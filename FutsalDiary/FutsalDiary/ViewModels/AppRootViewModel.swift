import Foundation
import Combine

final class AppRootViewModel: ObservableObject {
    enum RootState {
        case splash
        case unauthenticated
        case authenticated(User)
    }

    @Published private(set) var state: RootState = .splash
    @Published var splashViewModel = SplashViewModel()

    let authService: AuthService
    let entryService: TrainingEntryService

    init(
        authService: AuthService = AuthService(),
        entryService: TrainingEntryService = TrainingEntryService()
    ) {
        self.authService = authService
        self.entryService = entryService
        start()
    }

    func start() {
        splashViewModel.start { [weak self] in
            guard let self else { return }
            if let user = authService.currentUser {
                state = .authenticated(user)
            } else {
                state = .unauthenticated
            }
        }
    }

    func completeLogin(with user: User) {
        state = .authenticated(user)
    }

    func logout() {
        authService.logout()
        state = .unauthenticated
    }
}
