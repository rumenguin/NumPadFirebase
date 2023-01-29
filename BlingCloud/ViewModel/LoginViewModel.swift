//
//  LoginViewModel.swift
//  BlingCloud
//
//  Created by RUMEN GUIN on 28/01/23.
//
import SwiftUI
import Foundation
import Firebase

class LoginViewModel: ObservableObject {
    @Published var phoneNumber: String = ""
    @Published var verificationCode: String = ""
    
    //MARK: - Data Model For Error View
    @Published var errorMessage = ""
    @Published var error = false
    
    //MARK: - Storing CODE for verification
    @Published var CODE = ""
    
    @Published var goToVerify = false
    
    //MARK: - User logged Status
    @AppStorage("log_Status") var status = false
    
    //MARK: - Loading View
    @Published var loading = false
    
    //MARK: - Getting Country Phone Code
    
    func getCountryCode() -> String {
        
        let regionCode = Locale.current.regionCode ?? ""
        
        return countries[regionCode] ?? ""
    }
    
    //MARK: - Sending Verification Code to User
    
    func sendVerificationCode() {
        
        //Enabling testing verification code
        //disable when you need to test with real device
        Auth.auth().settings?.isAppVerificationDisabledForTesting = true
        
        let number = "+\(getCountryCode())\(phoneNumber)"
        PhoneAuthProvider.provider().verifyPhoneNumber(number, uiDelegate: nil) { (CODE, error) in
            
            if let error = error {
                self.errorMessage = error.localizedDescription
                withAnimation {
                    self.error.toggle()
                }
                return
            }
            guard let CODE = CODE else {return}
            self.CODE = CODE
            self.goToVerify = true
            
        }
    }
    
    //MARK: - Verifying OTP
    func verifyCode() {
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: self.CODE, verificationCode: verificationCode)
        
        loading = true
        
        Auth.auth().signIn(with: credential) {result, error in
            self.loading = false
            if let error = error {
                self.errorMessage = error.localizedDescription
                withAnimation {
                    self.error.toggle()
                }
                return
            }
            
            //else user logged in successfully
            withAnimation {
                self.status = true
            }
        }
    }
    
    func requestCode() {
        sendVerificationCode()
        withAnimation {
            self.errorMessage = "Code Sent Successfully!!"
            self.error.toggle()
        }
    }
}
