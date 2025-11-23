import SwiftUI

struct TrainingDiaryWriteView: View {
    @Binding var selectedTab: MainTab       // ⬅️ 여기!

    @State private var title: String = ""
    @State private var content: String = ""

    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: Date())
    }

    var body: some View {
        ZStack {
            Image("background_5")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack(spacing: 16) {
                headerSection
                    .padding(.horizontal, 16)
                    .padding(.top, 8)

                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        titleField
                        contentField
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                    .padding(.bottom, 120)
                }
            }
        }
        .safeAreaInset(edge: .bottom) {
            VStack(spacing: 16) {
                HStack {
                    tagToolbar
                    Spacer()
                }

                HStack {
                    Spacer()
                    Button("닫기") {
                        selectedTab = .note
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    Spacer()
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 8)
        }
    }

    // MARK: - Subviews

    private var headerSection: some View {
        HStack {
            Text(formattedDate)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.white)
                .lineLimit(1)

            Spacer()

            HStack(spacing: 16) {
                headerIcon(name: "square.and.arrow.up")  // 공유
                headerIcon(name: "eye")                 // 보기
                headerIcon(name: "doc.on.doc")          // 복사
            }
        }
    }

    private func headerIcon(name: String) -> some View {
        Button(action: {}) {
            Image(systemName: name)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.white)
                .padding(10)
                .background(.ultraThickMaterial, in: Circle())
        }
        .buttonStyle(.plain)
    }

    // 제목 필드
    private var titleField: some View {
        TextField(
            "",
            text: $title,
            prompt: Text("제목").foregroundColor(.white.opacity(0.7))
        )
        .font(.headline)
        .padding(.horizontal, 4)
        .padding(.vertical, 4)
        .foregroundStyle(Color.white)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.clear)
    }

    // 내용 필드
    private var contentField: some View {
        ZStack(alignment: .topLeading) {
            if content.isEmpty {
                Text("훈련 내용을 입력하세요...")
                    .foregroundColor(.white.opacity(0.7))
                    .padding(.horizontal, 4)
                    .padding(.vertical, 8)
            }

            TextEditor(text: $content)
                .foregroundColor(.white)
                .font(.body)
                .padding(.horizontal, 0)
                .padding(.vertical, 0)
                .scrollContentBackground(.hidden)
                .multilineTextAlignment(.leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 260)
        .background(Color.clear)
    }

    // 태그/폴더/사람 아이콘
    private var tagToolbar: some View {
        VStack(spacing: 16) {
            tagIcon("tag")
            tagIcon("folder")
            tagIcon("person.2")
        }
        .foregroundStyle(.white)
    }

    private func tagIcon(_ icon: String) -> some View {
        Button(action: {}) {
            Image(systemName: icon)
                .font(.system(size: 18, weight: .semibold))
        }
        .buttonStyle(.plain)
    }

#Preview {
    TrainingDiaryWriteView(selectedTab: .constant(.write))
}
