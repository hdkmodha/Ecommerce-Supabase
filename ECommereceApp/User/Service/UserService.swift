//
//  UserService.swift
//  ECommereceApp
//
//  Created by Hardik Modha on 20/04/26.
//

import Foundation
import Supabase

struct UserService {
    
    static let service: UserService = .init()
    
    
    private let supabaseProvider: SupabaseProvider = .shared
    private let client: SupabaseClient
    
    private init() {
        self.client = supabaseProvider.supabaseClient
    }
    
    func fetchCurrentUser() async throws -> User {
        let supabaseUser = try await client.auth.session.user
        
        return try await client.from(Constants.StringConstants.users)
            .select()
            .eq("id", value: supabaseUser.id.uuidString)
            .single()
            .execute()
            .value
    }
}
