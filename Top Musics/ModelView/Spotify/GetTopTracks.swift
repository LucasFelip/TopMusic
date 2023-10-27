//
//  GetTopTracks.swift
//  Top Musics
//
//  Created by Lucas Ferreira on 26/10/23.
//

import Foundation

import Foundation

class GetTopTracks {
    static let shared = GetTopTracks()
    
    private let baseURL = "https://api.spotify.com/v1/playlists/37i9dQZEVXbMDoHDwVN2tF/tracks?limit=50"
    
    private init() {}
    
    
    func getTopTracks(completion: @escaping ([Music]?) -> Void) {
        guard let url = URL(string: baseURL) else {
            print("Erro: URL inválida para a API do Spotify")
            completion(nil)
            return
        }
        
        SpotifyAuth.shared.getToken { token in
            guard let token = token else {
                print("Erro ao obter o token de acesso")
                completion(nil)
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
            URLSession.shared.dataTask(with: request) { data, _, error in
                if let error = error {
                    print("Erro na solicitação: \(error)")
                    completion(nil)
                    return
                }
                
                guard let data = data else {
                    print("Erro: Nenhum dado recebido da API")
                    completion(nil)
                    return
                }
                
                do {
                    let jsonDecoder = JSONDecoder()
                    let spotifyResponse = try jsonDecoder.decode(SpotifyAPIResponse.self, from: data)
                    
                    let items = spotifyResponse.items
                    
                    var musicArray = [Music]()
                    
                    for (index, item) in items.enumerated() {
                        let track = item.track
                        
                        let imageData: Data? = {
                            if let imageUrl = track.album.images.first?.imageObject,
                               let imageData = try? Data(contentsOf: imageUrl) {
                                return imageData
                            }
                            return nil
                        }()
                        
                        let music = Music(posicao: index + 1,
                                          imagem: imageData,
                                          nome: track.name,
                                          artista: track.artists.first?.name ?? "",
                                          popularidade: track.popularity,
                                          duracao: TimeInterval(track.duration_ms) / 1000,
                                          spotifyURL: URL(string: track.external_urls.spotify))
                        
                        musicArray.append(music)
                    }
                                
                    completion(musicArray)
                } catch {
                    print("Erro ao fazer o parsing dos dados da API: \(error)")
                    completion(nil)
                }
            }.resume()
        }
    }
}
