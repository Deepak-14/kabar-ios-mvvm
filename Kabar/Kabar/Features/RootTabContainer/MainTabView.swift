//
//  MainTabView.swift
//  Kabar
//
//  Created by user on 11/08/26.
//

import SwiftUI

struct MainTabView: View {

    var body: some View {
        TabView {

            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }

            ExploreView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }

            BookmarkView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
    }
}

#Preview {
    MainTabView()
}
