//
//  TopMusicViewModel.swift
//  Top Musics
//
//  Created by Lucas Ferreira on 26/10/23.
//

import SwiftUI

class TopMusicViewModel: ObservableObject {
    @Published var topMusic: [Music] = []
    @Published var isLoading: Bool = false
    
    func toggleFavorite(for music: Music) {
        if let index = topMusic.firstIndex(where: { $0.id == music.id }) {
            topMusic[index].toggleFavorita()
        }
    }

    func getTopTracks() {
        isLoading = true
        
        GetTopTracks.shared.getTopTracks { [weak self] musicArray in
            DispatchQueue.main.async {
                self?.isLoading = false
                if let musicArray = musicArray {
                    self?.topMusic = musicArray
                }
            }
        }
    }
}

