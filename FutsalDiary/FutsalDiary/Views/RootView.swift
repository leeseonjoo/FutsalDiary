import SwiftUI

/// A simple starting point for the app that shows a branded background
/// and a welcome message until real screens are wired up.
struct RootView: View {
    var body: some View {
<<<<<<< HEAD
        BackgroundContainerView {
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
=======
        NavigationStack {
            BackgroundContainerView {
                VStack(spacing: 12) {
                    Text("Futsal Diary")
                        .font(.system(size: 32, weight: .heavy))
                        .foregroundStyle(.white)

                    Text("곧 멋진 기능들이 여기에 추가될 예정입니다.")
>>>>>>> 9c4fed9c06be705ed87555b0658400549c946634
                        .multilineTextAlignment(.center)
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .background(.ultraThinMaterial, in: .rect(cornerRadius: 14))
<<<<<<< HEAD
=======

                    NavigationLink(destination: LoginView()) {
                        Text("Record")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .padding(.horizontal, 32)
                            .padding(.vertical, 14)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(.ultraThinMaterial)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(.white, lineWidth: 2)
                            )
                    }
                    .padding(.top, 8)
>>>>>>> 9c4fed9c06be705ed87555b0658400549c946634
                }
                .padding()
            }
        }
    }
}

#Preview {
    RootView()
}
