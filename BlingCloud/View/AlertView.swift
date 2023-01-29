//
//  AlertView.swift
//  BlingCloud
//
//  Created by RUMEN GUIN on 29/01/23.
//

import SwiftUI

struct AlertView: View {
    var message: String
    @Binding var close: Bool
    var body: some View {
        
        VStack(alignment: .leading, spacing: 15) {
            Text("Message")
                .fontWeight(.bold)
                .foregroundColor(.gray)
            
            Text(message)
                .foregroundColor(.gray)
            
            Button(action: {
                close.toggle()
                
            }) {
                Text("Close")
                    .foregroundColor(.black)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 100)
                    .background(Color.yellow)
                    .cornerRadius(15)
            }
            .frame(alignment: .center)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .padding(.horizontal, 25)
        
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.3).ignoresSafeArea())
        
    }
}

