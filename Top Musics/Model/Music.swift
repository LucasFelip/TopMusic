//
//  Music.swift
//  Top Musics
//
//  Created by Lucas Ferreira on 26/10/23.
//

import Foundation

struct Music: Codable, Identifiable {
    var id = UUID()
    let posicao: Int
    let imagem: Data?
    let nome: String
    let artista: String
    let popularidade: Int
    let duracao: TimeInterval
    let spotifyURL: URL?
    var isFavorita: Bool = false
    var posicaoFavorita: Int = 0
}

extension Music {
    var duracaoEmMinutos: String {
        let duracaoEmSegundos = Double(duracao)
        let minutos = Int(duracaoEmSegundos / 60)
        let segundos = Int(duracaoEmSegundos.truncatingRemainder(dividingBy: 60))
        return String(format: "%d:%02d", minutos, segundos)
    }
}

extension Music {
    mutating func toggleFavorita() {
        self.isFavorita.toggle()
    }
}

