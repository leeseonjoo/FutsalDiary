import Foundation

final class SplashViewModel: ObservableObject {
    @Published var isCompleted: Bool = false
    private let duration: TimeInterval

    init(duration: TimeInterval = 0.6) {
        self.duration = duration
    }

    func start(completion: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) { [weak self] in
            self?.isCompleted = true
            completion()
        }
    }
}
