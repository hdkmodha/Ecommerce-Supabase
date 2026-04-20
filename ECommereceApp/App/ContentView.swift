//
//  ContentView.swift
//  ECommereceApp
//
//  Created by Hardik Modha on 20/04/26.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(AuthManager.self) var authManager
    
    var body: some View {
        Group {
            switch authManager.authState {
            case .authenticated:
                Text("Home Screen")
            case .unauthenticated:
                LoginView()
            case .unknown:
                ProgressView()
            }
        }
        .task {
            await authManager.refreshUser()
        }
    }
}

#Preview {
    ContentView()
        .environment(AuthManager())
}
