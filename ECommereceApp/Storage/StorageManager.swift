//
//  StorageManager.swift
//  ECommereceApp
//
//  Created by Hardik Modha on 21/04/26.
//

import Foundation
import Supabase

struct StorageManager: SupabaseProvider {
    
//    static let shared: StorageManager = .init()
    
    internal var client: SupabaseClient
    private let provider: SupabaseManager = .shared
    
    private let avatarBucketName = Constants.StringConstants.avatars
    private let listingImagesName = Constants.StringConstants.listingImages
    
    init() {
        self.client = provider.supabaseClient
    }
    
    func uploadProfilePhoto(for user: User, imageData: Data) async throws -> String {
        let path = "\(user.id)/avatar.jpg"
        
        let fullPath = try await self.client.storage
            .from(avatarBucketName)
            .update(path, data: imageData)
            .path
        
        print("Full path: \(fullPath)")
        
        let publicURL = "\(Constants.StringConstants.projectURL)/storage/v1/object/public/avatars/\(path)"
        
        return publicURL
        
    }
    
    func uploadImage(for listing: ProductListing, data: Data, index: Int) async throws -> String {
        let path = "\(listing.id)/\(index).jpg"
        
        let fullPath = try await self.client.storage
            .from(self.listingImagesName)
            .update(path, data: data)
            .path
        
        print("Path: \(fullPath)")
        
        let publicURL = "\(Constants.StringConstants.projectURL)/storage/v1/object/public/\(self.listingImagesName)/\(path)"
        
        return publicURL
    }
    
    
}
