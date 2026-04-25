//
//  FeedListingView.swift
//  ECommereceApp
//
//  Created by Hardik Modha on 23/04/26.
//

import SwiftUI

struct FeedListingView: View {
    
    @State private var viewModel: ListingViewModel = .init()
    
    let columns: [GridItem] = [
        .init(.adaptive(minimum: 170), spacing: 8)
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                //MARK: - Category View
                Section {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            Button {
                                viewModel.selectedCategory = nil
                            } label: {
                                BadgeView(title: "All", isSelected: viewModel.selectedCategory == nil)
                            }
                            
                            ForEach(Category.allCases) { category in
                                Button {
                                    viewModel.selectedCategory = category
                                } label: {
                                    BadgeView(title: category.description, isSelected: viewModel.selectedCategory == category)
                                }
                            }
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                    }
                    
                    
                }
                
                
                // Feed View
                Section {
                    if viewModel.filterListing.isEmpty {
                        VStack {
                            Spacer()
                            ContentUnavailableView("No records", image: "")
                            Spacer()
                        }
                    } else {
                        LazyVGrid(columns: columns, alignment: .center, spacing: 24) {
                            ForEach(viewModel.filterListing, id: \.id) { item in
                                FeedCell(listing: item)
                            }
                            
                        }
                        .animation(.smooth, value: viewModel.selectedCategory)
                    }
                    
                }
                .padding(.vertical, 8)
            }
            .navigationTitle("Marketplace")
            .task {
                await viewModel.fetch()
            }
        }
        
    }
}



#Preview {
    FeedListingView()
}
