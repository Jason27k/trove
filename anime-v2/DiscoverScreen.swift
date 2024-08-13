//
//  DiscoverScreen.swift
//  anime-v2
//
//  Created by Jason Morales on 8/9/24.
//

import SwiftUI

struct DiscoverScreen: View {
    @State var upcomingAnime = AnimeObservable(url: "https://api.jikan.moe/v4/seasons/upcoming", suffix: "?")
    @State var animeName:String = ""
    
    
    var body: some View {
        ScrollView {
            VStack {
                NavigationLink {
                    Text("Genres")
                } label: {
                    HStack {
                        Text("Search by Genre")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundStyle(.black)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.black)
                        
                    }
                }.padding()
                
                Grid(horizontalSpacing: 17, verticalSpacing: 17) {
                    GridRow {
                        GenreCardView(imageString: "action", genreName: "Action", genreDescripion: "Action description")
                        GenreCardView(imageString: "fantasy", genreName: "Fantasy", genreDescripion: "Fantasy description")
                    }
                    GridRow {
                        GenreCardView(imageString: "sci-fi", genreName: "Sci-Fi", genreDescripion: "Sci-Fi description")
                        GenreCardView(imageString: "romance", genreName: "Romance", genreDescripion: "Romance description")
                    }
                }.padding(.horizontal)
            }
            VStack {
                NavigationLink {
                    AnimeResults(animeObs: upcomingAnime)
                } label: {
                    HStack {
                        Text("Upcoming Anime")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundStyle(.black)
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .foregroundStyle(.blue)
                    .padding([.top, .horizontal])
                }
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(upcomingAnime.animeList) { anime in
                            NavigationLink {
                                AnimeDescription(anime: anime)
                            } label: {
                                AnimeLargeView(imageUrl: anime.images.jpg.image_url, animeName: anime.title_english ?? anime.title, animeDescription: anime.synopsis ?? "")
                                    .padding(.trailing)
                            }
                            //                            .contentMargins(.horizontal, 15, for: .scroll)
                            //                            .containerRelativeFrame(.horizontal, alignment: .center)
                        }
                    }.scrollTargetLayout()
                }
                .scrollTargetBehavior(.viewAligned)
                .padding(.horizontal)
                //                .safeAreaPadding(.horizontal)
            }
        }
    }
}

struct GenreCardView: View {
    var imageString: String
    var genreName: String
    var genreDescripion: String
    
    var body: some View {
        VStack {
            Image(imageString)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                .scaleEffect(CGSize(width: 0.9, height: 0.9))
            Text(genreName)
                .font(.subheadline)
                .fontWeight(.semibold)
            Text(genreDescripion)
                .font(.footnote)
                .fontWeight(.light)
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .padding(.bottom)
        }
        .foregroundStyle(.black)
        .background(.mainGray)
        .clipShape(RoundedRectangle(cornerRadius: 25.0))
    }
}

struct AnimeLargeView: View {
    var imageUrl: String
    var animeName: String
    var animeDescription: String
    
    var body: some View {
        VStack {
            ImageLoader(url: imageUrl, contentMode: .fit)
                .frame(width: 200, height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
            //                .scaleEffect(CGSize(width: 0.9, height: 0.9))
            VStack{
                Text(animeName)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                //                .padding(.top)
                Text(animeDescription)
                    .font(.footnote)
                    .fontWeight(.light)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    .padding(.bottom)
            }
        }
        .frame(width: 200, height: 380, alignment: .top)
        .foregroundStyle(.black)
    }
}

#Preview {
    NavigationStack {
        DiscoverScreen()
    }
}
