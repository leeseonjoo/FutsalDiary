import Foundation

final class CalendarViewModel: ObservableObject {
    @Published var selectedDate: Date
    @Published private(set) var entriesForSelectedDate: [TrainingEntry] = []

    private let entryService: TrainingEntryService

    init(selectedDate: Date = Date(), entryService: TrainingEntryService) {
        self.selectedDate = selectedDate
        self.entryService = entryService
        loadEntries(for: selectedDate)
    }

    func loadEntries(for date: Date) {
        selectedDate = date
        entriesForSelectedDate = entryService.entries(on: date)
    }
}
