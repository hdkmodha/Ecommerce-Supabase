//
//  ECommereceAppApp.swift
//  ECommereceApp
//
//  Created by Hardik Modha on 20/04/26.
//

import SwiftUI

@main
struct ECommereceAppApp: App {
    
    @State private var authManager: AuthManager = AuthManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(authManager)
        }
    }
}
