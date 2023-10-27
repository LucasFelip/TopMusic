//
//  ListFavTopMusicView.swift
//  Top Musics
//
//  Created by Lucas Ferreira on 26/10/23.
//

import SwiftUI

struct ListFavTopMusicView: View {
    var body: some View {
        VStack() {
            VStack() {
                Text("Top Músicas Favoritas")
                    .font(.title)
                Rectangle()
                    .frame(height: 2)
                    .padding(.horizontal, 15)
                    .cornerRadius( 10)
            }
            .padding(.vertical, 15)
            ScrollView {
                HStack {
                    
                }
            }
        }
        .foregroundColor(.primary)
    }
}

#Preview {
    ListFavTopMusicView()
}
