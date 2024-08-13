//
//  AppleSignInPassword.swift
//  anime-v2
//
//  Created by Jason Morales on 8/4/24.
//

import SwiftUI
import AuthenticationServices

struct AppleSignInPassword: View {
    @Environment(\.colorScheme) var currentScheme
    @AppStorage("id") private var id: String = ""
    @AppStorage("firstName") private var firstName: String = ""
    @AppStorage("lastName") private var lastName: String = ""
    @AppStorage("email") private var email: String = ""
    
    var body: some View {
        if currentScheme == .dark {
            SignInWithAppleButton (.signIn) { request in
                request.requestedScopes = [.fullName, .email]
            } onCompletion: { result in
                switch result {
                case .success(let authResults):
                    guard let credentials = authResults.credential as? ASAuthorizationAppleIDCredential,
                          let token = credentials.identityToken,
                          let identityToken = String(data: token, encoding: .utf8)
                    else { return }
                    
                    let name = credentials.fullName
                    self.firstName = name?.givenName ?? ""
                    self.lastName = name?.familyName ?? ""
                    self.email = credentials.email ?? ""
                    self.id = identityToken
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }.signInWithAppleButtonStyle(.white) // <- here
                .frame(width: 250, height: 45, alignment: .center)
        } else {
            SignInWithAppleButton (.signIn) { request in
                request.requestedScopes = [.fullName, .email]
            } onCompletion: { result in
                switch result {
                case .success(let authResults):
                    guard let credentials = authResults.credential as? ASAuthorizationAppleIDCredential,
                          let token = credentials.identityToken,
                          let identityToken = String(data: token, encoding: .utf8)
                    else { return }
                    
                    let name = credentials.fullName
                    self.firstName = name?.givenName ?? ""
                    self.lastName = name?.familyName ?? ""
                    self.email = credentials.email ?? ""
                    self.id = identityToken
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }.signInWithAppleButtonStyle(.black)
        }
    }
}

#Preview {
    AppleSignInPassword()
}
