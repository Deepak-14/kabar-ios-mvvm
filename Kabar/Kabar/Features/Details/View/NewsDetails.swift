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
                    //Save Data to DB
                    dbModel.saveNewsData(news: news!)
                } label: {
                    Image("icon_bookmark_select")
                }
                .padding()

            }
            .background(.background)
        }
        .toolbar(.hidden, for: .tabBar)
        .onAppear {
            dbModel.setModelContext(dbContext)
        }
    }
}

