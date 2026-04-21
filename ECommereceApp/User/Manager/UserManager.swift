//
//  UserManager.swift
//  ECommereceApp
//
//  Created by Hardik Modha on 20/04/26.
//

import Foundation
import Supabase

@MainActor
@Observable
final class UserManager {
    
    var currentUser: User?
    var isLoading: Bool = false
    
    private let userService: UserService = .service
    
    func fetchCurrentUser() async {
        isLoading = true
        defer { isLoading = false }
        do {
            self.currentUser = try await userService.fetchCurrentUser()
            print("User: \(currentUser)")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateProfileImageURL(_ imageURL: String) async {
        do {
            try await userService.updateProfileImageURL(imageURL)
            self.currentUser?.profileImageUrl = imageURL
        } catch {
            print(error.localizedDescription)
        }
    }
}
