//
//  Buttons.swift
//  Top Musics
//
//  Created by Lucas Ferreira on 27/10/23.
//

import SwiftUI

struct ButtonRetangular: View {
    let buttonText: String
    let action: () -> Void
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 330, height: 50)
                .background(.green)
                .cornerRadius(15)

            HStack {
                Text(buttonText)
                    .font(.headline)
            }
            .padding(.horizontal, 40)
        }
        .padding(.top, 10)
        .onTapGesture {
            action()
        }
    }
}

struct FavoriteButton: View {
    let isFavorita: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: isFavorita ? "heart.fill" : "heart")
                .foregroundColor(isFavorita ? .green : .gray)
                .font(.system(size: 32))
        }
    }
}
