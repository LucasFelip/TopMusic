//
//  DetailTopMusicView.swift
//  Top Musics
//
//  Created by Lucas Ferreira on 26/10/23.
//

import SwiftUI

struct DetailTopMusicView: View {
    @EnvironmentObject private var topMusicViewModel: TopMusicViewModel
    
    @State private var isShowingButtonBack = true
    @State private var isToReturn = false
    
    @Binding var displayedMusic: Music?
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack(alignment: .leading) {
                    if let imageData = displayedMusic?.imagem, let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .frame(width: 330, height: 330)
                            .padding(.bottom, 5)
                    }
                    HStack {
                        VStack(alignment: .leading) {
                            if let nome = displayedMusic?.nome {
                                Text("\(nome)")
                                    .font(.headline)
                            }
                            if let artista = displayedMusic?.artista {
                                Text("\(artista)")
                                    .font(.subheadline)
                            }
                        }
                        Spacer()
                        VStack(alignment: .trailing) {
                            FavoriteButton(isFavorita: displayedMusic?.isFavorita ?? false) {
                                if let displayedMusic = displayedMusic {
                                    topMusicViewModel.toggleFavorite(for: displayedMusic)
                                }
                            }
                        }
                    }
                    .padding(.bottom, 25)
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Popularidade")
                                .font(.headline)
                            if let popularidade = displayedMusic?.popularidade {
                                Text("\(popularidade)")
                                    .font(.subheadline)
                            }
                        }
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text("Duração")
                                .font(.headline)
                            if let duracaoEmMinutos = displayedMusic?.duracaoEmMinutos {
                                Text("\(duracaoEmMinutos)")
                                    .font(.subheadline)
                            }
                            
                        }
                    }
                }
                .foregroundColor(.primary)
                .padding(.vertical, 15)
                .frame(width: 330)
                
                ButtonRetangular(buttonText: "Abrir no Spotify", action: {
                    if let spotifyURL = displayedMusic?.spotifyURL {
                        if let url = URL(string: spotifyURL.absoluteString) {
                            UIApplication.shared.open(url)
                        }
                    }
                })
            }
            .navigationBarItems(leading: Group {
                if isShowingButtonBack {
                    Button(action: {
                        isToReturn = true
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.title)
                            .foregroundColor(.primary)
                    }
                }
            })
            .navigationDestination(isPresented: $isToReturn, destination: {
                InitView()
                    .navigationBarBackButtonHidden(true)
            })
        }
    }
}
