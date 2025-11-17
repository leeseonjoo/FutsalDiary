import SwiftUI

struct DiaryEntryRow: View {
    let entry: DiaryEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 6) {
                    Text(entry.title)
                        .font(.headline)
                        .foregroundStyle(Color.diaryTextPrimary)
                    Text(entry.score)
                        .font(.title3.weight(.bold))
                        .foregroundStyle(Color.diaryAccent)
                }
                Spacer()
                VStack(alignment: .trailing, spacing: 4) {
                    Label(entry.date, formatter: DateFormatter.diaryShort, systemImage: "clock")
                    Label(entry.location, systemImage: "mappin")
                }
                .labelStyle(.iconOnly)
            }

            Text(entry.highlight)
                .font(.callout)
                .foregroundStyle(Color.diaryTextSecondary)

            HStack {
                ForEach(entry.tags, id: \.self) { tag in
                    Text(tag)
                        .font(.caption)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(Color.diaryBackground, in: Capsule())
                }
                Spacer()
                HStack(spacing: 6) {
                    Image(systemName: entry.mood.icon)
                    Text(entry.mood.rawValue)
                }
                .font(.caption.weight(.semibold))
                .foregroundStyle(Color.diaryTextSecondary)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(entry.mood.gradient)
                .clipShape(Capsule())
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 26, style: .continuous)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.06), radius: 18, x: 0, y: 12)
        )
    }
}

private extension Label where Title == Text, Icon == Image {
    init(_ date: Date, formatter: DateFormatter, systemImage: String) {
        self.init {
            Text(formatter.string(from: date))
                .font(.caption)
                .foregroundStyle(Color.diaryTextSecondary)
        } icon: {
            Image(systemName: systemImage)
                .foregroundStyle(Color.diaryAccent)
        }
    }
}

private extension DateFormatter {
    static let diaryShort: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "M.d a h시"
        return formatter
    }()
}
