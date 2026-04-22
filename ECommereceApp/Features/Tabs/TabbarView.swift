//
//  TabbarView.swift
//  ECommereceApp
//
//  Created by Hardik Modha on 21/04/26.
//

import Foundation
import SwiftUI

enum Tabs: Hashable, CaseIterable {
    case feed
    case newItem
    case notification
    case profile
}

struct TabbarView: View {
    
    @State private var selectedTab: Tabs = .profile
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Feed", systemImage: "house", value: Tabs.feed) {
                Text("Feed View")
            }
            
            Tab("New Item", systemImage: "plus.circle", value: Tabs.newItem) {
                Text("New Item View")
            }
            
            Tab("Notification", systemImage: "heart", value: Tabs.notification) {
                Text("Notification")
            }
            
            Tab("Profile", systemImage: "person", value: Tabs.profile) {
                ProfileView()
            }
        }
    }
}

#Preview {
    TabbarView()
}
