//
//  ProfileView.swift
//  SupabaseAuth
//
//  Created by Abdulkarim Koshak on 5/10/25.
//

import SwiftUI

struct ProfileView: View {
    @Environment(AuthManager.self) private var authManager
    
    let user: UserModel
    
    var body: some View {
        VStack {
            Text(user.email)
                .padding()
            
            Button {
                signOut()
            } label: {
                Text("Sign Out")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(width: 352, height: 44)
                    .background(Color(.systemBlue))
                    .clipShape(.rect(cornerRadius: 8))
            }
        }
    }
}

private extension ProfileView {
    
    func signOut() {
        Task {
            await authManager.signOut()
        }
    }
}

#Preview {
    ProfileView(user: UserModel(id: UUID().uuidString, email: "test@gmail.com"))
        .environment(AuthManager())
}
