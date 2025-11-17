import Foundation
import SwiftUI

struct DiaryEntry: Identifiable, Hashable {
    enum Mood: String {
        case victory = "승리"
        case growth = "성장"
        case recovery = "회복"

        var icon: String {
            switch self {
            case .victory: return "sparkles"
            case .growth: return "leaf"
            case .recovery: return "heart.text.square"
            }
        }

        var gradient: LinearGradient {
            switch self {
            case .victory:
                return LinearGradient(colors: [Color(hex: "FBD786"), Color(hex: "f7797d")], startPoint: .topLeading, endPoint: .bottomTrailing)
            case .growth:
                return LinearGradient(colors: [Color(hex: "43cea2"), Color(hex: "185a9d")], startPoint: .topLeading, endPoint: .bottomTrailing)
            case .recovery:
                return LinearGradient(colors: [Color(hex: "bdc3c7"), Color(hex: "2c3e50")], startPoint: .topLeading, endPoint: .bottomTrailing)
            }
        }
    }

    let id: UUID
    let title: String
    let opponent: String
    let date: Date
    let location: String
    let score: String
    let highlight: String
    let tags: [String]
    let weather: String
    let mood: Mood

    init(id: UUID = UUID(), title: String, opponent: String, date: Date, location: String, score: String, highlight: String, tags: [String], weather: String, mood: Mood) {
        self.id = id
        self.title = title
        self.opponent = opponent
        self.date = date
        self.location = location
        self.score = score
        self.highlight = highlight
        self.tags = tags
        self.weather = weather
        self.mood = mood
    }
}

extension DiaryEntry {
    static let mockEntries: [DiaryEntry] = [
        DiaryEntry(
            title: "볼로그 클럽 친선전",
            opponent: "FC Neo",
            date: Date().addingTimeInterval(-3600 * 20),
            location: "서울숲 풋살장",
            score: "4 : 2 WIN",
            highlight: "전반 8분에 나온 하프라인 스루패스는 올 시즌 최고의 장면!",
            tags: ["전술 점검", "콤비네이션", "볼터치"],
            weather: "맑음 18ºC",
            mood: .victory
        ),
        DiaryEntry(
            title: "주중 개인 훈련",
            opponent: "Solo",
            date: Date().addingTimeInterval(-3600 * 48),
            location: "성수 풋살 스튜디오",
            score: "스텝 훈련 45'",
            highlight: "볼 컨트롤 드릴에서 스텝이 훨씬 가벼워짐을 느낌.",
            tags: ["개인훈련", "피지컬"],
            weather: "실내 21ºC",
            mood: .growth
        ),
        DiaryEntry(
            title: "주말 풋살 리그 5R",
            opponent: "Urban United",
            date: Date().addingTimeInterval(-3600 * 72),
            location: "당산 프리미어 코트",
            score: "3 : 3 DRAW",
            highlight: "종료 직전 집중력 부족으로 실점. 수비 로테이션 더 연습 필요.",
            tags: ["수비 조직", "체력"],
            weather: "흐림 15ºC",
            mood: .recovery
        )
    ]
}
