//
//  Welcome.swift
//  anime-v2
//
//  Created by Jason Morales on 8/7/24.
//

import SwiftUI

struct Welcome: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("welcome")
                    .resizable()
                    .interpolation(.high)
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)

                VStack {
                    Text("AnimeTrove")
                        .font(.system(size: 50, weight: .bold))
                        .foregroundStyle(.white)
                    Spacer()
                    Text("Discover the latest in anime. Your journey starts here.")
                        .font(.title2)
                        .foregroundStyle(.white)
                        .frame(width: 300, alignment: .center)
                        .multilineTextAlignment(.center)
                    Spacer()
                    NavigationLink("Get Started") {
                        LoginView()
                    }
                        .padding()
                        .padding(.horizontal)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .background(Capsule().fill(.primOrange))
                }
                .frame(width: geometry.size.width, height: geometry.size.height/3)
            }
        }
    }
}

#Preview {
    NavigationStack {
        Welcome()
    }
}
