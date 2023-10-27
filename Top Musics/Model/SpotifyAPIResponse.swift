//
//  SpotifyAPIResponse.swift
//  Top Musics
//
//  Created by Lucas Ferreira on 26/10/23.
//

import Foundation
import SwiftUI

struct SpotifyAPIResponse: Codable {
    let href: String
    let items: [Item]
    
    struct Item: Codable {
        let added_at: String
        let track: Track
    }

    struct Track: Codable {
        let name: String
        let artists: [Artist]
        let album: Album
        let duration_ms: Int
        let popularity: Int
        let external_urls: ExternalURLs

        struct Artist: Codable {
            let name: String
        }

        struct Album: Codable {
            let name: String
            let images: [SpotifyImage]
        }

        struct SpotifyImage: Codable {
            let url: String

            var imageObject: URL? {
                return URL(string: url)
            }
        }

        struct ExternalURLs: Codable {
            let spotify: String
        }
    }
}

