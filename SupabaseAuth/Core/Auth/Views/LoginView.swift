//
//  LoginView.swift
//  SupabaseAuth
//
//  Created by Abdulkarim Koshak on 5/10/25.
//

import SwiftUI

struct LoginView: View {
    @Environment(AuthManager.self) private var authManager
    
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                Image(.supabase)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .padding()
                
                VStack(spacing: 8) {
                    TextField("Enter your email", text: $email)
                        .textInputAutocapitalization(.never)
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .clipShape(.rect(cornerRadius: 10))
                        .padding(.horizontal, 24)
                    
                    SecureField("Enter your password", text: $password)
                        .font(.subheadline)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .clipShape(.rect(cornerRadius: 10))
                        .padding(.horizontal, 24)
                }
                
                Button {
                    signIn()
                } label: {
                    Text("Login")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(width: 352, height: 44)
                        .background(Color(.systemBlue))
                        .clipShape(.rect(cornerRadius: 8))
                }
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1.0 : 0.5)
                .padding(.vertical)
                
                Spacer()
                
                Divider()
                
                NavigationLink {
                    RegistrationView()
                        .navigationBarBackButtonHidden()
                } label: {
                    HStack(spacing: 3) {
                        Text("Don't have an account?")
                        
                        Text("Sign Up")
                            .fontWeight(.semibold)
                    }
                    .font(.subheadline)
                }
                .padding(.vertical, 16)
            }
        }
    }
}

private extension LoginView {
    
    func signIn() {
        Task {
            await authManager.signIn(email: email, password: password)
        }
    }
    
    var formIsValid: Bool {
        email.isValidEmail() && !password.isEmpty
    }
}

#Preview {
    LoginView()
        .environment(AuthManager())
}
