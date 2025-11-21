import Foundation

final class LoginViewModel: ObservableObject {
    @Published var email: String = "player@example.com"
    @Published var password: String = "futsal"
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false

    private let authService: AuthService

    init(authService: AuthService) {
        self.authService = authService
    }

    func login(completion: @escaping (Result<User, AuthError>) -> Void) {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { [weak self] in
            guard let self else { return }
            let result = self.authService.login(email: self.email, password: self.password)
            self.isLoading = false
            if case .failure(let error) = result {
                self.errorMessage = error.localizedDescription
            } else {
                self.errorMessage = nil
            }
            completion(result)
        }
    }
}
