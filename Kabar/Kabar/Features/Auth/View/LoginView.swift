//
//  LoginView.swift
//  Kabar
//
//  Created by user on 09/08/26.
//

import SwiftUI

struct LoginView: View {
    @State var loginViewModel = LoginViewModel()
    @Binding var path: NavigationPath
    @State var isValid: Bool = false
    @State private var isPasswordVisible = false
    @Environment(AppState.self) private var appState

    var body: some View {
            VStack(alignment: .leading){
                 
                //Set Top Text Design
                LoginTitle()

                Spacer()
                
                //Set Email Group
                Group{
                    Text(AppMessages.textLoginUsername)
                        .modifier(TextFieldTitledModifier())
                    TextField("Email", text: $loginViewModel.email)
                        .keyboardType(.emailAddress)
                        .frame(height: 48)
                        .overlay(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(.colorGrayPurple, lineWidth: 1) // Border color and thickness
                            )
                        .padding([.leading,.trailing],24)
                }
                
                
                VStack (alignment: .leading){
                    //Set Passeord Group
                    Text(AppMessages.textLoginPassword)
                        .modifier(TextFieldTitledModifier())
                    HStack(alignment: .center){
                        if isPasswordVisible {
                            TextField("Password", text: $loginViewModel.password)
                                
                                .keyboardType(.default)
                        } else {
                            SecureField("Password", text: $loginViewModel.password)
                                .keyboardType(.default)
                        }
                        
                        Button {
                            isPasswordVisible.toggle()
                        } label: {
                            Image(systemName: isPasswordVisible
                                  ? "eye.slash"
                                  : "eye")
                            .foregroundStyle(.gray)
                        }
                        .padding(.trailing, 10)
                    }.padding(.zero)
                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                        .overlay(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(.colorGrayPurple, lineWidth: 1) // Border color and thickness
                            )
                        .padding([.leading,.trailing],24)
                        
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
                    isValid = !loginViewModel.validate()
                    if !isValid{
                        loginViewModel.createUser(email: loginViewModel.email, password: loginViewModel.password, completion: { isSuccess in
                            guard isSuccess else {
                                return
                            }
                            appState.setUserLogin(isLogin: true)
                            if path.count > 0{
                                path.removeLast()
                            }
                            path.append(AuthRoute.dashboard)
                            
                        })
                    }
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
            .alert("Alert", isPresented: $isValid, actions: {
                Button("OK",role: .cancel) {
                    isValid = false
                }
            }, message: {
                Text((loginViewModel.emailError ?? "") + (loginViewModel.passwordError ?? ""))
            })

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
            .padding([.leading],24)
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
    @Previewable @State var path = NavigationPath()
    @Previewable @State var isValid = false
    LoginView(loginViewModel: LoginViewModel(), path: $path)
}
