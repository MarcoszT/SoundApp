//
//  SearchView.swift
//  SoundApp
//
//  Created by Marcos Tito on 13/11/25.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel: MusicViewModel

    // Usamos un estado local para el texto de búsqueda para evitar
    // problemas con bindings a través de @ObservedObject en previews/compilación.
    @State private var searchText: String = ""

    // Computed local que filtra según el texto
    private var filtered: [Song] {
        let text = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty else { return viewModel.songs }
        return viewModel.songs.filter {
            $0.title.localizedCaseInsensitiveContains(text) ||
            $0.artist.localizedCaseInsensitiveContains(text)
        }
    }

    var body: some View {
        List {
            ForEach(filtered) { song in
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
                    }
                    .padding(.vertical, 6)
                }
            }
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
        .navigationTitle("Buscar")
    }
}

#Preview {
    let vm = MusicViewModel()
    NavigationStack {
        SearchView(viewModel: vm)
    }
}
