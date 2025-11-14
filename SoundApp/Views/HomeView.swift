//
//  HomeView.swift
//  SoundApp
//
//  Created by Marcos Tito on 13/11/25.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: MusicViewModel

    var body: some View {
        List(viewModel.songs) { song in
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

                    VStack(alignment: .leading, spacing: 4) {
                        Text(song.title)
                            .font(.headline)
                        Text(song.artist)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }

                    Spacer()

                    // Heart button inline (toggle favorito)
                    Button {
                        viewModel.toggleFavorite(for: song)
                    } label: {
                        Image(systemName: song.isFavorite ? "heart.fill" : "heart")
                            .foregroundColor(song.isFavorite ? Color(red: 1.00, green: 0.24, blue: 0.27) : .gray)
                    }
                    .buttonStyle(.plain)
                }
                .padding(.vertical, 6)
            }
        }
        .listStyle(.plain)
        .navigationTitle("Home")
    }
}

#Preview {
    HomeView(viewModel: MusicViewModel())
}
