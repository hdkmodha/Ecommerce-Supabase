//
//  SupabaseAuthService.swift
//  ECommereceApp
//
//  Created by Hardik Modha on 20/04/26.
//

import Foundation
import Supabase

final class SupabaseAuthService: NSObject {
    
    static let shared: SupabaseAuthService = .init()
    
    private let client: SupabaseClient
    
    private override init() {
        self.client = SupabaseClient(
            supabaseURL: URL(string: Constants.StringConstants.projectURL)!,
            supabaseKey: Constants.StringConstants.apiKey
        )
    }
    
    func signIn(withEmail email: String, password: String) async throws -> String {
        let response = try await client.auth.signIn(email: email, password: password)
        return response.user.id.uuidString
    }
    
    func signUp(withEmail email: String, andPassword password: String, andUsername username: String) async throws -> String {
        let response = try await self.client.auth.signUp(email: email, password: password)
        let userId = response.user.id.uuidString
        return userId
    }
    
    func signOut() async throws {
        try await client.auth.signOut()
    }
    
    func getCurrentUserSesstion() async throws -> String? {
        let supabaseUser = try await client.auth.session.user
        return supabaseUser.id.uuidString
    }
}
