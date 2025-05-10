//
//  AuthService.swift
//  SupabaseAuth
//
//  Created by Abdulkarim Koshak on 5/10/25.
//

import Foundation
import Supabase

struct AuthService {
    private let client: SupabaseClient
    
    init() {
        self.client = SupabaseClient.init(
            supabaseURL: URL(string: Constants.projectURLString)!,
            supabaseKey: Constants.projectAPIKey
        )
    }
    
    func signUp(email: String, password: String) async throws -> UserModel {
        let response = try await client.auth.signUp(email: email, password: password)
        
        guard let email = response.user.email else {
            print("DEBUG: Email not found")
            throw NSError()
        }
        
        return UserModel(id: response.user.aud, email: email)
    }
    
    func signIn(email: String, password: String) async throws -> UserModel {
        let response = try await client.auth.signIn(email: email, password: password)
        
        guard let email = response.user.email else {
            print("DEBUG: Email not found")
            throw NSError()
        }
        
        return UserModel(id: response.user.aud, email: email)
    }
    
    func signOut() async throws {
        try await client.auth.signOut()
    }
    
    func getCurrentUser() async throws -> UserModel? {
        let supabaseUser = try await client.auth.session.user
        
        guard let email = supabaseUser.email else {
            print("DEBUG: Email not found")
            throw NSError()
        }
        
        return UserModel(id: supabaseUser.aud, email: email)
    }
}
