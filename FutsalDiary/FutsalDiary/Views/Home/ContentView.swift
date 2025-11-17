import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = DiaryHomeViewModel()

    var body: some View {
        DiaryHomeView(viewModel: viewModel)
    }
}

#Preview {
    ContentView()
}
