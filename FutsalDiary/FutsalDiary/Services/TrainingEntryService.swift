import Foundation

/// Simple in-memory storage for training entries so the UI can be compiled and
/// previewed without a backend.
final class TrainingEntryService: ObservableObject {
    @Published private(set) var entries: [TrainingEntry]

    init(entries: [TrainingEntry] = [TrainingEntry.sample]) {
        self.entries = entries
    }

    func add(_ entry: TrainingEntry) {
        entries.append(entry)
    }

    func update(_ entry: TrainingEntry) {
        guard let index = entries.firstIndex(where: { $0.id == entry.id }) else { return }
        entries[index] = entry
    }

    func remove(_ entry: TrainingEntry) {
        entries.removeAll { $0.id == entry.id }
    }
}
