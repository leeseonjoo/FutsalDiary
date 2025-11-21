import SwiftUI

struct TrainingDiaryWriteView: View {
    @State private var title: String = ""
    @State private var content: String = ""

    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: Date())
    }

    var body: some View {
        ZStack {
            Image("background_7")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 24) {
                headerSection

                VStack(alignment: .leading, spacing: 12) {
                    titleField
                    contentField
                }

                Spacer()

                tagToolbar
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 24)
            .padding(.top, 28)
            .padding(.bottom, 28)
        }
    }

    private var headerSection: some View {
        HStack {
            Text(formattedDate)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.white)
                .lineLimit(1)

            Spacer()

            HStack(spacing: 16) {
                headerIcon(name: "square.and.arrow.up")
                headerIcon(name: "eye")
                headerIcon(name: "doc.on.doc")
            }
        }
    }

    private func headerIcon(name: String) -> some View {
        Button(action: {}) {
            Image(systemName: name)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.white)
                .padding(10)
                .background(.ultraThinMaterial, in: Circle())
        }
        .buttonStyle(.plain)
    }

    private var titleField: some View {
        TextField("제목", text: $title)
            .font(.headline)
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .foregroundStyle(.primary)
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Color.white)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .strokeBorder(Color.primary.opacity(0.12), lineWidth: 1)
            )
    }

    private var contentField: some View {
        ZStack(alignment: .topLeading) {
            if content.isEmpty {
                Text("훈련 내용을 입력하세요...")
                    .foregroundStyle(Color.secondary)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 16)
                    .multilineTextAlignment(.leading)
            }

            TextEditor(text: $content)
                .foregroundStyle(.primary)
                .font(.body)
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
                .multilineTextAlignment(.leading)
                .scrollContentBackground(.hidden)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 260)
        .background(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(Color.white)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .strokeBorder(Color.primary.opacity(0.12), lineWidth: 1)
        )
    }

    private var tagToolbar: some View {
        VStack(spacing: 16) {
            tagIcon("tag")
            tagIcon("folder")
            tagIcon("person.2")
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 12)
        .background(.ultraThinMaterial, in: Capsule(style: .continuous))
        .overlay(
            Capsule(style: .continuous)
                .stroke(Color.white.opacity(0.25), lineWidth: 1)
        )
        .foregroundStyle(.white)
    }

    private func tagIcon(_ icon: String) -> some View {
        Button(action: {}) {
            Image(systemName: icon)
                .font(.system(size: 16, weight: .semibold))
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color.white.opacity(0.14), in: Capsule())
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    TrainingDiaryWriteView()
}
