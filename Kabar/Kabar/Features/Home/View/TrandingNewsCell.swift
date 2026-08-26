//
//  NewsCell.swift
//  Kabar
//
//  Created by user on 23/08/26.
//

import SwiftUI

struct TrandingNewsCell: View {
    var imgUrl: String
    var title: String
    var newsDescription: String
    var lineLimitDetail: Bool = false
    var lineLimitTitle: Bool = false

    var body: some View{
        VStack{
            AsyncImage(url: URL(string: imgUrl)) { phase in

                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                        case .failure:
                            Image("icon_news_fallback")
                                .resizable()
                                .scaledToFill()
                        @unknown default:
                            EmptyView()
                        }
                    }
            .frame(minWidth: 100,maxWidth: .infinity,maxHeight: 180)
            .cornerRadius(8)
            .clipped()
            
            Text(title)
                .font(Font.system(size: 13))
                .fontWeight(.regular)
                .foregroundColor(Color.colorGrayPurple)
                .lineLimit(lineLimitTitle ? 1 : nil)
                .padding(.top,8)
            
            Text(newsDescription)
                .font(Font.system(size: 16))
                .fontWeight(.regular)
                .foregroundColor(Color.black)
                .lineLimit(lineLimitDetail ? 2 : nil)
                .padding(.top,4)
                .padding(.bottom,4)
            
        }
    }
}
