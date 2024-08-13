//
//  LoginView.swift
//  anime-v2
//
//  Created by Jason Morales on 8/7/24.
//

import SwiftUI

struct LoginView: View {
    @State var email: String = ""
    @State var password: String = ""
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .scaleEffect(CGSize(width: 1.7, height: 1.7))
            VStack {
                HStack {
                    Spacer()
                    Text(Image("dragon"))
                        .font(.title)
                        .scaleEffect(CGSize(width: 2.0, height: 2.0))
                        .padding()
                    Text("AnimeTrove")
                        .foregroundStyle(.primOrange)
                        .font(.largeTitle)
                        .fontWeight(.light)
                    Spacer()
                }
                Text("Sign In")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.bottom)
                Text("Sign in to your account to continue")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .fontWeight(.semibold)
                    .padding(.bottom)
                TextField("Email", text: $email)
                    .font(.title2)
                    .padding()
                    .background(Capsule().fill(.mainGray))
                    .padding()
                    .textInputAutocapitalization(.never)
                SecureField("Password", text: $password)
                    .font(.title2)
                    .padding()
                    .background(Capsule().fill(.mainGray))
                    .padding(.horizontal)
                    .textInputAutocapitalization(.never)
                NavigationLink("Continue with Email") {
                    Layout()
                        .navigationBarBackButtonHidden(true)
                }
                    .foregroundStyle(.white)
                    .fontWeight(.semibold)
                    .padding([.top, .bottom], 20)
                    .frame(maxWidth: .infinity)
                    .background(
                        Capsule()
                            .fill(.primOrange)
                    )
                    .padding()
                HStack{
                    VStack {
                        Divider()
                            .background(.black)
                            .padding(.horizontal)
                            .frame(maxWidth: 125, minHeight: 10)
                    }
                    Text("or").foregroundStyle(.black)
                    VStack {
                        Divider()
                            .background(.black)
                            .padding(.horizontal)
                            .frame(maxWidth: 125)
                    }
                }
                Button{
                    //google code
                } label: {
                    HStack {
                        Text(Image("google"))
                            .padding(.horizontal, 5)
                        Text("Continue with Google")
                    }
                }
                    .foregroundStyle(.white)
                    .fontWeight(.semibold)
                    .padding([.top, .bottom], 20)
                    .frame(maxWidth: .infinity)
                    .background(
                        Capsule()
                            .fill(.primOrange)
                    )
                    .padding()
                AppleSignInPassword()
                    .frame(width: .infinity, height: 65, alignment: .center)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                    .padding()
//                Button{
//                    //apple code
//                } label: {
//                    HStack {
//                        Text(Image("apple"))
//                            .padding(.horizontal, 5)
//                        Text("Continue with Apple")
//                    }
//                }
//                    .foregroundStyle(.white)
//                    .fontWeight(.semibold)
//                    .padding([.top, .bottom], 20)
//                    .frame(maxWidth: .infinity)
//                    .background(
//                        Capsule()
//                            .fill(.black)
//                    )
//                    .padding(.horizontal)
                Spacer()
                
            }
            .padding([.top, .bottom])
        }
    }
}


#Preview {
    LoginView()
}
