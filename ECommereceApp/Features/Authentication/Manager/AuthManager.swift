//
//  LoginViewModel.swift
//  ECommereceApp
//
//  Created by Hardik Modha on 20/04/26.
//

import Foundation
import Observation

enum AuthState {
    case authenticated
    case unauthenticated
    case unknown
    
    var isLoggedIn: Bool {
        return self == .authenticated
    }
}

@MainActor
@Observable
final class AuthManager {
    
    private let authService: SupabaseAuthService = .shared
    var authState: AuthState = .unknown
    var currentUserId: String?
    
    func signIn(withEmail email: String, andPassword password: String) async {
        do {
            self.currentUserId = try await authService.signIn(withEmail: email, password: password)
            self.authState = .authenticated
            print("Auth State: \(self.authState)")
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func signUp(withEmail email: String, andPassword password: String, andUsername username: String) async {
        do {
            self.currentUserId = try await authService.signUp(withEmail: email, andPassword: password, andUsername: username)
            self.authState = .authenticated
            print("Auth State: \(self.authState)")
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func signOut() async {
        do {
            try await authService.signOut()
            self.authState = .unauthenticated
            self.currentUserId = nil
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func refreshUser() async {
        do {
            if let userSessionID = try await authService.getCurrentUserSesstion() {
                self.authState = .authenticated
                self.currentUserId = userSessionID
            } else {
                self.authState = .unauthenticated
                self.currentUserId = nil
            }
        } catch {
            self.authState = .unauthenticated
            self.currentUserId = nil
            print(error.localizedDescription)
        }
    }
}
