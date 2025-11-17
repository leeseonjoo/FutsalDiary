import SwiftUI

struct DiaryHomeView: View {
    @ObservedObject var viewModel: DiaryHomeViewModel

    private let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                header
                statsSection
                upcomingMatchCard
                filterSection
                entriesSection
            }
            .padding(.vertical, 32)
            .padding(.horizontal, 24)
        }
        .background(Color.diaryBackground.ignoresSafeArea())
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("볼로그")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundStyle(Color.diaryTextPrimary)
                    Text("오늘의 플레이 기록")
                        .font(.system(size: 17, weight: .medium))
                        .foregroundStyle(Color.diaryTextSecondary)
                }
                Spacer()
                Button {
                } label: {
                    Image(systemName: "bell")
                        .font(.title3)
                        .padding(12)
                        .background(Color.white, in: Circle())
                        .shadow(color: Color.black.opacity(0.06), radius: 12, x: 0, y: 6)
                }
            }

            VStack(alignment: .leading, spacing: 6) {
                Text(Date.now, style: .date)
                    .font(.footnote)
                    .foregroundStyle(Color.diaryTextSecondary)
                Text("팀 피드 & 훈련 현황")
                    .font(.headline)
                    .foregroundStyle(Color.diaryTextPrimary)
            }
        }
    }

    private var statsSection: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            DiarySummaryCard(title: "이번 달 경기", value: "\(viewModel.stats.totalMatches)회", caption: "누적 12팀 매치", icon: "sportscourt")
            DiarySummaryCard(title: "승률", value: String(format: "%.0f%%", viewModel.stats.winRate * 100), caption: "최근 5경기", icon: "crown")
            DiarySummaryCard(title: "주간 훈련", value: "\(viewModel.stats.weeklyMinutes)분", caption: "3회 완료", icon: "figure.run")
            DiarySummaryCard(title: "휴식 상태", value: "회복 중", caption: "근육 피로도 40%", icon: "heart")
        }
    }

    private var upcomingMatchCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("다가오는 매치")
                .font(.title3.bold())
                .foregroundStyle(Color.diaryTextPrimary)

            VStack(alignment: .leading, spacing: 12) {
                Text(viewModel.upcomingMatch.title)
                    .font(.headline)
                Text("vs. \(viewModel.upcomingMatch.opponent)")
                    .font(.subheadline)
                    .foregroundStyle(Color.diaryTextSecondary)
                VStack(alignment: .leading, spacing: 8) {
                    Label {
                        Text(DateFormatter.eventDate.string(from: viewModel.upcomingMatch.date))
                            .font(.subheadline)
                            .foregroundStyle(Color.diaryTextSecondary)
                    } icon: {
                        Image(systemName: "calendar")
                            .foregroundStyle(Color.diaryAccent)
                    }

                    Label {
                        Text(viewModel.upcomingMatch.location)
                            .font(.subheadline)
                            .foregroundStyle(Color.diaryTextSecondary)
                    } icon: {
                        Image(systemName: "mappin.circle.fill")
                            .foregroundStyle(Color.diaryAccent)
                    }
                }
            }
            .padding(20)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                LinearGradient(colors: [Color(hex: "fdfbfb"), Color(hex: "ebedee")], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .cornerRadius(28)
            )
        }
    }

    private var filterSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("기록 모아보기")
                .font(.title3.bold())
                .foregroundStyle(Color.diaryTextPrimary)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(DiaryHomeViewModel.Filter.allCases) { filter in
                        FilterCapsule(title: filter.rawValue, isSelected: viewModel.selectedFilter == filter)
                            .onTapGesture {
                                withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                                    viewModel.selectedFilter = filter
                                }
                            }
                    }
                }
                .padding(.vertical, 4)
            }
        }
    }

    private var entriesSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            ForEach(viewModel.filteredEntries) { entry in
                DiaryEntryRow(entry: entry)
            }
        }
    }
}

private struct FilterCapsule: View {
    let title: String
    let isSelected: Bool

    var body: some View {
        Text(title)
            .font(.subheadline)
            .fontWeight(.medium)
            .foregroundStyle(isSelected ? .white : Color.diaryTextSecondary)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(
                Group {
                    if isSelected {
                        LinearGradient(colors: [Color.diaryAccent, Color(hex: "8E54E9")], startPoint: .leading, endPoint: .trailing)
                    } else {
                        Color.white
                    }
                }
            )
            .overlay(
                RoundedRectangle(cornerRadius: 24)
                    .stroke(Color.black.opacity(0.05), lineWidth: isSelected ? 0 : 1)
            )
            .clipShape(Capsule())
            .shadow(color: isSelected ? Color.diaryAccent.opacity(0.2) : Color.clear, radius: 12, x: 0, y: 6)
    }
}

private extension Label where Title == Text, Icon == Image {
    init(_ text: Date, formatter: DateFormatter, systemImage: String) {
        self.init {
            Text(formatter.string(from: text))
                .foregroundStyle(Color.diaryTextSecondary)
                .font(.subheadline)
        } icon: {
            Image(systemName: systemImage)
                .foregroundStyle(Color.diaryAccent)
        }
    }
}

private extension DateFormatter {
    static let eventDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "M월 d일 (E) a h시"
        return formatter
    }()
}
