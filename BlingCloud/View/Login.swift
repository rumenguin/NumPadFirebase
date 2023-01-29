//
//  ContentView.swift
//  BlingCloud
//
//  Created by RUMEN GUIN on 28/01/23.
//

import SwiftUI

struct Login: View {
    @StateObject var loginViewModel = LoginViewModel()
    @State var isSmall = UIScreen.main.bounds.height < 750
    var body: some View {
        
        ZStack {
            VStack {
                VStack {
                    Text("Continue with Phone")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding()
                    
                    Image(systemName: "phone.badge.checkmark")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                        .foregroundColor(.mint)
                    
                    Text("You'll receive a 6 digit code\n to verify next.")
                        .font(isSmall ? .none : .title2)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    //MARK: - Mobile Number field
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Enter Your Number")
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                            Text("+ \(loginViewModel.getCountryCode())  \(loginViewModel.phoneNumber)")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                        }
                        
                        Spacer(minLength: 0)
                        
                        NavigationLink(destination: Verification(loginViewModel: loginViewModel), isActive: $loginViewModel.goToVerify){
                            
                            Text("")
                                .hidden()
                                
                        }
                        
                        Button(action: loginViewModel.sendVerificationCode, label: {
                            Text("Continue")
                                .foregroundColor(.black)
                                .padding(.vertical, 18)
                                .padding(.horizontal, 38)
                                .background(Color.yellow)
                                .cornerRadius(20)
                        })
                        
                        .opacity(loginViewModel.phoneNumber == "" ? 0.4 : 1)
                        .disabled(loginViewModel.phoneNumber == "" ? true : false)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: -4)
                }
                .frame(height: UIScreen.main.bounds.height / 1.8)
                .background(Color.white)
                
                //MARK: - Custom Number Pad
                CustomNumberPad(value: $loginViewModel.phoneNumber, isVerify: false)
                
                
            }
            .background(Color.mint.opacity(0.08).ignoresSafeArea(.all, edges: .bottom))
            
            if loginViewModel.error {
                AlertView(message: loginViewModel.errorMessage, close: $loginViewModel.error)
            }
        }
        
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
