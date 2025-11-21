import SwiftUI

/// A reusable container view that paints the app background using the bundled
/// `Background` image asset and layers the provided content on top.
struct BackgroundContainerView<Content: View>: View {
    @ViewBuilder var content: () -> Content

    var body: some View {
        ZStack {
            Image("Background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            content()
        }
    }
}

#Preview {
    BackgroundContainerView {
        VStack(spacing: 16) {
            Text("Futsal Diary")
                .font(.largeTitle.bold())
                .foregroundStyle(.white)

            Text("여기에 원하는 화면을 넣어 배경과 함께 사용하세요.")
                .multilineTextAlignment(.center)
                .padding()
                .background(.ultraThinMaterial, in: .rect(cornerRadius: 12))
                .foregroundStyle(.white)
        }
        .padding()
    }
}
