//
//  LoginView.swift
//  ECommereceApp
//
//  Created by Hardik Modha on 20/04/26.
//

import Foundation
import SwiftUI

struct LoginView: View {
    
    @Environment(AuthManager.self) private var authManager
    
    @State var email: String = ""
    @State var password: String = ""
    @State var isLoading: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center, spacing: 16) {
                Spacer()
                Image(.supabase)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .padding()
                VStack(spacing: 16) {
                    TextField("Email", text: $email)
                        .appField()
                    SecureField("Password", text: $password)
                        .appField()
                }
                
                Button {
                    self.signIn()
                } label: {
                    Text("Login")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.green)
                        .foregroundStyle(.white)
                        .clipShape(.capsule)
                        .padding(.horizontal, 16)
                        
                }
//                .disabled(!isFormValid)
//                .opacity(isFormValid ? 1.0 : 0.5)
                
                
                Spacer()
                
                
                Divider()
                
                NavigationLink {
                    RegistrationView()
                        .navigationBarBackButtonHidden()
                } label: {
                    HStack(spacing: 3)  {
                        Text("Don't hava an account?")
                        Text("Sign Up")
                            .fontWeight(.semibold)
                    }
                    .font(.subheadline)
                    .foregroundStyle(.green)
                }
                .padding(.vertical, 16)

            }
        }
    }
}

private extension LoginView {
    func signIn() {
        Task {
            isLoading = true
            await authManager.signIn(
                withEmail: email,
                andPassword: password
            )
            isLoading = false
        }
    }
    
    var isFormValid: Bool {
        return email.isValidURL && !password.isEmpty
    }
}

#Preview {
    LoginView()
}
