//
//  CreateListingService.swift
//  ECommereceApp
//
//  Created by Hardik Modha on 23/04/26.
//

import Foundation
import Supabase

enum Result<A> {
    case fetched(A)
    case none
    
    var value: A? {
        switch self {
        case .fetched(let a):
            return a
        case .none:
            return nil
        }
    }
}

struct CreateListingService {
    
    static let shared: CreateListingService = .init()
    
    private let client: SupabaseClient
    private let provider = SupabaseProvider.shared
    
    private let sellerTable = Constants.StringConstants.seller
    private let productListingTable = Constants.StringConstants.productListing
    
    init() {
        self.client = provider.supabaseClient
    }
    
    func createListing(
        withTitle title: String,
        description: String,
        price: Double,
        category: Category,
        images: [Data],
        user: User
    ) async throws {
        
        var sellerID: String = ""
        
        let result = await self.getSeller(from: user)
        
        switch result {
        case .fetched(let seller):
            sellerID = seller.id
        case .none:
            let seller = Seller(id: user.id, name: user.username, imageUrl: user.profileImageUrl)
            try await self.client
                .from(self.sellerTable)
                .insert(seller)
                .execute()
            sellerID = seller.id
        }
        
        
        
        
        
        var listing = ProductListing(
            id: UUID().uuidString,
            title: title,
            description: description,
            price: price,
            imageUrls: [],
            category: category,
            createdAt: Date(),
            likesCount: 0,
            status: .active,
            isFavourite: false,
            sellerID: sellerID
        )
        
        let imageUrls = try await self.uploadImages(for: listing, data: images)
        listing.imageUrls = imageUrls
        
        
        try await self.client
            .from(self.productListingTable)
            .insert(listing)
            .execute()
    }
    
    private func uploadImages(for listing: ProductListing, data: [Data]) async throws -> [String] {
        let manager = StorageManager()
        var images: [String] = []
        
        for (index, item) in data.enumerated() {
            let imageUrl = try await manager.uploadImage(for: listing, data: item, index: index)
            images.append(imageUrl)
        }
        
        return images
    }
    
    func getSeller(from user: User) async -> Result<Seller> {
        
        do {
            let seller: Seller = try await self.client
                .from(self.sellerTable)
                .select()
                .eq("id", value: user.id)
                .single()
                .execute()
                .value
            return .fetched(seller)
        } catch {
            print(error.localizedDescription)
            return .none
        }
    }
}
