//
//  FeedCell.swift
//  ECommereceApp
//
//  Created by Hardik Modha on 25/04/26.
//

import SwiftUI
import Kingfisher

struct FeedCell: View {
    
    var listing: ProductListing
    
    private let itemWidth: CGFloat = 180
    private let itemHeight: CGFloat = 164
    
    init(listing: ProductListing) {
        self.listing = listing
    }
    
    var body: some View {
        VStack(spacing: 0) {
            if let imageUrls = listing.imageUrls.first, let url = URL(string: imageUrls) {
                KFImage(url)
                    .resizable()
                    .scaledToFill()
                    .frame(width: itemWidth, height: itemHeight)
                    .clipShape(.rect)
            }
            
            VStack(alignment: .leading, spacing: 6) {
                Text(listing.category.description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                Text(listing.title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Text("$\(listing.price.formatted())")
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundStyle(.black)
            .padding(.vertical, 6)
            .padding(.leading, 8)
            .background(Color(.systemGroupedBackground))
        }
        .frame(width: itemWidth)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .black.opacity(0.2), radius: 4)
        .overlay(alignment: .topTrailing) {
            Button {
//                listing.toggleFavourite()
            } label: {
                Image(systemName: listing.isFavourite ? "heart.fill" : "heart")
                    .padding(.all, 5)
                    .background(in: .circle)
                    .foregroundStyle(listing.isFavourite ? .red : .black)
                    .frame(width: 40, height: 40)
                    
            }

        }
    }
}

#Preview {
    FeedCell(listing: ProductListing.mocks().first!)
}
