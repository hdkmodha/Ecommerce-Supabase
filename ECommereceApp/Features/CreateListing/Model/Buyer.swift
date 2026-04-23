//
//  Buyer.swift
//  ECommereceApp
//
//  Created by Hardik Modha on 23/04/26.
//


import Foundation

struct Buyer: Codable, Identifiable, Hashable {
    var id: String
    var name: String
    var imageUrl: String?
    var purchasedAt: Date?
    
    private enum CodingKeys: String, CodingKey {
        case id, name
        case imageUrl = "image_url"
        case purchasedAt = "purchased_at"
    }
}
