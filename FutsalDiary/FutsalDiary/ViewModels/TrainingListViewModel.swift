import Foundation

final class TrainingListViewModel: ObservableObject {
    @Published private(set) var entries: [TrainingEntry] = []
    @Published var selectedTag: TrainingTag?

    private let entryService: TrainingEntryService

    init(entryService: TrainingEntryService) {
        self.entryService = entryService
        loadEntries()
    }

    func loadEntries() {
        entries = entryService.fetchEntries()
    }

    func remove(at offsets: IndexSet) {
        offsets.map { entries[$0].id }.forEach(entryService.delete(entryID:))
        loadEntries()
    }

    func filteredEntries() -> [TrainingEntry] {
        guard let tag = selectedTag else { return entries }
        return entries.filter { $0.tags.contains(tag) }
    }
}
