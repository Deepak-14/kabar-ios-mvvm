//
//  HomeViewModel.swift
//  Kabar
//
//  Created by user on 22/08/26.
//

import SwiftUI
import SwiftData

@MainActor
@Observable
final class HomeViewModel {
    private let apiService: NetworkManagerProtocol

    var newsData: [Articles] = []
    var isLoading = false
    var errorMessage: String?
    var selectedSource: String = "All"
    var searchText: String = ""
    var newsType: String = ""
    private(set) var hasLoaded = false

    init(apiService: NetworkManagerProtocol) {
        self.apiService = apiService
    }

    func fetchUsersIfNeeded() async {
            guard !hasLoaded else {
                return
            }
            await fetchUsers()
        }

    
    func fetchNews() async {
        isLoading = true
        errorMessage = nil

        defer {
            isLoading = false
        }

        let url = APIConstant.baseUrl + "everything?q=\(newsType)&apiKey=\(APIConstant.apiKey)"
        
        apiService.getData(NewsModel.self, url: url, methodType: .get) { [weak self] result in
            guard let strongSlef = self else{
                return
            }
            switch result{
            case .success(let news):
                strongSlef.newsData = news?.articles ?? []
                strongSlef.hasLoaded = true
            case .failure(let error):
                print("Error fetching news: \(error)")
                strongSlef.errorMessage = error.localizedDescription
            }
        }
        
    }

    func fetchUsers() async {
        await fetchNews()
    }
    
    var filteredNews: [Articles] {

        var result = newsData

        // Source filtering
        if selectedSource != "All" {
            result = result.filter {
                $0.source?.name == selectedSource
            }
        }

        // Search filtering
        let search = searchText.trimmingCharacters(in: .whitespacesAndNewlines)

        if !search.isEmpty {
            result = result.filter { article in

                article.title?.localizedCaseInsensitiveContains(search) == true
                ||
                article.description?.localizedCaseInsensitiveContains(search) == true
                ||
                article.author?.localizedCaseInsensitiveContains(search) == true
            }
        }

        return result
    }
    
    
    func setNewsFilter(_ source: String) {
        selectedSource = source
    }
    
    
    func filterHeaders() -> [NewsCategory] {

        var headers: [NewsCategory] = [
            NewsCategory(id: "all", title: "All", isSelected: true)
        ]

        var addedSources = Set<String>()

        for article in newsData {
            guard let sourceName = article.source?.name else {
                continue
            }

            if addedSources.insert(sourceName).inserted {
                headers.append(
                    NewsCategory(
                        id: sourceName,
                        title: sourceName,
                        isSelected: false
                    )
                )
            }
        }

        return headers
    }
}
