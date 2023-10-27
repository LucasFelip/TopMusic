//
//  Icons.swift
//  Top Musics
//
//  Created by Lucas Ferreira on 26/10/23.
//

import SwiftUI

struct Favorites: View {
    var body: some View {
        VStack {
            Image(systemName: "heart.fill")
                .font(.title)
            Text("Favoritas")
              .multilineTextAlignment(.center)
              .frame(height: 17, alignment: .center)
        }
    }
}

struct TopMusics: View {
    var body: some View {
        VStack {
            Image(systemName: "waveform")
                .font(.title)
            Text("Top Músicas")
              .multilineTextAlignment(.center)
              .frame(height: 17, alignment: .center)
        }
    }
}
