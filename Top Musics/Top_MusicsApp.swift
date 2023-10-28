//
//  Top_MusicsApp.swift
//  Top Musics
//
//  Created by Lucas Ferreira on 26/10/23.
//

import SwiftUI

@main
struct Top_MusicsApp: App {
    @StateObject private var topMusicViewModel = TopMusicViewModel()
    
    var body: some Scene {
        WindowGroup {
            InitView()
                .environmentObject(topMusicViewModel)
        }
    }
}
