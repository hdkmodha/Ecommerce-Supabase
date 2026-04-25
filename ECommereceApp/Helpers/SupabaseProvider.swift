//
//  SupabaseProvider.swift
//  ECommereceApp
//
//  Created by Hardik Modha on 20/04/26.
//

import Foundation
import Supabase

protocol SupabaseProvider {
    var client: SupabaseClient { get set }
}

final class SupabaseManager: NSObject {
    
    static let shared: SupabaseManager = .init()
    
    private let client: SupabaseClient
    
    private override init() {
        self.client = SupabaseClient(
            supabaseURL: URL(string: Constants.StringConstants.projectURL)!,
            supabaseKey: Constants.StringConstants.apiKey
        )
    }
    
    var supabaseClient: SupabaseClient {
        return self.client
    }
}

