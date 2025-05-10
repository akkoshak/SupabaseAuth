//
//  SupabaseAuthApp.swift
//  SupabaseAuth
//
//  Created by Abdulkarim Koshak on 5/9/25.
//

import SwiftUI

@main
struct SupabaseAuthApp: App {
    @State private var authManager = AuthManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(authManager)
        }
    }
}
