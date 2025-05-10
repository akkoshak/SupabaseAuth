//
//  ContentView.swift
//  SupabaseAuth
//
//  Created by Abdulkarim Koshak on 5/9/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(AuthManager.self) private var authManager
    
    var body: some View {
        Group {
            if let currentUser = authManager.currentUser {
                ProfileView(user: currentUser)
            } else {
                LoginView()
            }
        }
        .task {
            await authManager.refreshUser()
        }
    }
}

#Preview {
    ContentView()
        .environment(AuthManager())
}
