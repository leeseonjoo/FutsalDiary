import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""

    var body: some View {
        ZStack {
            Image("Background_4")
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
                    Button(action: {}) {
                        Text("로그인")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                    .tint(.white)
                    .foregroundColor(.white)
                    .controlSize(.large)
                    .frame(maxWidth: 140)

                    Button(action: {}) {
                        Text("회원가입")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                    .tint(.white)
                    .foregroundColor(.white)
                    .controlSize(.large)
                    .frame(maxWidth: 140)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
        }
    }
}

#Preview {
    LoginView()
}
