import Foundation

@MainActor
final class TrainingEditorViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var content: String = ""
    @Published var date: Date = Date()
    @Published var tags: [TrainingTag] = []

    private let service: TrainingEntryService

    init(service: TrainingEntryService = TrainingEntryService()) {
        self.service = service
    }

    func save() {
        let entry = TrainingEntry(title: title, content: content, date: date, tags: tags)
        service.add(entry)
    }
}
