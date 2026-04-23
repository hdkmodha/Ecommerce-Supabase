//
//  ProductListing.swift
//  ECommereceApp
//
//  Created by Hardik Modha on 23/04/26.
//

import Foundation


enum Category: String, Identifiable, Codable, CaseIterable, CustomStringConvertible {
    case electronics
    case fashion
    case home
    case sports
    case automotive
    case beauty
    case appliances
    case other
    
    var id: String { self.rawValue }
    
    var description: String {
        switch self {
        case .electronics: return "Electronics"
        case .fashion: return "Fashion"
        case .home: return "Home"
        case .sports: return "Sports"
        case .automotive: return "Automotive"
        case .beauty: return "Beauty"
        case .appliances: return "Appliances"
        case .other: return "Other"
        }
    }
}

enum Status: String, Codable {
    case active
    case inactive
    case purchased
}


struct ProductListing: Codable, Identifiable, Hashable {
    var id: String
    var title: String
    var description: String
    var price: Double
    var imageUrls: [String]
    var category: Category
    var createdAt: Date
    var likesCount: Int
    var status: Status
    var isFavourite: Bool
    
   
    var sellerID: String
    var buyerID: String?
    
    private enum CodingKeys: String, CodingKey {
        case id, title, description, price, category,
             status
        case imageUrls = "image_urls"
        case likesCount = "likes_count"
        case isFavourite = "is_favourite"
        case createdAt = "created_at"
        case sellerID = "seller_id"
        case buyerID = "buyer_id"
    }
}
