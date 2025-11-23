import Foundation

/// Represents a single training diary entry.
struct TrainingEntry: Identifiable, Codable, Equatable {
    let id: UUID
    var title: String
    var content: String
    var date: Date
    var tags: [TrainingTag]

    init(
        id: UUID = UUID(),
        title: String,
        content: String,
        date: Date = Date(),
        tags: [TrainingTag] = []
    ) {
        self.id = id
        self.title = title
        self.content = content
        self.date = date
        self.tags = tags
    }

    static let sample = TrainingEntry(
        title: "인터벌 러닝",
        content: "800m x 6세트, 세트 사이 90초 휴식",
        date: Date(),
        tags: []
    )
}
