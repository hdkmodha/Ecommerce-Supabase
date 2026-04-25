//
//  ListingDetailView.swift
//  ECommereceApp
//
//  Created by Hardik Modha on 25/04/26.
//

import Kingfisher
import SwiftUI

struct ListingDetailView: View {
    
    @State private var viewModel: ListingDetailViewModel
    
    init(listing: ProductListing) {
        self._viewModel = State(initialValue: ListingDetailViewModel(listing: listing))
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                TabView {
                    ForEach(viewModel.listing.imageUrls, id: \.self) { imageUrl in
                        if let url  = URL(string: imageUrl) {
                            KFImage(url)
                                .resizable()
                                .frame(maxWidth: .infinity)
                        }
                    }
                }
                .frame(height: 400)
                .tabViewStyle(.page)
                
                HStack {
                    HStack(spacing: 8) {
                        if let seller = viewModel.seller {
                            AvatarView(
                                imageUrl: seller.imageUrl,
                                profileImage: nil,
                                size: .small,
                                onTap: nil
                            )
                            
                            
                            Text(seller.name)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                        }
                    }
                    
                    Spacer()
                    
                    Text("Likes: \(viewModel.listing.likesCount)")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
                
                Text(viewModel.listing.title)
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text(viewModel.listing.description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Text("$\(viewModel.listing.price.formatted())")
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }
            .padding(.horizontal, 16)
        }
        .toolbar(.hidden, for: .tabBar)
        .onAppear {
            viewModel.getSeller()
        }
        .safeAreaInset(edge: .bottom) {
            Button {
                
            } label: {
                Text("Purchase")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.green)
                    .foregroundStyle(.white)
                    .clipShape(.capsule)
                    .padding(.horizontal, 16)
                    
            }
        }
    }
}

#Preview {
    ListingDetailView(listing: ProductListing.mocks().first!)
}
