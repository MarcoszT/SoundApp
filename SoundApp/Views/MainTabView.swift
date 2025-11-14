//
//  MainTabView.swift
//  SoundApp
//
//  Created by Marcos Tito on 13/11/25.
//

import SwiftUI

struct MainTabView: View {
    @StateObject private var viewModel = MusicViewModel()

    var body: some View {
        TabView {
            // HOME
            NavigationStack {
                HomeView(viewModel: viewModel)
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }

            // FAVORITOS
            NavigationStack {
                FavoritesView(viewModel: viewModel)
            }
            .tabItem {
                Image(systemName: "heart.fill")
                Text("Favoritos")
            }

            // BUSCAR
            NavigationStack {
                SearchView(viewModel: viewModel)
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Buscar")
            }
        }
    }
}

#Preview {
    MainTabView()
}
