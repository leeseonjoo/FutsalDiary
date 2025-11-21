import Foundation

final class TrainingEditorViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var date: Date = Date()
    @Published var durationMinutes: Int = 60
    @Published var focusArea: String = ""
    @Published var notes: String = ""
    @Published var selectedTags: [TrainingTag] = []
    @Published var entryType: TrainingEntry.EntryType = .training

    private let entryService: TrainingEntryService
    private var editingEntryID: UUID?

    init(entryService: TrainingEntryService) {
        self.entryService = entryService
    }

    func load(entry: TrainingEntry) {
        editingEntryID = entry.id
        title = entry.title
        date = entry.date
        durationMinutes = entry.durationMinutes
        focusArea = entry.focusArea
        notes = entry.notes
        selectedTags = entry.tags
        entryType = entry.type
    }

    func save() {
        let entry = TrainingEntry(
            id: editingEntryID ?? UUID(),
            title: title.isEmpty ? "무제 세션" : title,
            date: date,
            durationMinutes: durationMinutes,
            focusArea: focusArea.isEmpty ? "미정" : focusArea,
            notes: notes,
            tags: selectedTags,
            type: entryType
        )
        entryService.save(entry: entry)
        editingEntryID = entry.id
    }
}
