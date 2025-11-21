import SwiftUI

struct RootView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                // ⬇️ 여기가 배경 이미지
                Image("background_4")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                BackgroundContainerView {
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
                    .padding()
                }
            }
        }
    }
}

#Preview {
    RootView()
}
