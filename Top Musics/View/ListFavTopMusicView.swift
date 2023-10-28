//
//  ListFavTopMusicView.swift
//  Top Musics
//
//  Created by Lucas Ferreira on 26/10/23.
//

import SwiftUI

struct ListFavTopMusicView: View {
    @EnvironmentObject private var topMusicViewModel: TopMusicViewModel
    
    @State private var selectedTrack: Music?
    @State private var showDetailTrack = false
    
    var body: some View {
        NavigationStack{
            VStack() {
                VStack() {
                    Text("Top Músicas Favoritas")
                        .font(.title)
                    Rectangle()
                        .frame(height: 2)
                        .padding(.horizontal, 15)
                        .cornerRadius(10)
                }
                .padding(.vertical, 15)
                if topMusicViewModel.isLoading {
                    ProgressView("Carregando músicas...")
                        .padding(.vertical, 200)
                } else {
                    ScrollView {
                        ForEach(topMusicViewModel.favoriteMusic) { track in
                            HStack {
                                HStack {
                                    Text("\(track.posicaoFavorita)")
                                        .font(.title)
                                        .padding(.horizontal, 5)
                                    
                                    if let imageData = track.imagem, let uiImage = UIImage(data: imageData) {
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                            .padding(.horizontal, 5)
                                    }
                                    
                                    VStack(alignment: .leading) {
                                        Text("\(track.nome)")
                                            .font(.headline)
                                        Text("\(track.artista)")
                                            .font(.subheadline)
                                    }
                                }
                                .onTapGesture {
                                    selectedTrack = track
                                    showDetailTrack = true
                                }
                                Spacer()
                                FavoriteButton(isFavorita: track.isFavorita) {
                                    topMusicViewModel.toggleFavorite(for: track)
                                }
                            }
                            .padding(.horizontal, 10)
                            .background(
                                NavigationLink("", destination: DetailTopMusicView(displayedMusic: $selectedTrack).navigationBarBackButtonHidden(true), isActive: $showDetailTrack)
                                    .opacity(0)
                            )
                        }
                    }
                }
            }
            .foregroundColor(.primary)
            .onAppear {
                topMusicViewModel.getFavoriteTracks()
            }
        }
    }
}

#Preview {
    ListFavTopMusicView()
}
