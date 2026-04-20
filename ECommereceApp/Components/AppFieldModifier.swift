//
//  AppFieldModifier.swift.swift
//  ECommereceApp
//
//  Created by Hardik Modha on 20/04/26.
//


import SwiftUI

struct AppFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .autocapitalization(.none)
            .font(.subheadline)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal, 16)
    }
}

#Preview {
    Text("Hello, world!")
        .modifier(AppFieldModifier())
}

