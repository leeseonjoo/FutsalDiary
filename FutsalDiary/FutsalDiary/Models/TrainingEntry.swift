import Foundation

struct TrainingEntry: Identifiable, Equatable {
    enum EntryType: String, Codable, CaseIterable {
        case match = "경기"
        case training = "훈련"
    }

    let id: UUID
    var title: String
    var date: Date
    var durationMinutes: Int
    var focusArea: String
    var notes: String
    var tags: [TrainingTag]
    var type: EntryType

    init(
        id: UUID = UUID(),
        title: String,
        date: Date,
        durationMinutes: Int,
        focusArea: String,
        notes: String = "",
        tags: [TrainingTag] = [],
        type: EntryType = .training
    ) {
        self.id = id
        self.title = title
        self.date = date
        self.durationMinutes = durationMinutes
        self.focusArea = focusArea
        self.notes = notes
        self.tags = tags
        self.type = type
    }
}

extension TrainingEntry {
    static let mock: [TrainingEntry] = [
        TrainingEntry(
            title: "주말 풋살 매치",
            date: Date(),
            durationMinutes: 60,
            focusArea: "빌드업 & 전진 패스",
            notes: "전방 압박 시 탈압박 패턴 성공률이 높았음.",
            tags: [.tactics],
            type: .match
        ),
        TrainingEntry(
            title: "피지컬 강화 세션",
            date: Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date(),
            durationMinutes: 45,
            focusArea: "인터벌 러닝",
            notes: "심박수 170 근처에서 6세트 유지.",
            tags: [.cardio],
            type: .training
        ),
        TrainingEntry(
            title: "회복 스트레칭",
            date: Calendar.current.date(byAdding: .day, value: -2, to: Date()) ?? Date(),
            durationMinutes: 20,
            focusArea: "전신 스트레칭",
            notes: "햄스트링 타이트니스 완화.",
            tags: [.recovery],
            type: .training
        )
    ]
}
