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
    private let supabaseProvider: SupabaseProvider = .shared
    
    private let client: SupabaseClient
    
    private override init() {
        self.client = supabaseProvider.supabaseClient
    }
    
    func signIn(withEmail email: String, password: String) async throws -> String {
        let response = try await client.auth.signIn(email: email, password: password)
        return response.user.id.uuidString
    }
    
    func signUp(withEmail email: String, andPassword password: String, andUsername username: String) async throws -> String {
        let response = try await self.client.auth.signUp(email: email, password: password)
        let userId = response.user.id.uuidString
        try await self.createUser(withId: userId, email: email, andUsername: username)
        return userId
    }
    
    func signOut() async throws {
        try await client.auth.signOut()
    }
    
    func getCurrentUserSesstion() async throws -> String? {
        let supabaseUser = try await client.auth.session.user
        return supabaseUser.id.uuidString
    }
    
    private func createUser(withId id: String, email: String, andUsername username: String) async throws {
        let user = User(
            id: id,
            email: email,
            username: username,
            createdAt: Date(),
            totalSales: 0,
            itemsSold: 0,
            itemPurchased: 0
        )
        
        try await self.client
            .from(Constants.StringConstants.users)
            .insert(user)
            .execute()
    }
}
