//
//  TopMusicViewModel.swift
//  Top Musics
//
//  Created by Lucas Ferreira on 26/10/23.
//

import SwiftUI

class TopMusicViewModel: ObservableObject {
    @Published var topMusic: [Music] = []
    @Published var favoriteMusic: [Music] = []
    @Published var displayedMusic: Music?
    @Published var isLoading: Bool = false

    private let persistence = PersistenceMusic.shared
    
    init() {
        favoriteMusic = persistence.loadMusic()
    }

    func saveFavoriteMusic(_ music: Music) {
        if music.isFavorita {
            if !favoriteMusic.contains(where: { $0.id == music.id }) {
                favoriteMusic.append(music)
            }
        } else {
            favoriteMusic.removeAll { $0.id == music.id }
        }
        persistence.saveMusic(favoriteMusic)
    }

    func toggleFavorite(for music: Music) {
        if let index = topMusic.firstIndex(where: { $0.id == music.id }) {
            topMusic[index].toggleFavorita()
            saveFavoriteMusic(topMusic[index])
        } else if let index = favoriteMusic.firstIndex(where: { $0.id == music.id }) {
            favoriteMusic[index].toggleFavorita()
            saveFavoriteMusic(favoriteMusic[index])
        }
    }
    
    func updateTopMusicWithFavorites() {
        for (index, _) in topMusic.enumerated() {
            if favoriteMusic.contains(where: { $0.nome == topMusic[index].nome } ) {
                topMusic[index].isFavorita = true
            }
        }
    }

    func getTopTracks() {
        isLoading = true
        
        GetTopTracks.shared.getTopTracks { [weak self] musicArray in
            DispatchQueue.main.async {
                self?.isLoading = false
                if let musicArray = musicArray {
                    self?.topMusic = musicArray
                    self?.updateTopMusicWithFavorites()
                }
            }
        }
    }

    func getFavoriteTracks() {
        isLoading = true
        DispatchQueue.main.async {
            self.isLoading = false
            self.favoriteMusic = self.persistence.loadMusic()
        }
    }

    func favoriteTrack(_ music: Music) {
        if !favoriteMusic.contains(where: { $0.id == music.id }) {
            favoriteMusic.append(music)
            saveFavoriteMusic(music)
        }
    }
}
