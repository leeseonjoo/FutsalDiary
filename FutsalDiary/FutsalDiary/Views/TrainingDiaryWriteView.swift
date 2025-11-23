import SwiftUI

struct TrainingDiaryWriteView: View {
    @Binding var selectedTab: Tab
    
    @State private var title: String = ""
    @State private var content: String = ""

    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: Date())
    }

    var body: some View {
        ZStack {
            // 배경
            Image("background_5")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            // 실제 내용
            VStack(spacing: 16) {
                // 상단 헤더 고정
                headerSection
                    .padding(.horizontal, 16)
                    .padding(.top, 8)

                // 본문은 스크롤
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        titleField
                        contentField
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                    .padding(.bottom, 80) // 아래 아이콘/탭바와 겹치지 않게
                }
            }
        }
        // 하단 왼쪽에 태그/폴더/사람 아이콘, 탭바 위에 고정
        .safeAreaInset(edge: .bottom) {
            VStack(spacing: 16) {
                HStack {
                    tagToolbar   // ⬅️ 왼쪽
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

    // 제목 필드: 배경 투명, 글자 흰색
    private var titleField: some View {
        TextField(
            "",
            text: $title,
            prompt: Text("제목").foregroundColor(.white.opacity(0.7))
        )
        .font(.headline)
        .padding(.horizontal, 4)
        .padding(.vertical, 4)
        .foregroundStyle(Color.white)                   // 텍스트 흰색
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.clear)                        // 배경 완전 투명
    }

    // 내용 필드: 배경 투명, 글자 흰색
    private var contentField: some View {
        ZStack(alignment: .topLeading) {
            if content.isEmpty {
                Text("훈련 내용을 입력하세요...")
                    .foregroundColor(.white.opacity(0.7)) // 흰색 계열 placeholder
                    .padding(.horizontal, 4)
                    .padding(.vertical, 8)
            }

            TextEditor(text: $content)
                .foregroundColor(.white)                // 입력 텍스트 흰색
                .font(.body)
                .padding(.horizontal, 0)
                .padding(.vertical, 0)
                .scrollContentBackground(.hidden)
                .multilineTextAlignment(.leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 260)
        .background(Color.clear)                        // 배경 완전 투명
    }

    // 태그/폴더/사람 아이콘: 배경 박스 제거, 아이콘만
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
}

#Preview {
    MainHomeView()
}
