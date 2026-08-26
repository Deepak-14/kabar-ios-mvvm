//
//  Untitled.swift
//  Kabar
//
//  Created by user on 23/08/26.
//

import SwiftUI

struct NewsCell: View {
    var imgUrl: String
    var title: String
    var newsDescription: String
    
    var body: some View{
        HStack{
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
            .frame(minWidth: 96,maxWidth: 96,maxHeight: 96)
            .cornerRadius(8)
            .clipped()
            
            VStack(){
                Text(title)
                    .font(Font.system(size: 13))
                    .fontWeight(.regular)
                    .foregroundColor(Color.colorGrayPurple)
                    .lineLimit(1)
                    .padding(.top,8)
                
                Text(newsDescription)
                    .font(Font.system(size: 16))
                    .fontWeight(.regular)
                    .foregroundColor(Color.black)
                    .lineLimit(2)
                   
                    .padding(.bottom,4)
            }
        }
    }
}
