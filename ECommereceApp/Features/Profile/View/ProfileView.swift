//
//  ProfileView.swift
//  ECommereceApp
//
//  Created by Hardik Modha on 20/04/26.
//

import PhotosUI
import SwiftUI


struct ProfileView: View {
    
    @Environment(AuthManager.self) private var authManager
    @Environment(UserManager.self) private var userManager
    
    @State private var isPresented: Bool = false
    @State private var selectedItem: PhotosPickerItem?
    @State private var profileImage: Image?
    
    var body: some View {
        NavigationStack {
            List {
                if let currentUser = userManager.currentUser {
                    Section {
                        HStack {
                            AvatarView(
                                imageUrl: currentUser.profileImageUrl,
                                profileImage: profileImage,
                                size: .large
                            ) {
                                self.isPresented.toggle()
                            }
                            
                            VStack(alignment: .leading) {
                                Text(currentUser.username)
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.black)
                                Text(currentUser.email)
                                    .font(.subheadline)
                                    .fontWeight(.regular)
                                    .foregroundStyle(.secondary)
                                
                            }
                        }
                    }
                    
                    Section("Account") {
                        Button {
                            self.signOut()
                        } label: {
                            Text("Sign Out")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundStyle(.red)
                        }
                    }
                }
            }
            .navigationTitle("Profile")
        }
        .photosPicker(isPresented: $isPresented, selection: $selectedItem)
        .task(id: selectedItem) {
            await onImageSelected()
        }
        
    }
    
    private func signOut() {
        Task {
            await authManager.signOut()
        }
    }
}

private extension ProfileView {
    func onImageSelected() async {
        guard let selectedItem, let user = userManager.currentUser else { return }
        
        do {
            guard let data = try await selectedItem.loadTransferable(type: Data.self) else { return }
            guard let uiImage = UIImage(data: data) else { return }
            guard let imageData = uiImage.jpegData(compressionQuality: 0.5) else { return }
            self.profileImage = Image(uiImage: uiImage)
            let imageUrl = try await StorageManager.shared.uploadProfilePhoto(for: user, imageData: imageData)
            await userManager.updateProfileImageURL(imageUrl)
                    
        } catch {
            print(error.localizedDescription)
        }
        
        
    }
    
}

#Preview {
    ProfileView()
        .environment(AuthManager())
        .environment(UserManager())
}
