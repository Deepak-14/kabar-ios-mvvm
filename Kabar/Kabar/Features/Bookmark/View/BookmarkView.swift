//
//  BookmarkView.swift
//  Kabar
//
//  Created by user on 11/08/26.
//

import SwiftUI
import SwiftData

struct BookmarkView: View {
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
                
                // Fixed search bar
                HStack {
                    Image(systemName: "magnifyingglass")
                    
                    TextField("Search news", text: $dbModel.searchText)
                        .textFieldStyle(.plain)
                    
                    if !dbModel.searchText.isEmpty {
                        Button {
                            dbModel.searchText = ""
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.horizontal)
                .padding(.vertical, 8)
                
                
                // News List
                List{
                    ForEach(dbModel.filteredNews) { news in
                        Button {
                            if path.count > 0{
                                path.removeLast()
                            }
                            path.append(AppRoute.newsDetailSaved(news))
                        } label: {
                            NewsCell(imgUrl: news.imageURL ?? "", title: news.title ?? "", newsDescription: news.articleDescription ?? "")
                        }
                        .buttonStyle(.plain)
                    }
                 .listRowSeparator(.hidden)
                 .listStyle(.plain)
                    
                }
                .navigationBarBackButtonHidden(true)
            }
            .navigationTitle(AppMessages.textBookMark)
            .navigationDestination(for: AppRoute.self) { route in
                switch route {
                    case .newsDetail(let article):
                        NewsDetails(
                            news: article,
                            viewModel: $viewModel
                    )
                case .newsDetailSaved(let article):
                    NewsDetails(
                        news: Articles(savedArticle: article),
                        viewModel: $viewModel)
                }
            }
        .onAppear{
            dbModel.setModelContext(dbContext)
            dbModel.fetchAllNews()
        }
        
    }
}
//#Preview {
//    BookmarkView()
//}
