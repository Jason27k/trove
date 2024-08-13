//
//  AnimeViewModel.swift
//  anime-v2
//
//  Created by Jason Morales on 8/5/24.
//

import Foundation

class AnimeDataStore {
    func save(animeList: [AnimeModel], listName: String) {
        if let encodedData = try? JSONEncoder().encode(animeList) {
            UserDefaults.standard.set(encodedData, forKey: listName)
        }
    }
    
    func saveNext(next: Bool, listName: String) {
        let name = listName + "page"
        if let encodedData = try? JSONEncoder().encode(name) {
            UserDefaults.standard.set(encodedData, forKey: listName)
        }
    }

    func load(listName: String) -> [AnimeModel] {
        if let savedData = UserDefaults.standard.data(forKey: listName),
           let decodedData = try? JSONDecoder().decode([AnimeModel].self, from: savedData) {
            return decodedData
        }
        return []
    }
    
    func loadPage(listName: String) -> Bool {
        let name = listName + "page"
        if let savedData = UserDefaults.standard.data(forKey: name),
           let decodedData = try? JSONDecoder().decode(Bool.self, from: savedData) {
            return decodedData
        }
        return false
    }
}

@Observable
class AnimeObservable {
    var animeList: [AnimeModel] = []
    var hasNextPage: Bool = false
    var url: String = ""
    var page: Int = 0
    var isLoading: Bool = true
    var suffix: String = "?"
    @ObservationIgnored var api: AnimeAPI
    @ObservationIgnored private var animeDataStore: AnimeDataStore
    
    init(url: String, suffix: String) {
        self.url = url
        self.suffix = suffix
        self.animeDataStore = AnimeDataStore()
        self.api = AnimeAPI()
        Task {
            await fetchAnime()
            isLoading = false
        }
    }
    
    func fetchAnime() async {
        let loaded = animeDataStore.load(listName: url)
        let loadedNext = animeDataStore.loadPage(listName: url)
        if !loaded.isEmpty {
            animeList = loaded
            hasNextPage = loadedNext
            print("Not Called")
            return
        }
        do {
            let animeResponse:AnimeResponse = try await api.fetch(urlString: url)
            await MainActor.run {
                animeList = animeResponse.data
//                print(animeResponse.data)
//                print(animeList)
                hasNextPage = animeResponse.pagination.has_next_page
                print(hasNextPage)
                page = animeResponse.pagination.current_page
                print("Saved")
                animeDataStore.save(animeList: animeList, listName: url)
                animeDataStore.saveNext(next: hasNextPage, listName: url)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchNext() async -> Bool {
        print(hasNextPage, page+1)
        if !hasNextPage || isLoading {
            return false
        }
        
        do {
            isLoading = true
            print(url+suffix+"page=\(page+1)")
            let animeResponse: AnimeResponse = try await api.fetch(urlString: url+suffix+"page=\(page+1)")
            await MainActor.run {
                print(animeList.count)
                animeList.append(contentsOf: animeResponse.data)
                print(animeList.count)
                hasNextPage = animeResponse.pagination.has_next_page
                page = animeResponse.pagination.current_page
                isLoading = false
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return true
    }
}
