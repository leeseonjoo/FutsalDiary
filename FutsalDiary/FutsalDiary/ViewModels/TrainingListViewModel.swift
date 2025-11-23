import Foundation

@MainActor
final class TrainingListViewModel: ObservableObject {
    @Published private(set) var entries: [TrainingEntry] = []

    private let service: TrainingEntryService

    init(service: TrainingEntryService = TrainingEntryService()) {
        self.service = service
        entries = service.entries
    }

    func refresh() {
        entries = service.entries
    }
}
