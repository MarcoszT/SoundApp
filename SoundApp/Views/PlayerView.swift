//
//  PlayerView.swift
//  SoundApp
//
//  Created by Marcos Tito on 6/11/25.
//

import SwiftUI

struct PlayerView: View {
    @StateObject var viewModel = MusicViewModel()
    
    var body: some View {
        VStack(spacing: 32) {
            
            // Imagen de la canción
            if let song = viewModel.currentSong {
                Image(song.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
                    .cornerRadius(20)
                    .shadow(radius: 8)
            } else {
                Image("defaultImage")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
                    .cornerRadius(20)
                    .shadow(radius: 8)
            }
            
            // Nombre y artista
            VStack(spacing: 8) {
                Text(viewModel.currentSong?.title ?? "Selecciona una canción")
                    .font(.title2)
                    .fontWeight(.semibold)
                Text(viewModel.currentSong?.artist ?? "")
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
                        viewModel.resumeSong()
                    } else if let first = viewModel.songs.first {
                        viewModel.playSong(first)
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
            
            // Botón de favoritos
            if let current = viewModel.currentSong {
                Button {
                    viewModel.toggleFavorite(for: current)
                } label: {
                    Image(systemName: current.isFavorite ? "heart.fill" : "heart")
                        .font(.title)
                        .foregroundColor(current.isFavorite ? .red : .gray)
                }
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    PlayerView()
}
