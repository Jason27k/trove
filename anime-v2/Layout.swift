//
//  Layout.swift
//  anime-v2
//
//  Created by Jason Morales on 8/7/24.
//

import SwiftUI

struct Layout: View {
    @State var selected: Int = 1
    @State var animeVM = AnimeObservable(url: "https://api.jikan.moe/v4/seasons/now", suffix: "?")
    
    var body: some View {
        TabView(selection: $selected) {
            HomeScreen().padding(.vertical)
                .tabItem {
                    Image(systemName: "house.fill")
                        .foregroundStyle(.black)
                        .background(.black)
                }.tag(1)
            NavigationStack {
                DiscoverScreen()
            }.tabItem {
                Image(systemName: "magnifyingglass")
            }.tag(2)
            Text("Liked").tabItem {
                Image(systemName: "heart.fill")
            }.tag(3)
            Text("Calendar").tabItem {
                Image(systemName: "calendar")
            }.tag(4)
            Text("Login").tabItem {
                Image(systemName: "person.circle.fill")
            }.tag(4)
        }
        .tint(.primOrange)
        .onAppear(perform: {
            UITabBar.appearance().unselectedItemTintColor = .black
            UITabBar.appearance().backgroundColor = .mainGray
        })
//        .toolbar {
//            HStack(spacing: 137){
//                HStack{
//                    Text(Image("dragonWhite"))
//                        .foregroundStyle(.white)
//                    Text("AnimeTrove")
//                        .foregroundStyle(.white)
//                        .font(.title2)
//                }.padding()
//                NavigationLink {
//                    Text("Login")
//                } label: {
//                    Image(systemName: "person.circle.fill")
//                        .foregroundStyle(.white)
//                        .font(.title)
//                }
//            }
//        }
//        .toolbarBackground(.primOrange, for: .navigationBar)
//        .toolbarBackground(.visible, for: .navigationBar)
    }
}

#Preview {
        Layout()

}
