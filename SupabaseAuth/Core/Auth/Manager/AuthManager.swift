//
//  AuthManager.swift
//  SupabaseAuth
//
//  Created by Abdulkarim Koshak on 5/10/25.
//

import Foundation
import Observation

@MainActor
@Observable class AuthManager {
    private let authService: AuthService
    
    var currentUser: UserModel?
    
    init(authService: AuthService = AuthService()) {
        self.authService = authService
    }
    
    func signUp(email: String, password: String) async {
        do {
            self.currentUser = try await authService.signUp(email: email, password: password)
        } catch {
            print("DEBUG: Error signing up: \(error.localizedDescription)")
        }
    }
    
    func signIn(email: String, password: String) async {
        do {
            self.currentUser = try await authService.signIn(email: email, password: password)
        } catch {
            print("DEBUG: Error signing in: \(error.localizedDescription)")
        }
    }
    
    func signOut() async {
        do {
            try await authService.signOut()
            currentUser = nil
        } catch {
            print("DEBUG: Error signing out: \(error.localizedDescription)")
        }
    }
    
    func refreshUser() async {
        do {
            self.currentUser = try await authService.getCurrentUser()
        } catch {
            print("DEBUG: Error refreshing user: \(error.localizedDescription)")
            currentUser = nil
        }
    }
}
