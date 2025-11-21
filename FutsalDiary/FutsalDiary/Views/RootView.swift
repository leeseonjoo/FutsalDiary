import SwiftUI

struct RootView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                // 배경 이미지 전체 화면에 깔기
                Image("background_4")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                // 가운데 정렬된 콘텐츠
                VStack(spacing: 12) {
                    Text("Futsal Diary")
                        .font(.system(size: 32, weight: .heavy))
                        .foregroundStyle(.white)

                    NavigationLink(destination: LoginView()) {
                        Text("Record")
                            .multilineTextAlignment(.center)
                            .font(.headline)
                            .foregroundStyle(.white)
                            .padding(.horizontal, 24)
                            .padding(.vertical, 12)
                            .background(.ultraThinMaterial, in: .rect(cornerRadius: 14))
                    }
                }
                // 화면 정중앙에 오도록 강제
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .center
                )
                .padding()
            }
        }
    }
}

#Preview {
    RootView()
}
