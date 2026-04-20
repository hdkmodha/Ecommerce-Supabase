//
//  RegistrationView.swift
//  ECommereceApp
//
//  Created by Hardik Modha on 20/04/26.
//

import SwiftUI


struct RegistrationView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(AuthManager.self) var authManager
    
    @State var email: String = ""
    @State var username: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @State var passwordMatch: Bool = false
    @State var isLoading: Bool = false
    
    
    var body: some View {
        VStack(spacing: 8) {
            
            Spacer()
            
            Image(.supabase)
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .padding()
            
            TextField("Email", text: $email)
                .appField()
            
            TextField("username", text: $username)
                .appField()
            
            HStack {
                SecureField("Password", text: $password)
                Spacer()
                Image(systemName: passwordMatch ? "checkmark.circle.fill" : "xmark.circle.fill")
                    .foregroundStyle(passwordMatch ? .green : .red)
            }
            .appField()
            
            HStack {
                SecureField("Confirm Password", text: $confirmPassword)
                Spacer()
                Image(systemName: passwordMatch ? "checkmark.circle.fill" : "xmark.circle.fill")
                    .foregroundStyle(passwordMatch ? .green : .red)
                    
            }
            .appField()
            
            Button {
                self.signUp()
            } label: {
                Text("Sign Up")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.green)
                    .foregroundStyle(.white)
                    .clipShape(.capsule)
                    .padding(.horizontal, 16)
            }
            .disabled(!isFormValid)
            .opacity(isFormValid ? 1.0 : 0.5)
            
            Spacer()
            
            Divider()
            Button {
                dismiss()
            } label: {
                HStack(spacing: 3)  {
                    Text("Don't hava an account?")
                    Text("Sign In")
                        .fontWeight(.semibold)
                }
                .font(.subheadline)
                .foregroundStyle(.green)
            }
            .padding(.vertical, 16)
        }
        .onChange(of: confirmPassword) { oldValue, newValue in
            passwordMatch = newValue == password
        }
    }
}

private extension RegistrationView {
    
    func signUp() {
        Task {
            isLoading = true
            await authManager.signUp(
                withEmail: email,
                andPassword: password,
                andUsername: username
            )
            isLoading = false
            
        }
    }
    
    var isFormValid: Bool {
        return email.isValidEmail && passwordMatch && username.count > 1
    }
}

#Preview {
    RegistrationView()
}
