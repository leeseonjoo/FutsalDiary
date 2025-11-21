import SwiftUI

/// A simple starting point for the app that shows a branded background
/// and a welcome message until real screens are wired up.
struct RootView: View {
    var body: some View {
        NavigationStack {
            BackgroundContainerView {
                VStack(spacing: 12) {
                    Text("Futsal Diary")
                        .font(.system(size: 32, weight: .heavy))
                        .foregroundStyle(.white)
            ZStack {
                // 🔥 배경 이미지 추가
                Image("background_4")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                VStack(spacing: 12) {
                    Text("Futsal Diary")
                        .font(.system(size: 32, weight: .heavy))
                        .foregroundStyle(.white)

                    Text("Record")
                        .multilineTextAlignment(.center)
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .background(.ultraThinMaterial, in: .rect(cornerRadius: 14))

                }
                .padding()
            }
        }
    }
}

#Preview {
    RootView()
}
