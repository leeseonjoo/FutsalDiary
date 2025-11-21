import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""

    var body: some View {
        ZStack {
            Image("background_5")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack(spacing: 16) {
                Text("로그인")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundStyle(.white)

                VStack(spacing: 12) {
                    TextField("아이디", text: $username)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(20)
                        .frame(maxWidth: 320)
                        .textInputAutocapitalization(.never)

                    SecureField("비밀번호", text: $password)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(20)
                        .frame(maxWidth: 320)
                }

                HStack(spacing: 16) {
                    Button(action: {
                        // TODO: 나중에 실제 로그인 로직 넣기
                    }) {
                        Text("로그인")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                    .tint(.white)
                    .foregroundColor(.white)
                    .controlSize(.large)
                    .frame(maxWidth: 140)

                    Button(action: {
                        // TODO: 회원가입 화면으로 이동
                    }) {
                        Text("회원가입")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                    .tint(.white)
                    .foregroundColor(.white)
                    .controlSize(.large)
                    .frame(maxWidth: 140)
                }

                // ⬇️ 테스트용 관리자 모드 진입 버튼
                NavigationLink {
                    MainHomeView()
                } label: {
                    Text("관리자 모드로 홈 화면 열기 (테스트용)")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.8))
                        .underline()
                }
                .padding(.top, 8)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
        }
    }
}

#Preview {
    NavigationStack {
        LoginView()
    }
}
