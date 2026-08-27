//
//  NewsDetails.swift
//  Kabar
//
//  Created by user on 23/08/26.
//

import SwiftUI
import SwiftData

struct NewsDetails: View {
    var news: Articles?
    @Binding var viewModel: HomeViewModel

    @State private var dbModel = HomeDataBaseViewModel()
    @Environment(\.modelContext) private var dbContext

    @State private var isNewsSaved: Bool = false
    
    var body: some View{
        ScrollView(.vertical){
            VStack{
                FollowingCell(imgUrl: news?.urlToImage ?? "", title: news?.title ?? "", newsDescription: news?.description ?? "", isFollowing: false, width: 50)
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                
                TrandingNewsCell(imgUrl: news?.urlToImage ?? "", title: news?.title ?? "", newsDescription: news?.description ?? "", lineLimitDetail: false, lineLimitTitle: false)
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
            }
        }
        .safeAreaInset(edge: .bottom) {
            HStack{
                Button {
                    
                } label: {
                    HStack{
                        Image("icon_like")
                        Text("23k")
                    }
                   
                }
                .padding()
                
                Button {
                    
                } label: {
                    HStack{
                        Image("icon_comment")
                        Text("23k")
                    }
                    
                }
                .padding()
                
                Spacer()
                
                Button {
                    if isNewsSaved {
                        //Delete Data to DB
                        dbModel.deleteNewsData(news?.id ?? UUID())

                    }else{
                        //Save Data to DB
                        dbModel.saveNewsData(news: news!)
                    }
                    isNewsSaved = (dbModel.fetchNews(by: news?.id ?? UUID()) != nil)

                } label: {
                    Image(isNewsSaved ? "icon_bookmark_select" : "icon_bookmark_unselect")
                }
                .padding()

            }
            .background(.background)
        }
        .toolbar(.hidden, for: .tabBar)
        .onAppear {
            dbModel.setModelContext(dbContext)
            isNewsSaved = (dbModel.fetchNews(by: news?.id ?? UUID()) != nil)
        }
    }
}

