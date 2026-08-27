//
//  ProfileView.swift
//  Kabar
//
//  Created by user on 11/08/26.
//

import SwiftUI

struct ProfileView: View {
    @Binding var path: NavigationPath
    @State private var profileViewModel = ProfileViewModel()
    @State private var isLogout: Bool = false
    
    @Environment(AppState.self) private var appState
    
    var body: some View {
        VStack{
            Form{
                Text("User Email \(profileViewModel.email)")
                Button{
                    userLogout()
                }label: {
                    Text(AppMessages.textLogout)
                }
            }
            .navigationTitle(AppMessages.textProfile)
            .navigationBarHidden(false)

        }
        .onAppear{
            profileViewModel.fetchUser()
        }
        
    }
    
    func userLogout() {
        Task{
            isLogout = await profileViewModel.userLogout()
            if isLogout{
                appState.logout()
            }
        }
    }
}

//#Preview {
//    @Previewable @State var path = NavigationPath()
//    ProfileView(path: $path)
//}
