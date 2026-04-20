//
//  View+Extension.swift
//  ECommereceApp
//
//  Created by Hardik Modha on 20/04/26.
//

import SwiftUI

extension View {
    
    func appField() -> some View {
        self.modifier(AppFieldModifier())
    }
}
