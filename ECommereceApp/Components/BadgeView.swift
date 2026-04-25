//
//  BadgeView.swift
//  ECommereceApp
//
//  Created by Hardik Modha on 25/04/26.
//

import SwiftUI

struct BadgeView: View {
    let title: String
    var isSelected: Bool
    var selectedBackgroundColor: Color = .blue
    var unselectedBackgroundColor: Color = Color(.systemGroupedBackground)
    var selectedForeGroudColor: Color = .white
    var unselectedForeGroundColor: Color = .primary
    
    
    
    
    var body: some View {
        Text(title)
            .font(.subheadline)
            .fontWeight(.semibold)
            .foregroundStyle(isSelected ? selectedForeGroudColor : unselectedForeGroundColor)
            .padding(.vertical, 6)
            .padding(.horizontal, 12)
            .background(isSelected ? selectedBackgroundColor : unselectedBackgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    HStack {
        BadgeView(title: "Selected", isSelected: true)
        BadgeView(title: "unselected", isSelected: false)
    }
}
