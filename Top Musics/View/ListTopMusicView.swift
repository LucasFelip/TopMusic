//
//  ListTopMusicView.swift
//  Top Musics
//
//  Created by Lucas Ferreira on 26/10/23.
//

import SwiftUI

struct ListTopMusicView: View {
    @EnvironmentObject private var topMusicViewModel: TopMusicViewModel
    
    @State private var selectedTrack: Music?
    @State private var showDetailTrack = false
    
    var body: some View {
        VStack() {
            VStack() {
                Text("Top Músicas")
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
                List(topMusicViewModel.topMusic) { track in
                    HStack {
                        HStack {
                            Text("\(track.posicao)")
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
                    .navigationDestination(isPresented: $showDetailTrack, destination: {
                        DetailTopMusicView(displayedMusic: $selectedTrack)
                            .navigationBarBackButtonHidden(true)
                    })
                }
                .listStyle(PlainListStyle())
            }
        }
        .foregroundColor(.primary)
        .onAppear {
            topMusicViewModel.getTopTracks()
        }
    }
}


#Preview {
    ListTopMusicView()
}
