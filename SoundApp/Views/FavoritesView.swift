//
//  FavoritesView.swift
//  SoundApp
//
//  Created by Marcos Tito on 13/11/25.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel: MusicViewModel

    var body: some View {
        List {
            if viewModel.favoriteSongs.isEmpty {
                Text("Aún no tienes favoritos")
                    .foregroundColor(.secondary)
                    .padding()
            } else {
                ForEach(viewModel.favoriteSongs) { song in
                    NavigationLink {
                        PlayerView(viewModel: viewModel, song: song)
                    } label: {
                        HStack {
                            Image(song.imageName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 56, height: 56)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .padding(.trailing, 8)

                            VStack(alignment: .leading) {
                                Text(song.title).font(.headline)
                                Text(song.artist).font(.subheadline).foregroundColor(.secondary)
                            }

                            Spacer()

                            Image(systemName: "heart.fill")
                                .foregroundColor(Color(red: 1.00, green: 0.24, blue: 0.27))
                        }
                        .padding(.vertical, 6)
                    }
                }
            }
        }
        .navigationTitle("Favoritos")
    }
}

#Preview {
    NavigationStack {
        FavoritesView(viewModel: {
            let vm = MusicViewModel()
            // Agregar un favorito para preview
            if !vm.songs.isEmpty {
                vm.songs[0].isFavorite = true
            }
            return vm
        }())
    }
}

