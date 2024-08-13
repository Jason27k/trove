//
//  AnimeGrid.swift
//  anime-v2
//
//  Created by Jason Morales on 8/5/24.
//

import SwiftUI

struct AnimeGrid: View {
    @State var animeObs: AnimeObservable
    
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible(), spacing: 20), GridItem(.flexible())], content: {
                    ForEach(animeObs.animeList) {
                        anime in
                        NavigationLink {
                            AnimeDescription(anime: anime)
                        } label: {
                            VStack(alignment: .leading) {
                                ImageLoader(url: anime.images.jpg.image_url, contentMode: .fit)
                                VStack {
                                    HStack {
                                        Text(anime.title_english ?? anime.title)
                                            .frame(width: .infinity, alignment: .leading)
                                            .foregroundStyle(Color.primary)
                                            .lineLimit(1)
                                        Spacer()
                                    }
                                    if let genres = anime.genres {
                                        Text(genres.map({$0.name}).joined(separator: ", "))
                                            .foregroundStyle(Color.secondary)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .lineLimit(1)
                                            .font(.subheadline)
                                    }
                                }
                            }
                            .padding(.bottom, 10)
                        }
                    }
                    if !animeObs.isLoading {
                        Divider()
                            .hidden()
                            .onAppear {
                                Task {
                                    await animeObs.fetchNext()
                                }
                            }
                    }
                })
            }
        }
        .padding()
    }
}

struct AnimeList: View {
    @State var animeObs: AnimeObservable
    
    var body: some View {
        List {
            ForEach(animeObs.animeList) { anime in
                NavigationLink {
                    AnimeDescription(anime: anime)
                } label: {
                    HStack {
                        ImageLoader(url: anime.images.jpg.image_url, contentMode: .fit)
                            .frame(width: 70, height: 100)
                        VStack {
                            VStack {
                                HStack {
                                    Text(anime.title_english ?? anime.title)
                                        .frame(width: .infinity, alignment: .leading)
                                        .foregroundStyle(Color.primary)
                                        .lineLimit(2)
                                    Spacer()
                                }
                                if let genres = anime.genres {
                                    Text(genres.map({$0.name}).joined(separator: ", "))
                                        .foregroundStyle(Color.secondary)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .lineLimit(2)
                                        .font(.subheadline)
                                }
                            }
                        }
                    }
                }
            }
            if !animeObs.isLoading {
                ProgressView()
                    .onAppear {
                        Task {
                            await animeObs.fetchNext()
                        }
                    }
            }
        }
    }
}

struct AnimeResults: View {
    
    @State var animeObs: AnimeObservable
    @State var gridView = true
    
    var body: some View {
        VStack {
            if gridView {
                AnimeGrid(animeObs: animeObs)
            } else {
                AnimeList(animeObs: animeObs)
            }
        }.toolbar {
            Button {
                gridView.toggle()
            } label: {
                if gridView {
                   Image(systemName: "list.bullet")
                } else {
                    Image(systemName: "rectangle.grid.2x2.fill")
                }
            }
        }
    }
}

struct AnimeResultsPreviewer: View {
    @State var animeObs = AnimeObservable(url: "https://api.jikan.moe/v4/seasons/now?swf=true&continuing=false&filter=tv", suffix: "&")
    
    var body: some View {
        AnimeResults(animeObs: animeObs)
    }
}



#Preview {
    NavigationStack {
        AnimeResultsPreviewer()
    }
}
