import Foundation

@MainActor
final class SplashViewModel: ObservableObject {
    @Published private(set) var isFinished: Bool = false

    func start() {
        // Simulate a minimal delay so the splash screen can be displayed.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) { [weak self] in
            self?.isFinished = true
        }
    }
}
