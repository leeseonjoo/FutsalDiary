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
                header
                titleField
                contentField
                Spacer()
                tagBar
            }
            .padding(.horizontal, 20)
            .padding(.top, 32)
            .padding(.bottom, 16)
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }

    private var header: some View {
        HStack(alignment: .center) {
            Text(formattedDate)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.white)

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
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white)
        }
        .buttonStyle(.plain)
    }

    private var titleField: some View {
        TextField("제목", text: $title)
            .padding(.horizontal, 14)
            .padding(.vertical, 12)
            .background(Color.white.opacity(0.18))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.white.opacity(0.35), lineWidth: 1)
            )
            .cornerRadius(10)
            .font(.headline)
            .foregroundColor(.white)
    }

    private var contentField: some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: $content)
                .padding(10)
                .background(Color.white.opacity(0.12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.white.opacity(0.28), lineWidth: 1)
                )
                .cornerRadius(12)
                .foregroundColor(.white)
                .font(.body)
                .scrollContentBackground(.hidden)

            if content.isEmpty {
                Text("훈련 내용을 입력하세요...")
                    .foregroundColor(.white.opacity(0.6))
                    .padding(.top, 18)
                    .padding(.leading, 16)
            }
        }
        .frame(maxHeight: 320)
    }

    private var tagBar: some View {
        HStack(spacing: 16) {
            tagItem(icon: "tag", title: "태그")
            tagItem(icon: "folder", title: "폴더")
            tagItem(icon: "person.2", title: "사람")
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(Color.white.opacity(0.14))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.white.opacity(0.25), lineWidth: 1)
        )
        .cornerRadius(12)
    }

    private func tagItem(icon: String, title: String) -> some View {
        Button(action: {}) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.system(size: 15, weight: .semibold))
                Text(title)
                    .font(.subheadline)
            }
            .foregroundColor(.white)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    NavigationStack {
        TrainingDiaryWriteView()
    }
}
