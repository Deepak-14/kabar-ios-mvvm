//
//  ContentView.swift
//  Kabar
//
//  Created by user on 05/08/26.
//

import SwiftUI
import SwiftData

struct AppContainer: View {
    @Environment(AppState.self) private var appState

    var body: some View {
        if appState.isUserLogin {
            NavigationStack {
                MainTabView()
            }
        } else {
            OnBoardingView()
        }
    }
    
        
}

#Preview {
    AppContainer()

}
