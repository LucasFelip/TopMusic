//
//  SpotifyAuth.swift
//  Top Musics
//
//  Created by Lucas Ferreira on 26/10/23.
//

import Foundation

struct TokenResponse: Codable {
    let access_token: String
}

class SpotifyAuth {
    static let shared = SpotifyAuth()
    
    private let clientID = ProcessInfo.processInfo.environment["CLIENT_ID"] ?? ""
    private let clientSecret = ProcessInfo.processInfo.environment["CLIENT_SECRET"] ?? ""
    
    private func getAuthorizationHeader() -> String {
        let credentials = "\(clientID):\(clientSecret)"
        let data = credentials.data(using: .utf8)!
        let base64Credentials = data.base64EncodedString()
        return "Basic \(base64Credentials)"
    }
    
    func getToken(completion: @escaping (String?) -> Void) {
        guard let url = URL(string: "https://accounts.spotify.com/api/token") else {
            print("Erro: URL inválida para obter o token de acesso")
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue(getAuthorizationHeader(), forHTTPHeaderField: "Authorization")
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let body = "grant_type=client_credentials"
        request.httpBody = body.data(using: .utf8)

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Erro ao obter o token de acesso: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("Erro: Nenhum dado recebido ao obter o token de acesso")
                completion(nil)
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                let response = try jsonDecoder.decode(TokenResponse.self, from: data)
                let token = response.access_token
                completion(token)
            } catch {
                print("Erro ao fazer o parsing do token de acesso: \(error)")
                completion(nil)
            }
        }.resume()
    }
}
