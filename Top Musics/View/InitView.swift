//
//  InitView.swift
//  Top Musics
//
//  Created by Lucas Ferreira on 26/10/23.
//

import SwiftUI

struct TabBarController: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ListTopMusicView()
                .tabItem {
                    TopMusics()
                }
                .padding(.bottom, 5)
                .tag(0)
            ListFavTopMusicView()
                .tabItem {
                    Favorites()
                }
                .padding(.bottom, 5)
                .tag(1)
                   
        }
        .accentColor(.green)
        .foregroundColor(.primary)
    }
}

struct InitView: View {
    var body: some View {
        NavigationStack {
            VStack {
                TabBarController()
            }
            .frame(alignment: .bottom)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    InitView()
}
