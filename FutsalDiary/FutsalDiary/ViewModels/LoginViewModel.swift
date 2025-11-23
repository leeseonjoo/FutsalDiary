import Foundation

@MainActor
final class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published private(set) var isLoggingIn: Bool = false
    @Published private(set) var errorMessage: String?

    private let service: AuthService

    init(service: AuthService = AuthService()) {
        self.service = service
    }

    func login() async {
        isLoggingIn = true
        errorMessage = nil
        defer { isLoggingIn = false }

        do {
            _ = try await service.login(username: username, password: password)
        } catch {
            errorMessage = "로그인에 실패했습니다."
        }
    }
}
