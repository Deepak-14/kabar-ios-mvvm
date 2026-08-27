//
//  HomeDataBaseViewModel.swift
//  Kabar
//
//  Created by user on 25/08/26.
//

import SwiftUI
import SwiftData

@MainActor
@Observable
final class HomeDataBaseViewModel {
    private var dbContext: ModelContext?

    var savedNews: [NewsArticleSave] = []
    var searchText: String = ""

    init(dbContext: ModelContext? = nil) {
        self.dbContext = dbContext
    }
    func setModelContext(_ context: ModelContext) {
        self.dbContext = context
    }

    func saveNewsData(news: Articles) {
        guard let url = news.url else {
                return
        }
        let article = NewsArticleSave(
            id: news.id,
            articleURL: url,
            title: news.title,
            articleDescription: news.description,
            imageURL: news.urlToImage,
            author: news.author,
            publishedAt: news.publishedAt,
            content: news.content
        )
        dbContext!.insert(article)
        try? dbContext!.save()
    }
    
    func deleteNewsData(_ id: UUID) {
            guard let context = dbContext else {
                return
            }

            let descriptor = FetchDescriptor<NewsArticleSave>(
                predicate: #Predicate { article in
                    article.id == id
                }
            )

            do {
                if let article = try context.fetch(descriptor).first {
                    context.delete(article)
                    try context.save()

                    print("News deleted successfully")
                }
            } catch {
                print("Failed to delete news: \(error)")
            }
        }
    
    func fetchAllNews()  {
        guard let context = dbContext else{
            return
        }
        
        let descriptor = FetchDescriptor<NewsArticleSave>(sortBy: [SortDescriptor(\.publishedAt, order: .reverse)])
        do{
            savedNews = try context.fetch(descriptor)            
        }catch{
            print("Failed to fetch\(error)")
        }
    }
    
    func fetchNews(by id: UUID) -> NewsArticleSave? {
        guard let context = dbContext else {
            return nil
        }

        let descriptor = FetchDescriptor<NewsArticleSave>(
            predicate: #Predicate { article in
                article.id == id
            }
        )

        do {
            return try context.fetch(descriptor).first
        } catch {
            print("Failed to fetch news: \(error)")
            return nil
        }
    }
    
    var filteredNews: [NewsArticleSave] {

        var result = savedNews

        // Search filtering
        let search = searchText.trimmingCharacters(in: .whitespacesAndNewlines)

        if !search.isEmpty {
            result = result.filter { article in

                article.title?.localizedCaseInsensitiveContains(search) == true
                ||
                article.articleDescription?.localizedCaseInsensitiveContains(search) == true
                ||
                article.author?.localizedCaseInsensitiveContains(search) == true
            }
        }

        return result
    }
}
