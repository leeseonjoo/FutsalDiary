import SwiftUI

struct DiarySummaryCard: View {
    let title: String
    let value: String
    let caption: String
    let icon: String

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: icon)
                    .font(.title3.weight(.semibold))
                    .foregroundStyle(Color.diaryAccent)
                    .padding(10)
                    .background(Color.white.opacity(0.6), in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                Spacer()
                Text(caption)
                    .font(.caption)
                    .foregroundStyle(Color.diaryTextSecondary)
            }

            Text(value)
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(Color.diaryTextPrimary)
            Text(title)
                .font(.subheadline)
                .foregroundStyle(Color.diaryTextSecondary)
        }
        .padding(18)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .fill(Color.diaryCard)
                .shadow(color: Color.black.opacity(0.05), radius: 18, x: 0, y: 14)
        )
    }
}
