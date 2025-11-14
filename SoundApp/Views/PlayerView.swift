//
//  PlayerView.swift
//  SoundApp
//
//  Created by Marcos Tito on 6/11/25.
//

import SwiftUI

struct PlayerView: View {
    @ObservedObject var viewModel: MusicViewModel
    let song: Song

    var body: some View {
        VStack(spacing: 32) {

            // Imagen: preferimos mostrar la que viene en el modelo 'song'
            Image(song.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 250)
                .cornerRadius(20)
                .shadow(radius: 8)

            // Nombre y artista (mostramos datos del parámetro 'song',
            // pero la UI seguirá reflejando el estado real desde viewModel.currentSong)
            VStack(spacing: 8) {
                Text(viewModel.currentSong?.title ?? song.title)
                    .font(.title2)
                    .fontWeight(.semibold)
                Text(viewModel.currentSong?.artist ?? song.artist)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            // Controles
            HStack(spacing: 40) {

                // Anterior
                Button {
                    viewModel.previousSong()
                } label: {
                    Image(systemName: "backward.fill")
                        .font(.largeTitle)
                }

                // Play / Pause
                Button {
                    if viewModel.isPlaying {
                        viewModel.pauseSong()
                    } else if let current = viewModel.currentSong {
                        // Si ya hay una canción cargada, reanuda
                        viewModel.resumeSong()
                    } else {
                        // Si no hay canción cargada, reproduce la que llegó por parámetro
                        viewModel.playSong(song)
                    }
                } label: {
                    Image(systemName: viewModel.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                        .font(.system(size: 70))
                }

                // Siguiente
                Button {
                    viewModel.nextSong()
                } label: {
                    Image(systemName: "forward.fill")
                        .font(.largeTitle)
                }
            }
            .padding(.top, 20)

            // Botón de favoritos (usa el estado real en viewModel cuando exista)
            if let current = viewModel.currentSong {
                Button {
                    viewModel.toggleFavorite(for: current)
                } label: {
                    Image(systemName: current.isFavorite ? "heart.fill" : "heart")
                        .font(.title)
                        .foregroundColor(current.isFavorite ? .red : .gray)
                }
            } else {
                // Si todavía no hay 'currentSong', mostramos el favorito según 'song'
                Button {
                    viewModel.toggleFavorite(for: song)
                } label: {
                    Image(systemName: song.isFavorite ? "heart.fill" : "heart")
                        .font(.title)
                        .foregroundColor(song.isFavorite ? .red : .gray)
                }
            }

            Spacer()
        }
        .padding()
        .onAppear {
            // Al entrar, cargamos/ reproducimos la canción que llego por parámetro
            // Esto mantiene el comportamento esperado al navegar desde HomeView
            viewModel.playSong(song)
        }
    }
}

#Preview {
    // Preview rápido: crea un VM y usa la primera canción si existe
    let vm = MusicViewModel()
    PlayerView(viewModel: vm, song: vm.songs.first!)
}
