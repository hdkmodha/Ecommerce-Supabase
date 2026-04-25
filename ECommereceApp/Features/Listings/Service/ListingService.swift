//
//  ListingService.swift
//  ECommereceApp
//
//  Created by Hardik Modha on 25/04/26.
//

import Foundation
import Supabase

class ListingService: SupabaseProvider {
    
    static let service: ListingService = .init()
    
    var client: SupabaseClient
    private let manager: SupabaseManager = .shared
    private let productListingTable = Constants.StringConstants.productListing
    
    init() {
        self.client = manager.supabaseClient
    }
    
    func fetchingListing() async throws -> [ProductListing] {
        return try await self.client
            .from(self.productListingTable)
            .select()
            .eq("status", value: Status.active.rawValue)
            .execute()
            .value
    }
    
}
