//
//  ListingViewModel.swift
//  ECommereceApp
//
//  Created by Hardik Modha on 25/04/26.
//

import Foundation

@MainActor
@Observable
class ListingViewModel {
    
    var selectedCategory: Category? = nil {
        didSet {
            self.fileterdListing()
        }
    }
    
    private let service: ListingService = .service
    
    @ObservationIgnored
    private var productListing: [ProductListing] = []
    
    var filterListing: [ProductListing] = []
    
    
    func fetch() async {
        do {
            let listings = try await self.service.fetchingListing()
            self.productListing = listings
            self.selectedCategory = nil
        } catch {
            self.productListing = []
            self.filterListing = []
            self.selectedCategory = nil
        }
    }
    
    func fileterdListing() {
        filterListing = self.selectedCategory == nil ? productListing : productListing.filter({ $0.category == selectedCategory })
    }
    
}
