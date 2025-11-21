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

            VStack(alignment: .leading, spacing: 20) {
                headerSection

                VStack(alignment: .leading, spacing: 12) {
                    titleField
                    contentField
                }

                Spacer()

                tagToolbar
            }
            .padding(.horizontal, 20)
            .padding(.top, 32)
            .padding(.bottom, 24)
        }
    }

    private var headerSection: some View {
        HStack {
            Text(formattedDate)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.white)

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
            .padding(.horizontal, 14)
            .padding(.vertical, 12)
            .foregroundStyle(.white)
            .background(.black.opacity(0.35), in: RoundedRectangle(cornerRadius: 12, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .strokeBorder(Color.white.opacity(0.35), lineWidth: 1)
            )
    }

    private var contentField: some View {
        ZStack(alignment: .topLeading) {
            if content.isEmpty {
                Text("훈련 내용을 입력하세요...")
                    .foregroundStyle(Color.white.opacity(0.7))
                    .padding(.horizontal, 18)
                    .padding(.vertical, 14)
            }

            TextEditor(text: $content)
                .foregroundStyle(.white)
                .font(.body)
                .padding(8)
                .scrollContentBackground(.hidden)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 260)
        .background(.black.opacity(0.3), in: RoundedRectangle(cornerRadius: 14, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .strokeBorder(Color.white.opacity(0.25), lineWidth: 1)
        )
    }

    private var tagToolbar: some View {
        HStack(spacing: 16) {
            tagItem(icon: "tag", title: "태그")
            tagItem(icon: "folder", title: "폴더")
            tagItem(icon: "person.2", title: "사람")
        }
        .padding(12)
        .background(.ultraThinMaterial, in: Capsule())
        .overlay(
            Capsule()
                .stroke(Color.white.opacity(0.25), lineWidth: 1)
        )
        .foregroundStyle(.white)
    }

    private func tagItem(icon: String, title: String) -> some View {
        Button(action: {}) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.system(size: 14, weight: .semibold))
                Text(title)
                    .font(.system(size: 14, weight: .semibold))
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(Color.white.opacity(0.12), in: Capsule())
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    TrainingDiaryWriteView()
}
