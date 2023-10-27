//
//  DetailTopMusicView.swift
//  Top Musics
//
//  Created by Lucas Ferreira on 26/10/23.
//

import SwiftUI

struct DetailTopMusicView: View {
    @ObservedObject private var topMusicViewModel = TopMusicViewModel()
    
    @State private var isShowingButtonBack = true
    @State private var isToRetorn = false
    
    let music: Music
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack(alignment: .leading) {
                    if let imageData = music.imagem, let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .frame(width: 330, height: 330)
                    }
                    HStack {
                        VStack(alignment: .leading) {
                            Text("\(music.nome)")
                                .font(.headline)
                            Text("\(music.artista)")
                                .font(.subheadline)
                        }
                        Spacer()
                        VStack(alignment: .trailing) {
                            FavoriteButton(isFavorita: music.isFavorita) {
                                topMusicViewModel.toggleFavorite(for: music)
                            }
                        }
                    }
                    .padding(.bottom, 10)
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Popularidade")
                                .font(.headline)
                            Text("\(music.popularidade)")
                                .font(.subheadline)
                        }
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text("Duração")
                                .font(.headline)
                            Text("\(music.duracaoEmMinutos)")
                                .font(.subheadline)
                        }
                    }
                }
                .foregroundColor(.primary)
                .padding(.vertical, 15)
                .frame(width: 330)
                
                ButtonRetangular(buttonText: "Abrir no Spotify", action: {
                    if let spotifyURL = music.spotifyURL {
                        if let url = URL(string: spotifyURL.absoluteString) {
                            UIApplication.shared.open(url)
                        }
                    }
                })
            }
            .navigationBarItems(leading: Group {
                if isShowingButtonBack {
                    Button(action: {
                        isToRetorn = true
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.title)
                            .foregroundColor(.primary)
                    }
                }
            })
            .navigationDestination(isPresented: $isToRetorn, destination: {
                InitView()
                    .navigationBarBackButtonHidden(true)
            })
        }
    }
}
