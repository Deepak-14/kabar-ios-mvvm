//
//  ExploreView.swift
//  Kabar
//
//  Created by user on 11/08/26.
//

import SwiftUI
import SwiftData

struct ExploreView: View {
    @State private var viewModel: HomeViewModel
    @State private var dbModel = HomeDataBaseViewModel()
    
    @Binding var path: NavigationPath
    @Environment(\.modelContext) private var dbContext

    init(apiService: NetworkManagerProtocol = NetworkManager(),path: Binding<NavigationPath>) {
        viewModel = HomeViewModel(apiService: apiService)
        _path = path
    }
    
    var body: some View {
            VStack{
                
                // News List
                List{
                    Section {
                        ForEach(viewModel.newsData.prefix(3)) { news in
                             
                            Button {
                                if path.count > 0{
                                    path.removeLast()
                                }
                                path.append(AppRoute.newsDetail(news))
                            } label: {
                                ExploreCell(imgUrl: news.urlToImage ?? "", title: news.title ?? "", newsDescription: news.description ?? "", isSaved: false) {
                                    dbModel.saveNewsData(news: news)
                                }
                            }
                        }
                    }header: {
                        HeaderTitleView(headername: AppMessages.textTopic, seeAll: AppMessages.textSeeAll, isSeeAllActive: true)
                        
                    }
                    .listRowSeparator(.hidden)
                    .listStyle(.plain)
                    
                    Section{
                        ForEach(viewModel.filteredNews) { news in
                            Button {
                                if path.count > 0{
                                    path.removeLast()
                                }
                                path.append(AppRoute.newsDetail(news))
                            } label: {
                                TrandingNewsCell(imgUrl: news.urlToImage ?? "", title: news.title ?? "", newsDescription: news.description ?? "",lineLimitDetail: true, lineLimitTitle: true)
                            }
                        }
                    } header: {
                        HeaderTitleView(headername: AppMessages.textPopularTopic, seeAll: AppMessages.textSeeAll, isSeeAllActive: false)
                        
                    }
                    .listRowSeparator(.hidden)
                    .listStyle(.plain)
                }
                .navigationDestination(for: AppRoute.self) { route in
                    switch route {
                        case .newsDetail(let article):
                            NewsDetails(
                                news: article,
                                viewModel: $viewModel
                        )
                    case .newsDetailSaved(let articles):
                        NewsDetails(
                            news: Articles(savedArticle: articles),
                            viewModel: $viewModel)
                    }
                }
            }
            .navigationTitle(AppMessages.textExplore)
            .navigationBarTitleDisplayMode(.large)
            .task{
                dbModel.setModelContext(dbContext)
                viewModel.newsType = "bitcoin"
                await viewModel.fetchUsersIfNeeded()
            }
        
    }
}

//#Preview {
//    ExploreView()
//}
