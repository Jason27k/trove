//
//  HomeScreen.swift
//  anime-v2
//
//  Created by Jason Morales on 8/8/24.
//

import SwiftUI

struct HomeScreen: View {
    @State var popAnimeObs = AnimeObservable(url: "https://api.jikan.moe/v4/anime?order_by=popularity&status=airing&sfw=true&start_date=2024-03-01", suffix: "&")
    @State var popAllTimeObs = AnimeObservable(url: "https://api.jikan.moe/v4/top/anime", suffix: "?")
    private var genres = ["Action", "Adventure", "Fantasy", "Drama", "Comedy", "Romance"]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                NavigationLink {
                    AnimeResults(animeObs: popAnimeObs)
                } label: {
                    HStack {
                        Text("Featured Anime")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundStyle(.black)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.black)
                    }
                    .padding(.horizontal)
                }
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(popAnimeObs.animeList) {
                            anime in
                            NavigationLink {
                                AnimeDescription(anime: anime)
                            } label: {
                                ImageLoader(url: anime.images.jpg.image_url, contentMode: .fill).frame(width: 120, height: 210)
                                    .clipShape(RoundedRectangle(cornerRadius: 15.0))
                                    .padding(.trailing, 5)
                            }
                        }
                    }
                }.padding(.leading)
                NavigationLink {
                    AnimeResults(animeObs: popAllTimeObs)
                } label: {
                    HStack {
                        Text("All Time Popular")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundStyle(.black)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundStyle(.black)
                    }.padding([.top, .horizontal])
                }
                VStack {
                    ForEach(popAllTimeObs.animeList.prefix(3 )) {
                        anime in
                        NavigationLink {
                            AnimeDescription(anime: anime)
                        } label: {
                            HStack {
                                ImageLoader(url: anime.images.jpg.image_url, contentMode: .fit)
                                    .clipShape(Capsule())
                                    .frame(width: 90, height: 100)
                                    .padding(.vertical, 8)
                                VStack(alignment: .leading) {
                                    Text(anime.title_english ?? anime.title)
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .lineLimit(1)
                                    if let episodes = anime.episodes {
                                        Text("Latest Episode: \(episodes)")
                                            .font(.footnote)
                                    }
                                    if let score = anime.score {
                                        Text("Rating: \(String(format: "%.1f", score))/10")
                                            .font(.footnote)
                                    }
                                    Spacer()
                                }.padding(.vertical, 20)
                                Spacer()
                            }
                            .foregroundStyle(.black)
                            .frame(width: .infinity)
                            .background(.secondaryOrange)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                            .padding(.horizontal)
                        }
                    }
                }
                VStack {
                    HStack {
                        Text("Explore By Genre")
                            .font(.title2)
                            .fontWeight(.semibold)
                        Spacer()
                    }.padding(.horizontal)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.top)
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 110))], content: {
                        ForEach(genres, id: \.self) {
                            genre in
                            NavigationLink(genre) {
                                Text(genre)
                                    .navigationBarBackButtonHidden()
                            }
                            .foregroundStyle(.white)
                            .padding()
                            .background(
                                Capsule()
                                    .fill(.primOrange)
                                    .frame(width: 120)
                            )
                        }
                    })
                    .padding(.horizontal)
                }
            }
        }
    }
}


#Preview {
    NavigationStack {
        HomeScreen()
    }
}
