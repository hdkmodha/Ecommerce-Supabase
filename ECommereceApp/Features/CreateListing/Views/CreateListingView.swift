//
//  CreateListingView.swift
//  ECommereceApp
//
//  Created by Hardik Modha on 22/04/26.
//

import PhotosUI
import SwiftUI

struct CreateListingView: View {
    
    @Environment(UserManager.self) var userManager
    
    @State private var title: String = ""
    @State private var price: String = ""
    @State private var description: String = ""
    @State private var category: Category = .electronics
    @State private var pickedPhotoImage = [PhotosPickerItem]()
    @State private var selectedImages = [UIImage]()
    
    @State private var viewModel: CreateListingViewModel = .init()
    
    
    var body: some View {
        NavigationStack {
            Form {
                
                Section("Details") {
                    TextField("Title", text: $title)
                    TextField("Price", text: $price)
                    Picker("Category", selection: $category) {
                        ForEach(Category.allCases, id: \.self) { category in
                            Text(category.description)
                                .foregroundStyle(.black)
                                .tag(category)
                        }
                    }
                    .pickerStyle(.navigationLink)
                    .tint(.black)
                }
                
                Section("Description") {
                    TextField("Description", text: $description, axis: .vertical)
                        .lineLimit(5, reservesSpace: true)
                }
                
                Section("Photos") {
                    VStack(alignment: .leading, spacing: 8) {
                        ListingImagesView(
                            pickedPhotos: $pickedPhotoImage,
                            selectedImages: $selectedImages
                        )
                        Divider()
                        
                        Text("You can upload up to 5 photos")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                            .padding(.vertical, 4)
                    }
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
                        onSubmit()
                    }
                }
            }
        }
    }
}

private extension CreateListingView {
    
    func clearAll() {
        self.title = ""
        self.price = ""
        self.description = ""
        self.category = .electronics
        self.selectedImages = []
        self.pickedPhotoImage = []
    }
    
    func onSubmit()  {
        
        guard
            let price = Double(price.trimmed),
            let user = userManager.currentUser else { return }
        
        let imagesData: [Data] = selectedImages.map { $0.jpegData(compressionQuality: 0.5) ?? Data() }
        
        
        Task {
            do {
                try await viewModel.createListing(withTitle: title, description: description, price: price, category: category, images: imagesData, user: user)
                self.clearAll()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    CreateListingView()
}
