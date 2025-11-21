import Foundation

final class TrainingEntryService: ObservableObject {
    @Published private(set) var entries: [TrainingEntry]

    init(entries: [TrainingEntry] = TrainingEntry.mock) {
        self.entries = entries
    }

    func fetchEntries() -> [TrainingEntry] {
        entries.sorted { $0.date > $1.date }
    }

    func entries(on date: Date) -> [TrainingEntry] {
        let calendar = Calendar.current
        return entries.filter { calendar.isDate($0.date, inSameDayAs: date) }
    }

    func save(entry: TrainingEntry) {
        if let index = entries.firstIndex(where: { $0.id == entry.id }) {
            entries[index] = entry
        } else {
            entries.append(entry)
        }
    }

    func delete(entryID: UUID) {
        entries.removeAll { $0.id == entryID }
    }
}
