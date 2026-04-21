//
//  StorageManager.swift
//  ECommereceApp
//
//  Created by Hardik Modha on 21/04/26.
//

import Foundation
import Supabase

struct StorageManager {
    
    static let shared: StorageManager = .init()
    
    private let client: SupabaseClient
    private let provider: SupabaseProvider = .shared
    
    init() {
        self.client = provider.supabaseClient
    }
    
    func uploadProfilePhoto(for user: User, imageData: Data) async throws -> String {
        let path = "\(user.id)/avatar.jpg"
        
        let fullPath = try await self.client.storage
            .from("avatars")
            .update(path, data: imageData)
            .path
        
        print("Full path: \(fullPath)")
        
        let publicURL = "\(Constants.StringConstants.projectURL)/storage/v1/object/public/avatars/\(path)"
        
        return publicURL
        
    }
    
    
}
