//
//  Anime.swift
//  anime-v2
//
//  Created by Jason Morales on 8/5/24.
//

import Foundation

struct AnimeResponse: Codable {
    let pagination: Pagination
    let data: [AnimeModel]
}

struct Pagination: Codable{
    let last_visible_page: Int
    let has_next_page: Bool
    let current_page: Int
}

struct AnimeModel: Codable, Identifiable {
    var id: Int {
        mal_id
    }
    let mal_id: Int
    let url: String
    let images: JPG
    let trailer: Trailer?
    let title: String
    let title_english: String?
    let title_japanese: String?
    let type: String?
    let source: String?
    let episodes: Int?
    let status: String?
    let airing: Bool?
    let rating: String?
    let score: Float?
    let scored_by: Int?
    let rank: Int?
    let popularity: Int?
    let members: Int?
    let favorites: Int?
    let synopsis: String?
    let season: String?
    let year: Int?
    let broadcast: Broadcast?
    let producers: [Producer]?
    let licensors: [Licensor]?
    let studios: [Studio]?
    let genres: [Genre]?
}

struct JPG: Codable {
    let jpg: ImageUrl
}

struct ImageUrl: Codable {
    let image_url: String
}

struct Trailer: Codable {
    let embed_url: String?
}

struct Broadcast: Codable {
    let string: String?
}

struct Producer: Codable {
    let type: String?
    let name: String?
}

struct Licensor: Codable {
    let type: String?
    let name: String?
}

struct Studio: Codable {
    let type: String?
    let name: String?
}

struct Genre: Codable, Identifiable {
    var id: Int {
        mal_id
    }
    let mal_id: Int
    let type: String
    let name: String
}

