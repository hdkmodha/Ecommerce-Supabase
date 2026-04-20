//
//  SupabaseProvider.swift
//  ECommereceApp
//
//  Created by Hardik Modha on 20/04/26.
//

import Foundation
import Supabase

final class SupabaseProvider: NSObject {
    
    static let shared: SupabaseProvider = .init()
    
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

