//
//  Untitled.swift
//  Kabar
//
//  Created by user on 23/08/26.
//

import SwiftUI

struct ExploreCell: View {
    var imgUrl: String
    var title: String
    var newsDescription: String
    var isSaved: Bool
    var saveAction: (()->Void)?
    
    var body: some View{
        HStack{
            CachedAsyncImage(url: URL(string: imgUrl))
            .frame(minWidth: 70,maxWidth: 70,maxHeight: 70)
            .cornerRadius(8)
            .clipped()
            
            VStack{
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
                    .padding(.top,4)
                    .padding(.bottom,4)
            }
            .padding(.trailing, 10)
            
            Spacer()
            Button {
                if let action = saveAction{
                    action()
                }
            } label: {
                Text(isSaved ? AppMessages.textSaved : AppMessages.textSave)
                    .foregroundColor(isSaved ? Color.white : Color.black)
            }
            .border(isSaved ? Color.blue : Color.white, width: 1)
            .buttonStyle(.bordered)
            .cornerRadius(8)
            .background(isSaved ? Color.blue : Color.white)
            .clipShape(.capsule)

        }
        
    }
}

#Preview {
    ExploreCell(imgUrl: "", title: "", newsDescription: "", isSaved: false)
}
