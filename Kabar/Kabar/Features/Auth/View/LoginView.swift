//
//  LoginView.swift
//  Kabar
//
//  Created by user on 09/08/26.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        VStack(alignment: .leading){
             
            //Set Top Text Design
            LoginTitle()

            Spacer()
            
            //Set Email Group
            Group{
                Text(AppMessages.textLoginUsername)
                    .modifier(TextFieldTitledModifier())
                TextField("Email", text: .constant(""))
                    .modifier(TextFieldModifier())
                    .padding(.bottom,20)
            }
            
            //Set Passeord Group
            Group{
                Text(AppMessages.textLoginPassword)
                    .modifier(TextFieldTitledModifier())
                TextField("Password", text: .constant(""))
                    .modifier(TextFieldModifier())
            }
            
            //Set Forgot Paaword Section
            HStack{
                Spacer()
                Button {
                    
                } label: {
                    Text(AppMessages.textLoginForgotPassword)
                        .foregroundColor(.colorBlue)
                }

                
            }
            .padding(.trailing,24)
            .padding(.top,10)
            
           
            Spacer()
            //Set Botton Login Button
           
            Button {
                MainTabView()
            } label: {
                Text("Login")
                    .foregroundColor(.colorWhite)
                    .frame(minWidth: 300,maxWidth: .infinity,maxHeight: 48)
            }
            .background(.colorBlue)
            .clipShape(
                RoundedRectangle(cornerRadius: 6)
            )
            .padding(.leading,24)
            .padding(.trailing,24)
            Spacer()
        }
    }
}


struct TextFieldModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .frame(height: 48)
            .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(.colorGrayPurple, lineWidth: 1) // Border color and thickness
                )
            .padding([.leading,.trailing],24)
    }
}

struct TextFieldTitledModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .frame(alignment: .leading)
            .padding([.leading,.trailing],24)
            .foregroundColor(.colorGrayPurple)
    }
}

struct LoginTitle: View {
    var body: some View {
            Text(AppMessages.textLoginHello)
                .font(Font.system(size: 48))
                .fontWeight(.bold)
                .foregroundColor(.colorBlackLight)
                .padding(EdgeInsets(top: 0, leading: 24, bottom: 5, trailing: 0))
            
            Text(AppMessages.textLoginAgain)
                .font(Font.system(size: 48))
                .fontWeight(.bold)
                .foregroundColor(.colorBlue)
                .padding(EdgeInsets(top: 0, leading: 24, bottom: 10, trailing: 0))
            
            Text(AppMessages.textLoginWelcomBack)
                .font(Font.system(size: 20))
                .fontWeight(.regular)
                .foregroundColor(.colorGrayPurple)
                .padding(EdgeInsets(top: 0, leading: 24, bottom: 10, trailing: 0))
                .lineLimit(2)
                .frame(width: 220)
        
    }
}
#Preview {
    LoginView()
}
