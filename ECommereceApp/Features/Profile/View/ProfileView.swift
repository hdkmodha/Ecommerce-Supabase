//
//  ProfileView.swift
//  ECommereceApp
//
//  Created by Hardik Modha on 20/04/26.
//

import SwiftUI


struct ProfileView: View {
    
    @Environment(AuthManager.self) private var authManager
    @Environment(UserManager.self) private var userManager
    
    var body: some View {
        NavigationStack {
            List {
                
                Section {
                    HStack {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 72, height: 72)
                            .foregroundStyle(.secondary)
                        if let currentUser = userManager.currentUser {
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
        
    }
    
    private func signOut() {
        Task {
            await authManager.signOut()
        }
    }
}

#Preview {
    ProfileView()
        .environment(AuthManager())
        .environment(UserManager())
}
