//
//  PersistenceLocal.swift
//  Top Musics
//
//  Created by Lucas Ferreira on 26/10/23.
//

import Foundation

class PersistenceMusic {
    @Published var favoriteMusic: [Music] = []
    
    static let shared = PersistenceMusic()
    
    func saveMusic(_ musicas: [Music]) {
        let musicasFavoritas = musicas.filter { $0.isFavorita }
        var musicasWithUpdatedPosition: [Music] = []
        
        print("\n\n \(musicas) \n\n")
        
        for (index, var musica) in musicasFavoritas.enumerated() {
            musica.posicaoFavorita = index + 1
            musicasWithUpdatedPosition.append(musica)
        }
        
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(musicasWithUpdatedPosition) {
            UserDefaults.standard.set(encodedData, forKey: "MusicasFavoritas")
        }
    }


    func  loadMusic() -> [Music] {
        if let savedData = UserDefaults.standard.data(forKey: "MusicasFavoritas") {
            let decoder = JSONDecoder()
            if let musicas = try? decoder.decode([Music].self, from: savedData) {
                return musicas
            }
        }
        return []
    }
}
