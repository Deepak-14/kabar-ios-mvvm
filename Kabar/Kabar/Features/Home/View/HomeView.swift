//
//  HomeView.swift
//  Kabar
//
//  Created by user on 11/08/26.
//

import SwiftUI
import SwiftData

struct HomeView: View {
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
                // Fixed Top App Icon
                HStack{
                    Image("icon_app_logo")
                    Spacer()
                    Button {
                        
                    } label: {
                        Image("icon_notification")
                    }
                }
                .padding(.horizontal,24)
                
                // Fixed search bar
                HStack {
                    Image(systemName: "magnifyingglass")
                    
                    TextField("Search news", text: $viewModel.searchText)
                        .textFieldStyle(.plain)
                    
                    if !viewModel.searchText.isEmpty {
                        Button {
                            viewModel.searchText = ""
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
                    Section {
                        ForEach(viewModel.newsData.prefix(1)) { news in
                           
                            Button {
                                if path.count > 0{
                                    path.removeLast()
                                }
                                path.append(AppRoute.newsDetail(news))
                            } label: {
                                TrandingNewsCell(imgUrl: news.urlToImage ?? "", title: news.title ?? "", newsDescription: news.description ?? "",lineLimitDetail: true, lineLimitTitle: true)

                            }
                           
                            .buttonStyle(.plain)
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                        }
                    }header: {
                        HeaderTitleView(headername: AppMessages.textTranding, seeAll: AppMessages.textSeeAll, isSeeAllActive: true)
                        
                    }
                    .listStyle(.plain)
                    
                    Section{
                        VStack{
                            ScrollView(.horizontal, showsIndicators: false){
                                HStack(spacing: 12) {
                                    ForEach(viewModel.filterHeaders()) { news in
                                        let name = news.title
                                        Button {
                                            viewModel.setNewsFilter(name)
                                        } label: {
                                            Text(name)
                                                .foregroundStyle(viewModel.selectedSource == name ? Color.white : .primary)
                                            
                                        }.padding(.horizontal, 16)
                                            .padding(.vertical, 10)
                                            .background(viewModel.selectedSource == name ?  Color.blue : Color.gray.opacity(0.15))
                                            .clipShape(Capsule())
                                        
                                        
                                    }
                                }
                            }
                            .padding(.bottom,10)
                            
                            ForEach(viewModel.filteredNews) { news in
                                
                                Button {
                                    if path.count > 0{
                                        path.removeLast()
                                    }
                                    path.append(AppRoute.newsDetail(news))
                                } label: {
                                    NewsCell(
                                        imgUrl: news.urlToImage ?? "",
                                        title: news.title ?? "",
                                        newsDescription: news.description ?? ""
                                    )
                                }
                                .padding(.bottom, 10)
                                .buttonStyle(.plain)
                                .listRowSeparator(.hidden)
                                .listRowBackground(Color.clear)
                            }
                        }
                        
                    } header: {
                        HeaderTitleView(headername: AppMessages.textTranding, seeAll: AppMessages.textSeeAll, isSeeAllActive: true)
                        
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
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .task {
            dbModel.setModelContext(dbContext)
            viewModel.newsType = "bitcoin"
            await viewModel.fetchUsersIfNeeded()
        }
    }
}
