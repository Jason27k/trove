//
//  AnimeDescription.swift
//  anime-v2
//
//  Created by Jason Morales on 8/7/24.
//

import SwiftUI

struct AnimeDescription: View {
    @State var anime: AnimeModel
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ImageLoader(url: anime.images.jpg.image_url, contentMode: .fit)
            }
        }.toolbarTitleDisplayMode(.inline)
    }
}

struct AnimeDescriptionPresenter: View {
    @State var animeObs = AnimeObservable(url: "https://api.jikan.moe/v4/seasons/now", suffix: "?")
    var body: some View {
        ScrollView {
            if let anime = animeObs.animeList.first {
                AnimeDescription(anime: anime)
                    .onAppear {
                        print(animeObs.animeList.count)
                    }
            }
        }
    }
}

#Preview {
    NavigationStack {
        AnimeDescriptionPresenter()
    }
}
