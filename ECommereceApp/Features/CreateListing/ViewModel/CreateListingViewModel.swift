//
//  CreateListingViewModel.swift
//  ECommereceApp
//
//  Created by Hardik Modha on 23/04/26.
//

import Foundation


@MainActor
@Observable
final class CreateListingViewModel {
    
    private let service: CreateListingService = .shared
    private let userManager: UserManager  = .init()
    
    func createListing(withTitle title: String, description: String, price: Double, category: Category, images: [Data], user: User) async throws {
        
        try await service.createListing(
            withTitle: title,
            description: description,
            price: price,
            category: category,
            images: images,
            user: user
        )
    }
    
    
    
}

