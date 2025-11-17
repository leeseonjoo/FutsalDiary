import Foundation

final class DiaryHomeViewModel: ObservableObject {
    struct DiaryStats {
        let totalMatches: Int
        let winRate: Double
        let weeklyMinutes: Int
    }

    struct UpcomingMatch {
        let title: String
        let opponent: String
        let date: Date
        let location: String
    }

    enum Filter: String, CaseIterable, Identifiable {
        case all = "전체"
        case match = "경기"
        case training = "훈련"

        var id: String { rawValue }
    }

    @Published var entries: [DiaryEntry]
    @Published var selectedFilter: Filter = .all

    let stats: DiaryStats
    let upcomingMatch: UpcomingMatch

    init(entries: [DiaryEntry] = DiaryEntry.mockEntries,
         stats: DiaryStats = DiaryStats(totalMatches: 27, winRate: 0.64, weeklyMinutes: 320),
         upcomingMatch: UpcomingMatch = UpcomingMatch(title: "서울 동호회 리그 6R", opponent: "Blue Wave", date: Date().addingTimeInterval(3600 * 72), location: "장한평 루프탑 코트")) {
        self.entries = entries
        self.stats = stats
        self.upcomingMatch = upcomingMatch
    }

    var filteredEntries: [DiaryEntry] {
        switch selectedFilter {
        case .all:
            return entries
        case .match:
            return entries.filter { $0.opponent != "Solo" }
        case .training:
            return entries.filter { $0.opponent == "Solo" }
        }
    }
}
