//
//  AvatarView.swift
//  ECommereceApp
//
//  Created by Hardik Modha on 21/04/26.
//

import Foundation
import Kingfisher
import SwiftUI

enum AvatarSize {
    case xSmall
    case small
    case medium
    case large
    case xLarge
    
    var dimention: CGFloat {
        switch self {
        case .xSmall:
            return 40
        case .small:
            return 48
        case .medium:
            return 60
        case .large:
            return 80
        case .xLarge:
            return 96
        }
    }
}

struct AvatarView: View {
    
    private let imageUrl: String?
    private let profileImage: Image?
    private let size: AvatarSize
    private let onTap: (() -> Void)?
    
    init(imageUrl: String?, profileImage: Image?, size: AvatarSize = .small, onTap: (() -> Void)?) {
        self.imageUrl = imageUrl
        self.profileImage = profileImage
        self.size = size
        self.onTap = onTap
    }
    
    var body: some View {
        Group {
            if let imageUrl, let url = URL(string: imageUrl) {
                KFImage(url)
                    .resizable()
                    .scaledToFit()
                    .frame(width: size.dimention, height: size.dimention)
                    .clipShape(.circle)
                
            } else if let profileImage  {
                profileImage
                    .resizable()
                    .scaledToFit()
                    .frame(width: size.dimention, height: size.dimention)
                    .clipShape(.circle)
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: size.dimention, height: size.dimention)
                    .clipShape(.circle)
                    .foregroundStyle(Color(.systemGray6))
            }
        }
        .onTapGesture {
            if let onTap {
                onTap()
            }
        }
    }
}

#Preview {
    AvatarView(imageUrl: nil, profileImage: nil, size: .medium, onTap: nil)
}
