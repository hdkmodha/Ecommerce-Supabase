//
//  User.swift
//  ECommereceApp
//
//  Created by Hardik Modha on 20/04/26.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let email: String
    let username: String
    let createdAt: Date
    let profileImageUrl: String? = nil
    let totalSales: Double
    let itemsSold: Int
    let itemPurchased: Int
    
    private enum CodingKeys: String, CodingKey  {
        case id
        case email
        case username
        case createdAt = "created_at"
        case profileImageUrl = "profile_image_url"
        case totalSales = "total_sales"
        case itemsSold = "items_sold"
        case itemPurchased = "items_purchased"
    }
}

extension User {
    static var mock = User(
        id: UUID().uuidString,
        email: "hardik@gmail.com",
        username: "hdkmodha",
        createdAt: Date(),
        totalSales: 0,
        itemsSold: 0,
        itemPurchased: 0
    )
}


