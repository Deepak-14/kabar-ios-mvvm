//
//  HeaderTitleView.swift
//  Kabar
//
//  Created by user on 23/08/26.
//

import SwiftUI

struct HeaderTitleView: View {
   var headername: String
   var seeAll: String
   var isSeeAllActive: Bool
    
    var body: some View{
        HStack{
            Text(headername)
                .font(Font.system(size: 16))
                .fontWeight(.semibold)
                .foregroundColor(Color.black)
            Spacer()
            if isSeeAllActive{
                Text(seeAll)
                    .font(Font.system(size: 14))
                    .fontWeight(.regular)
                    .foregroundColor(Color.colorGrayPurple)
            }
        }
    }
}
