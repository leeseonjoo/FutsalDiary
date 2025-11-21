import SwiftUI

/// A simple starting point for the app that shows a branded background
/// and a welcome message until real screens are wired up.
struct RootView: View {
    var body: some View {
        BackgroundContainerView {
            VStack(spacing: 12) {
                Text("Futsal Diary")
                    .font(.system(size: 32, weight: .heavy))
                    .foregroundStyle(.white)

                Text("곧 멋진 기능들이 여기에 추가될 예정입니다.")
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

#Preview {
    RootView()
}
