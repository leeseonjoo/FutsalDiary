import SwiftUI

struct ContentView: View {
    @StateObject private var appRootViewModel = AppRootViewModel()

    var body: some View {
        switch appRootViewModel.state {
        case .splash:
            SplashScreen(viewModel: appRootViewModel.splashViewModel)
        case .unauthenticated:
            LoginScreen(
                viewModel: LoginViewModel(authService: appRootViewModel.authService)
            ) { user in
                appRootViewModel.completeLogin(with: user)
            }
        case .authenticated(let user):
            TrainingHomeView(
                user: user,
                entryService: appRootViewModel.entryService,
                onLogout: appRootViewModel.logout
            )
        }
    }
}

private struct SplashScreen: View {
    @ObservedObject var viewModel: SplashViewModel

    var body: some View {
        VStack(spacing: 16) {
            ProgressView()
            Text("풋살 다이어리를 준비 중입니다...")
                .font(.headline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }
}

private struct LoginScreen: View {
    @ObservedObject var viewModel: LoginViewModel
    let onLogin: (User) -> Void

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("계정 정보")) {
                    TextField("이메일", text: $viewModel.email)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                    SecureField("비밀번호", text: $viewModel.password)
                }

                if let message = viewModel.errorMessage {
                    Section {
                        Text(message)
                            .foregroundColor(.red)
                    }
                }

                Section {
                    Button {
                        viewModel.login { result in
                            if case .success(let user) = result {
                                onLogin(user)
                            }
                        }
                    } label: {
                        HStack {
                            if viewModel.isLoading { ProgressView() }
                            Text("로그인")
                        }
                    }
                }
            }
            .navigationTitle("Futsal Diary")
        }
    }
}

private struct TrainingHomeView: View {
    let user: User
    let entryService: TrainingEntryService
    let onLogout: () -> Void

    @StateObject private var listViewModel: TrainingListViewModel
    @StateObject private var calendarViewModel: CalendarViewModel
    @StateObject private var editorViewModel: TrainingEditorViewModel

    init(user: User, entryService: TrainingEntryService, onLogout: @escaping () -> Void) {
        self.user = user
        self.entryService = entryService
        self.onLogout = onLogout
        _listViewModel = StateObject(wrappedValue: TrainingListViewModel(entryService: entryService))
        _calendarViewModel = StateObject(wrappedValue: CalendarViewModel(entryService: entryService))
        _editorViewModel = StateObject(wrappedValue: TrainingEditorViewModel(entryService: entryService))
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                header
                calendar
                entryList
                addButtons
            }
            .padding()
            .navigationTitle("오늘의 기록")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("로그아웃", action: onLogout)
                }
            }
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("어서 오세요, \(user.displayName)님")
                .font(.title3.weight(.semibold))
            Text("최근 \(listViewModel.entries.count)개의 기록을 불러왔습니다.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var calendar: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("날짜 선택")
                .font(.headline)
            DatePicker("날짜", selection: $calendarViewModel.selectedDate, displayedComponents: .date)
                .datePickerStyle(.compact)
                .onChange(of: calendarViewModel.selectedDate) { _, newValue in
                    calendarViewModel.loadEntries(for: newValue)
                }
            if calendarViewModel.entriesForSelectedDate.isEmpty {
                Text("선택한 날짜에 기록이 없습니다.")
                    .foregroundStyle(.secondary)
                    .font(.subheadline)
            } else {
                Text("\(calendarViewModel.entriesForSelectedDate.count)건의 기록")
                    .foregroundStyle(.secondary)
                    .font(.subheadline)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var entryList: some View {
        List {
            ForEach(listViewModel.filteredEntries()) { entry in
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Text(entry.title)
                            .font(.headline)
                        Spacer()
                        Text(entry.type.rawValue)
                            .font(.caption)
                            .padding(6)
                            .background(Capsule().fill(Color(.secondarySystemBackground)))
                    }
                    Text(entry.focusArea)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Text("\(entry.durationMinutes)분 • \(entry.date.formatted(date: .abbreviated, time: .omitted))")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            .onDelete(perform: listViewModel.remove)
        }
        .listStyle(.plain)
    }

    private var addButtons: some View {
        VStack(spacing: 12) {
            Button {
                editorViewModel.title = "오늘의 훈련"
                editorViewModel.date = Date()
                editorViewModel.focusArea = "볼 컨트롤"
                editorViewModel.durationMinutes = 40
                editorViewModel.selectedTags = [.tactics]
                editorViewModel.entryType = .training
                editorViewModel.save()
                refreshEntries()
            } label: {
                Label("오늘 훈련 빠르게 추가", systemImage: "plus.circle.fill")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)

            Button {
                editorViewModel.title = "친선 경기 기록"
                editorViewModel.date = Date()
                editorViewModel.focusArea = "팀 빌드업"
                editorViewModel.durationMinutes = 50
                editorViewModel.selectedTags = [.cardio, .tactics]
                editorViewModel.entryType = .match
                editorViewModel.save()
                refreshEntries()
            } label: {
                Label("매치 기록 추가", systemImage: "sportscourt")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
        }
    }

    private func refreshEntries() {
        listViewModel.loadEntries()
        calendarViewModel.loadEntries(for: calendarViewModel.selectedDate)
    }
}

#Preview {
    ContentView()
}
