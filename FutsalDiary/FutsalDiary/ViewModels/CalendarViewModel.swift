import Foundation

@MainActor
final class CalendarViewModel: ObservableObject {
    @Published var selectedDate: Date = Date()
    @Published private(set) var entriesByDate: [Date: [TrainingEntry]] = [:]

    private let calendar = Calendar.current
    private let service: TrainingEntryService

    init(service: TrainingEntryService = TrainingEntryService()) {
        self.service = service
        rebuildIndex()
    }

    func select(date: Date) {
        selectedDate = calendar.startOfDay(for: date)
    }

    func entries(for date: Date) -> [TrainingEntry] {
        let key = calendar.startOfDay(for: date)
        return entriesByDate[key] ?? []
    }

    func rebuildIndex() {
        var index: [Date: [TrainingEntry]] = [:]
        for entry in service.entries {
            let key = calendar.startOfDay(for: entry.date)
            index[key, default: []].append(entry)
        }
        entriesByDate = index
    }
}
