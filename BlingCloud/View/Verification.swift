//
//  Verification.swift
//  BlingCloud
//
//  Created by RUMEN GUIN on 28/01/23.
//

import SwiftUI

struct Verification: View {
    @ObservedObject var loginViewModel: LoginViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
            VStack {
                VStack {
                    HStack {
                        Button(action: {dismiss()}) {
                            Image(systemName: "arrow.left")
                                .font(.title2)
                                .foregroundColor(.black)
                            
                        }
                        
                        Spacer()
                        
                        Text("Verify Phone")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                        Spacer()
                        
                        if loginViewModel.loading {
                            ProgressView()
                        }
                    }
                    .padding()
                    
                    Text("Verification Code sent to\n\(loginViewModel.phoneNumber)")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.bottom)
                    
                    Spacer(minLength: 0)
                    
                    HStack(spacing: 15) {
                        ForEach(0..<6, id: \.self) {index in
                            //displaying verification code
                            VerificationCodeView(verificationCode: getVerificationCodeAtIndex(index: index))
                        }
                    }
                    .padding()
                    .padding(.horizontal, 20)
                    Spacer(minLength: 0)
                    
                    HStack(spacing: 6) {
                        Text("Didn't receive code?")
                            .foregroundColor(.gray)
                        
                        Button(action: loginViewModel.requestCode) {
                            Text("Request Again")
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                        }
                    }
                    Button(action: {}) {
                        Text("Get via call")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                    }
                    .padding(.top, 6)
                    
                    Button(action: loginViewModel.verifyCode) {
                        Text("Verify and Create Account")
                            .foregroundColor(.black)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 30)
                            .background(Color.yellow)
                            .cornerRadius(15)
                    }
                    .padding()
                }
                .frame(height: UIScreen.main.bounds.height / 1.8)
                .background(Color.white)
                .cornerRadius(20)
                
                CustomNumberPad(value: $loginViewModel.verificationCode, isVerify: true)
            }
            .background(Color.mint.opacity(0.08).ignoresSafeArea(.all, edges: .bottom))
            
            if loginViewModel.error {
                AlertView(message: loginViewModel.errorMessage, close: $loginViewModel.error)
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    
    //MARK: - Getting Verification Code at each index
    
    func getVerificationCodeAtIndex(index: Int) -> String {
        if loginViewModel.verificationCode.count > index {
            let start = loginViewModel.verificationCode.startIndex
            let current = loginViewModel.verificationCode.index(start, offsetBy: index)
            return String(loginViewModel.verificationCode[current])
        }
        return ""
    }
}


struct VerificationCodeView: View {
    var verificationCode: String
    var body: some View {
        VStack(spacing: 10) {
            Text(verificationCode)
                .foregroundColor(.black)
                .fontWeight(.bold)
                .font(.title2)
                .frame(height: 45)
            
            Capsule()
                .fill(Color.gray.opacity(0.5))
                .frame(height: 4)
        }
    }
}
