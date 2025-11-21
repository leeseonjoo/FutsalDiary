import SwiftUI
import UIKit

enum Tab: Hashable {
    case analysis, tactics, write, feed, theme
}

struct MainHomeView: View {

    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.black.withAlphaComponent(0.25)

        let normalAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white.withAlphaComponent(0.8)]
        let selectedAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white]

        appearance.stackedLayoutAppearance.normal.titleTextAttributes = normalAttributes
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = selectedAttributes
        appearance.inlineLayoutAppearance = appearance.stackedLayoutAppearance
        appearance.compactInlineLayoutAppearance = appearance.stackedLayoutAppearance

        UITabBar.appearance().standardAppearance = appearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }

        UITabBar.appearance().unselectedItemTintColor = UIColor.white.withAlphaComponent(0.8)
    }

    @State private var selectedTab: Tab = .analysis
    @State private var lastNonWriteTab: Tab = .analysis
    @State private var isPresentingWriteView = false

    var body: some View {
        TabView(selection: $selectedTab) {
            AnalysisHomeView()
                .tabItem {
                    Text("분석")
                }
                .tag(Tab.analysis)

            Color.clear
                .tabItem {
                    Text("전술")
                }
                .tag(Tab.tactics)

            Color.clear
                .tabItem {
                    Image(systemName: isPresentingWriteView ? "xmark.circle.fill" : "pencil.circle.fill")
                    Text(isPresentingWriteView ? "닫기" : "작성")
                }
                .tag(Tab.write)

            FeedView()
                .tabItem {
                    Text("피드")
                }
                .tag(Tab.feed)

            ThemeView()
                .tabItem {
                    Text("테마")
                }
                .tag(Tab.theme)
        }
        .tint(.white)
        .onChange(of: selectedTab) { newValue in
            if newValue == .write {
                if isPresentingWriteView {
                    isPresentingWriteView = false
                } else {
                    isPresentingWriteView = true
                }

                selectedTab = lastNonWriteTab
            } else {
                lastNonWriteTab = newValue
            }
        }
        .sheet(isPresented: $isPresentingWriteView, onDismiss: {
            selectedTab = lastNonWriteTab
        }) {
            TrainingDiaryWriteView {
                isPresentingWriteView = false
            }
        }
    }
}

private struct AnalysisHomeView: View {
    enum TabType { case schedule, diary }

    private var tabTitle: (TabType) -> String = { tab in
        switch tab {
        case .schedule: return "일정 등록"
        case .diary: return "일지 작성"
        }
    }

    @State private var selectedDate: Date = Date()
    @State private var selectedTab: TabType = .schedule

    private let calendar: Calendar = {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "en_US_POSIX")
        calendar.firstWeekday = 1 // Sunday
        return calendar
    }()

    private var startOfMonth: Date {
        let components = calendar.dateComponents([.year, .month], from: Date())
        return calendar.date(from: components) ?? Date()
    }

    private var numberOfDaysInMonth: Int {
        calendar.range(of: .day, in: .month, for: startOfMonth)?.count ?? 30
    }

    private var weekdaySymbols: [String] { ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"] }

    private struct Day: Identifiable {
        let id = UUID()
        let date: Date
        let isCurrentMonth: Bool
    }

    private var daysInMonth: [Day] {
        let firstWeekday = calendar.component(.weekday, from: startOfMonth)
        let leadingEmptyDays = (firstWeekday - calendar.firstWeekday + 7) % 7

        var days: [Day] = []

        for offset in 0..<leadingEmptyDays {
            if let placeholderDate = calendar.date(byAdding: .day, value: -(leadingEmptyDays - offset), to: startOfMonth) {
                days.append(Day(date: placeholderDate, isCurrentMonth: false))
            }
        }

        for day in 1...numberOfDaysInMonth {
            if let date = calendar.date(byAdding: .day, value: day - 1, to: startOfMonth) {
                days.append(Day(date: date, isCurrentMonth: true))
            }
        }

        let remainder = days.count % 7
        if remainder != 0 {
            let trailingDays = 7 - remainder
            if let lastDate = days.last?.date {
                for offset in 1...trailingDays {
                    if let date = calendar.date(byAdding: .day, value: offset, to: lastDate) {
                        days.append(Day(date: date, isCurrentMonth: false))
                    }
                }
            }
        }

        return days
    }

    private var workoutDates: [Date] {
        let sampleDays = [1, 3, 5, 10, 12, 14]
        return sampleDays.compactMap { day in
            calendar.date(byAdding: .day, value: day - 1, to: startOfMonth)
        }
    }

    private var diaryDates: [Date] {
        let sampleDays = [3, 7, 12]
        return sampleDays.compactMap { day in
            calendar.date(byAdding: .day, value: day - 1, to: startOfMonth)
        }
    }

    private var workoutCount: Int { workoutDates.count }
    private var diaryCount: Int { diaryDates.count }
    private var targetWorkoutDays: Int { 24 }
    private var remainingWorkoutDays: Int { max(targetWorkoutDays - workoutCount, 0) }

    private var streakCount: Int {
        let today = calendar.startOfDay(for: Date())
        let sorted = workoutDates.map { calendar.startOfDay(for: $0) }.sorted(by: >)
        var currentStreak = 0

        for date in sorted {
            let expectedDate = calendar.date(byAdding: .day, value: -currentStreak, to: today)
            if date == expectedDate {
                currentStreak += 1
            } else if let expectedDate, date < expectedDate {
                break
            }
        }

        return currentStreak
    }

    var body: some View {
        ZStack {
            Image("background_6")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack(spacing: 18) {
                calendarCard
                tabSelector
                summaryBadges
            }
            .padding(.top, 40)
            .padding(.bottom, 24)
            .padding(.horizontal)
        }
    }

    private var calendarCard: some View {
        VStack(spacing: 12) {
            weekdayHeader
            calendarGrid
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 12)
        .frame(width: 330)
        .background(Color.white.opacity(0.96))
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.08), radius: 12, x: 0, y: 4)
    }

    private var weekdayHeader: some View {
        HStack(spacing: 0) {
            ForEach(weekdaySymbols, id: \.self) { symbol in
                Text(symbol)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.gray)
                    .frame(maxWidth: .infinity)
            }
        }
    }

    private var calendarGrid: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 10) {
            ForEach(daysInMonth) { day in
                let isSelected = calendar.isDate(day.date, inSameDayAs: selectedDate)
                let textColor: Color = day.isCurrentMonth ? (isSelected ? .white : .black) : .gray.opacity(0.4)

                Text("\(calendar.component(.day, from: day.date))")
                    .font(.system(size: 15))
                    .frame(width: 36, height: 36)
                    .background(
                        Group {
                            if isSelected {
                                Circle().fill(Color.blue)
                            } else {
                                Color.clear
                            }
                        }
                    )
                    .foregroundStyle(textColor)
                    .clipShape(Circle())
                    .onTapGesture {
                        if day.isCurrentMonth {
                            selectedDate = day.date
                        }
                    }
            }
        }
        .padding(.horizontal, 4)
    }

    private var tabSelector: some View {
        HStack(spacing: 0) {
            tabButton(.schedule)
            tabButton(.diary)
        }
        .frame(width: 330)
        .background(Color.white.opacity(0.9))
        .clipShape(Capsule())
        .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 4)
    }

    private func tabButton(_ tab: TabType) -> some View {
        Button {
            selectedTab = tab
        } label: {
            Text(tabTitle(tab))
                .font(.system(size: 15, weight: .semibold))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(selectedTab == tab ? Color.gray.opacity(0.25) : Color.gray.opacity(0.15))
                .foregroundStyle(selectedTab == tab ? Color.black : Color.gray)
        }
        .buttonStyle(.plain)
    }

    private var summaryBadges: some View {
        let badges: [(String, String)] = [
            ("운동", "\(workoutCount)일"),
            ("일지", "\(diaryCount)개"),
            ("남은 일수", "\(remainingWorkoutDays)일"),
            ("연속", "\(streakCount)일 연속")
        ]

        return HStack(spacing: 12) {
            ForEach(badges, id: \.0) { badge in
                VStack(spacing: 4) {
                    Text(badge.0)
                        .font(.system(size: 12, weight: .semibold))
                    Text(badge.1)
                        .font(.system(size: 14, weight: .bold))
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
                .background(Color.white.opacity(0.75))
                .clipShape(Capsule())
                .overlay(
                    Capsule()
                        .stroke(Color.white.opacity(0.7), lineWidth: 1)
                )
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .frame(width: 340)
        .background(Color.gray.opacity(0.3))
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        .shadow(color: .black.opacity(0.08), radius: 10, x: 0, y: 4)
    }
}

private struct TacticsView: View {
    var body: some View {
        Text("전술 화면 (준비중)")
            .font(.title3)
            .foregroundColor(.gray)
    }
}

private struct WriteView: View {
    var body: some View {
        Text("작성 화면 (준비중)")
            .font(.title3)
            .foregroundColor(.gray)
    }
}

private struct FeedView: View {
    var body: some View {
        Text("피드 화면 (준비중)")
            .font(.title3)
            .foregroundColor(.gray)
    }
}

private struct ThemeView: View {
    var body: some View {
        Text("테마 화면 (준비중)")
            .font(.title3)
            .foregroundColor(.gray)
    }
}

#Preview {
    MainHomeView()
}
