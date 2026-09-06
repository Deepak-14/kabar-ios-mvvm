//
//  HomeView.swift
//  Kabar
//
//  Created by user on 11/08/26.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(HomeViewModel.self) private var viewModel
    @Environment(\.modelContext) private var dbContext

    @State private var dbModel = HomeDataBaseViewModel()
    @Binding var path: NavigationPath

    init(path: Binding<NavigationPath>) {
        _path = path
    }
    
    var body: some View {
        @Bindable var viewModel = viewModel
        
            VStack{
                //Custom Search Bar
                CustomSearchBar(searchText: $viewModel.searchText)
                
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
