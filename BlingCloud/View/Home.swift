//
//  Home.swift
//  BlingCloud
//
//  Created by RUMEN GUIN on 29/01/23.
//

import SwiftUI
import Firebase
struct Home: View {
    @AppStorage("log_Status") var status = false
    var body: some View {
        VStack(spacing: 15) {
            Text("Logged in Successfully")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(.black)
            
            Button {
                //log out
                try? Auth.auth().signOut()
                withAnimation {
                    status = false
                }
            } label: {
                Text("LogOut")
                    .fontWeight(.heavy)
            }

        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
