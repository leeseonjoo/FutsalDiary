import SwiftUI

struct Note: Identifiable {
    let id: UUID
    var title: String
    var content: String
    var folderId: UUID?
    var createdAt: Date
}

struct NoteFolder: Identifiable {
    let id: UUID
    var name: String
    var color: Color
}

struct NoteTabView: View {
    @State private var folders: [NoteFolder] = NoteTabView.defaultFolders
    @State private var notes: [Note] = NoteTabView.defaultNotes
    @State private var selectedFolderId: UUID? = nil
    @State private var searchText: String = ""

    @State private var isPresentingFolderAlert = false
    @State private var isRenamingFolder = false
    @State private var folderNameInput: String = ""
    @State private var folderToRename: NoteFolder?

    private let folderColors: [Color] = [
        Color(red: 0.82, green: 0.90, blue: 1.0),
        Color(red: 0.86, green: 0.91, blue: 0.84),
        Color(red: 0.93, green: 0.86, blue: 0.94),
        Color(red: 0.98, green: 0.91, blue: 0.83),
        Color(red: 0.88, green: 0.93, blue: 0.93)
    ]

    private var filteredNotes: [Note] {
        notes.filter { note in
            let matchesFolder = selectedFolderId == nil || note.folderId == selectedFolderId
            guard matchesFolder else { return false }

            let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
            guard !query.isEmpty else { return true }

            return note.title.localizedCaseInsensitiveContains(query) ||
                note.content.localizedCaseInsensitiveContains(query)
        }
    }

    var body: some View {
        ZStack {
            Image("background_6")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack(spacing: 12) {
                searchBar
                folderSelector
                noteList
            }
            .padding()
        }
        .alert("폴더 추가", isPresented: $isPresentingFolderAlert) {
            TextField("폴더명", text: $folderNameInput)
            Button("추가", action: addFolder)
            Button("취소", role: .cancel) { folderNameInput = "" }
        }
        .alert("폴더 이름 변경", isPresented: $isRenamingFolder) {
            TextField("폴더명", text: $folderNameInput)
            Button("저장", action: renameFolder)
            Button("취소", role: .cancel) { folderNameInput = "" }
        }
    }

    private var searchBar: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.white.opacity(0.8))

            TextField("검색", text: $searchText)
                .textFieldStyle(.plain)
                .foregroundColor(.white)
                .tint(.white)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background(Color.white.opacity(0.14))
        .cornerRadius(12)
    }

    private var folderSelector: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                folderChip(folder: nil, name: "전체", color: Color.white.opacity(0.2))

                ForEach(folders) { folder in
                    folderChip(folder: folder, name: folder.name, color: folder.color)
                        .contextMenu {
                            Button("이름 변경") {
                                folderToRename = folder
                                folderNameInput = folder.name
                                isRenamingFolder = true
                            }
                        }
                }

                Button {
                    folderNameInput = ""
                    isPresentingFolderAlert = true
                } label: {
                    HStack(spacing: 6) {
                        Image(systemName: "plus.circle.fill")
                        Text("폴더 추가")
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 14)
                    .background(Color.white.opacity(0.14))
                    .cornerRadius(12)
                    .foregroundColor(.white)
                }
            }
            .padding(.vertical, 6)
        }
    }

    private func folderChip(folder: NoteFolder?, name: String, color: Color) -> some View {
        let isSelected = selectedFolderId == folder?.id
        return Button {
            selectedFolderId = folder?.id
        } label: {
            HStack(spacing: 8) {
                Circle()
                    .fill(folder?.color ?? .white.opacity(0.6))
                    .frame(width: 10, height: 10)
                Text(name)
                    .font(.subheadline.weight(.semibold))
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 14)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(color.opacity(isSelected ? 0.8 : 0.5))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.white.opacity(isSelected ? 0.9 : 0.3), lineWidth: isSelected ? 1.5 : 1)
                    )
            )
            .foregroundColor(.white)
        }
        .buttonStyle(.plain)
    }

    private var noteList: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(filteredNotes) { note in
                    noteCard(for: note)
                        .contextMenu {
                            Button("전체") {
                                move(note: note, to: nil)
                            }
                            ForEach(folders) { folder in
                                Button(folder.name) {
                                    move(note: note, to: folder.id)
                                }
                            }
                        }
                }
            }
            .padding(.vertical, 4)
        }
    }

    private func noteCard(for note: Note) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(note.title)
                .font(.headline)
                .foregroundColor(.white)

            Text(String(note.content.prefix(120)))
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.85))
                .lineLimit(2)

            HStack {
                Text(dateFormatter.string(from: note.createdAt))
                Spacer()
                if let folder = folders.first(where: { $0.id == note.folderId }) {
                    Label(folder.name, systemImage: "folder.fill")
                        .labelStyle(.titleAndIcon)
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.9))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 6)
                        .background(folder.color.opacity(0.8))
                        .cornerRadius(10)
                } else {
                    Label("전체", systemImage: "tray.full")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.85))
                }
            }
            .font(.caption)
            .foregroundColor(.white.opacity(0.8))
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.black.opacity(0.25))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.white.opacity(0.15), lineWidth: 1)
        )
    }

    private func move(note: Note, to folderId: UUID?) {
        guard let index = notes.firstIndex(where: { $0.id == note.id }) else { return }
        notes[index].folderId = folderId
    }

    private func addFolder() {
        let name = folderNameInput.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !name.isEmpty else { return }

        let colorIndex = (folders.count) % folderColors.count
        let newFolder = NoteFolder(id: UUID(), name: name, color: folderColors[colorIndex])
        folders.append(newFolder)
        folderNameInput = ""
    }

    private func renameFolder() {
        guard let target = folderToRename else { return }
        let name = folderNameInput.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !name.isEmpty else { return }

        if let index = folders.firstIndex(where: { $0.id == target.id }) {
            folders[index].name = name
        }

        folderToRename = nil
        folderNameInput = ""
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }
}

private extension NoteTabView {
    static var defaultFolders: [NoteFolder] {
        [
            NoteFolder(id: UUID(), name: "기본 폴더", color: Color(red: 0.76, green: 0.86, blue: 0.96))
        ]
    }

    static var defaultNotes: [Note] {
        let baseFolder = defaultFolders.first!.id
        return [
            Note(
                id: UUID(),
                title: "피지컬 트레이닝",
                content: "체력 보강을 위해 인터벌 러닝 6세트 진행. 마지막 두 세트에서 페이스 유지가 어려웠지만 팀원들과 함께 끝까지 소화.",
                folderId: baseFolder,
                createdAt: Date().addingTimeInterval(-86400 * 1)
            ),
            Note(
                id: UUID(),
                title: "전술 미팅",
                content: "하프라인 프레싱 시 포백 간격 유지와 미드필더 라인 전진 타이밍을 점검. 후반 10분 교체 시나리오도 함께 검토.",
                folderId: baseFolder,
                createdAt: Date().addingTimeInterval(-86400 * 2)
            ),
            Note(
                id: UUID(),
                title: "스킬 드릴",
                content: "볼 터치 100회 워밍업 후, 양발 인사이드 패스 드릴과 2:2 론도 반복. 실수 빈도와 성공률을 간단히 체크하여 기록.",
                folderId: nil,
                createdAt: Date().addingTimeInterval(-86400 * 3)
            )
        ]
    }
}

#Preview {
    NoteTabView()
}
