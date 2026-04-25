//
//  ListingDetailViewModel.swift
//  ECommereceApp
//
//  Created by Hardik Modha on 25/04/26.
//

import Foundation

@MainActor
@Observable
final class ListingDetailViewModel {
    
    var listing: ProductListing
    var seller: Seller?
    
    private let service = ListingService.service
    
    init(listing: ProductListing) {
        self.listing = listing
        
    }
    
    func getSeller() {
        Task {
            do {
                let seller = try await service.getSeller(forId: listing.sellerID)
                self.seller = seller
            } catch {
                seller = nil
            }
        }
    }
}
