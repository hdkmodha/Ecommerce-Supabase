//
//  CreateListingView.swift
//  ECommereceApp
//
//  Created by Hardik Modha on 22/04/26.
//

import SwiftUI

struct CreateListingView: View {
    
    @State private var title: String = ""
    @State private var price: String = ""
    @State private var description: String = ""
    
    
    var body: some View {
        NavigationStack {
            Form {
                
                Section("Details") {
                    TextField("Title", text: $title)
                    TextField("Price", text: $price)
                }
                
                Section("Description") {
                    TextField("Description", text: $description, axis: .vertical)
                        .lineLimit(5, reservesSpace: true)
                }
                
                Section("Photos") {
                    
                }
            }
            .navigationTitle("New Listing")
            .toolbar {
                
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Post") {
                        
                    }
                }
            }
        }
    }
}

#Preview {
    CreateListingView()
}
