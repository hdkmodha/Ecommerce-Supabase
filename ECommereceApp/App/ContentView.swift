//
//  ContentView.swift
//  ECommereceApp
//
//  Created by Hardik Modha on 20/04/26.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(AuthManager.self) private var authManager
    @Environment(UserManager.self) private var userManager
    
    var body: some View {
        Group {
            switch authManager.authState {
            case .authenticated:
                ProfileView()
            case .unauthenticated:
                LoginView()
            case .unknown:
                ProgressView()
            }
        }
        .task { await authManager.refreshUser() }
        .task(id: authManager.authState) {
            guard authManager.authState.isLoggedIn else { return }
            await userManager.fetchCurrentUser()
        }
    }
}

#Preview {
    ContentView()
        .environment(AuthManager())
}
