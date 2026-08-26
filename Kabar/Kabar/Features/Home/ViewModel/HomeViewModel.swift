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

    init(apiService: NetworkManagerProtocol) {
        self.apiService = apiService
    }

    func fetchNews() async {
        isLoading = true
        errorMessage = nil

        defer {
            isLoading = false
        }

        let url = APIConstant.baseUrl + "everything" + "?q=" + "bitcoin" + "&apiKey=" + APIConstant.apiKey
        
        apiService.getData(NewsModel.self, url: url, methodType: .get) { result in
            
            switch result{
            case .success(let news):
                self.newsData = news?.articles ?? []
            case .failure(let error):
                print("Error fetching news: \(error)")
                self.errorMessage = error.localizedDescription
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
