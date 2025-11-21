import Foundation
import Combine

enum AuthError: LocalizedError {
    case missingFields
    case invalidCredentials

    var errorDescription: String? {
        switch self {
        case .missingFields:
            return "이메일과 비밀번호를 입력해주세요."
        case .invalidCredentials:
            return "이메일 또는 비밀번호가 올바르지 않습니다."
        }
    }
}

final class AuthService: ObservableObject {
    @Published private(set) var currentUser: User?

    init(currentUser: User? = nil) {
        self.currentUser = currentUser
    }

    func login(email: String, password: String) -> Result<User, AuthError> {
        guard !email.isEmpty, !password.isEmpty else {
            return .failure(.missingFields)
        }

        // 데모용 간단 검증
        guard password.count >= 4 else {
            return .failure(.invalidCredentials)
        }

        let user = User(email: email, displayName: email.components(separatedBy: "@").first ?? "사용자")
        currentUser = user
        return .success(user)
    }

    func signUp(email: String, password: String, displayName: String) -> Result<User, AuthError> {
        guard !email.isEmpty, !password.isEmpty, !displayName.isEmpty else {
            return .failure(.missingFields)
        }

        let user = User(email: email, displayName: displayName)
        currentUser = user
        return .success(user)
    }

    func logout() {
        currentUser = nil
    }
}
