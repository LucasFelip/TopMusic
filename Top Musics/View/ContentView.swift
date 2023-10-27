//
//  ContentView.swift
//  Top Musics
//
//  Created by Lucas Ferreira on 26/10/23.
//

import SwiftUI

struct ContentView: View {
    @State private var iniciation = false
    
    var body: some View {
        NavigationStack {
            VStack {}
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    iniciation = true
                }
            }
            .navigationDestination(isPresented: $iniciation, destination: {
                
                    .navigationBarBackButtonHidden(true)
            })
        }
    }
}

#Preview {
    ContentView()
}
