//
//  ListingImagesView.swift
//  ECommereceApp
//
//  Created by Hardik Modha on 22/04/26.
//

import PhotosUI
import SwiftUI

struct ListingImagesView: View {
    
    @Binding var pickedPhotos: [PhotosPickerItem]
    @Binding var selectedImages: [UIImage]
    
    var body: some View {
        VStack(spacing: 12) {
            
            PhotosPicker(
                selection: $pickedPhotos,
                maxSelectionCount: 5,
                matching: .images
            ) {
                Label("Add Photos", systemImage: "photo.on.rectangle")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .disabled(self.selectedImages.count == 5)
            .task(id: pickedPhotos) {
                await onPhotosSelected()
            }
            
            
            if !self.pickedPhotos.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(Array(selectedImages.enumerated()), id: \.offset) {
                            index,
                            image in
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 80, height: 80)
                                .clipped()
                                .cornerRadius(8)
                                .overlay(
                                    alignment: .topTrailing
                                ) {
                                    Button {
                                        selectedImages.remove(at: index)
                                    } label: {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundStyle(.white, .red)
                                    }
                                    .offset(x: 6, y: -6)
                                    
                                }
                                .padding(.vertical)
                        }
                        
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
        
    }
}

private extension ListingImagesView {
    func onPhotosSelected() async {
        var newImages: [UIImage] = []
        
        for item in pickedPhotos {
            guard let data = try? await item.loadTransferable(type: Data.self), let image = UIImage(data: data) else { return }
            newImages.append(image)
        }
        selectedImages = newImages
    }
}

#Preview {
    
    @Previewable @State var pickedPhotoImage = [PhotosPickerItem]()
    @Previewable @State var selectedImages = [UIImage]()
    
    ListingImagesView(
        pickedPhotos: $pickedPhotoImage,
        selectedImages: $selectedImages
    )
}
