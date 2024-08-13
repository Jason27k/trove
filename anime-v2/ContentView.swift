//
//  ContentView.swift
//  anime-v2
//
//  Created by Jason Morales on 8/4/24.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("id") private var id: String = ""
    @AppStorage("firstName") private var firstName: String = ""
    @AppStorage("lastName") private var lastName: String = ""
    @AppStorage("email") private var email: String = ""
    
    var body: some View {
        VStack {
            if id == "" {
                
                AppleSignInPassword()
            } else {
                ScrollView{
                    Text(id)
                    Text(firstName)
                    Text(lastName)
                    Text(email)
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

