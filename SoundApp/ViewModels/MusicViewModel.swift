//
//  MusicViewModel.swift
//  SoundApp
//
//  Created by Marcos Tito on 6/11/25.
//

import Foundation
import AVFoundation
import Combine

class MusicViewModel: ObservableObject {
    @Published var songs: [Song] = sampleSongs
    @Published var currentSong: Song? = nil
    @Published var isPlaying: Bool = false
    
    private var audioPlayer: AVAudioPlayer?
    private var lastTapTime: Date? // Para detectar doble toque en "anterior"
    
    // MARK: - REPRODUCIR CANCIÓN
    func playSong(_ song: Song) {
        guard let url = Bundle.main.url(forResource: song.fileName, withExtension: "mp3") else {
            print("Error: no se encontró el archivo \(song.fileName).mp3")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
            currentSong = song
            isPlaying = true
        } catch {
            print("Error al reproducir la canción: \(error.localizedDescription)")
        }
    }
    
    // MARK: - PAUSAR REPRODUCCIÓN
    func pauseSong() {
        audioPlayer?.pause()
        isPlaying = false
    }
    
    // MARK: - REANUDAR CANCIÓN
    func resumeSong() {
        audioPlayer?.play()
        isPlaying = true
    }
    
    // MARK: - FAVORITOS
    func toggleFavorite(for song: Song) {
        if let index = songs.firstIndex(where: { $0.id == song.id }) {
            songs[index].isFavorite.toggle()
        }
    }
    
    // MARK: - OBTENER CANCIONES FAVORITAS
    var favoriteSongs: [Song] {
        songs.filter { $0.isFavorite }
    }
    
    // MARK: - SIGUIENTE CANCIÓN
    func nextSong() {
        guard let current = currentSong else {
            if let first = songs.first {
                playSong(first)
            }
            return
        }
        
        guard let index = songs.firstIndex(where: { $0.id == current.id }) else { return }
        
        let nextIndex = (index + 1) % songs.count 
        let next = songs[nextIndex]
        playSong(next)
    }
    
    // MARK: - CANCIÓN ANTERIOR
    func previousSong() {
        let now = Date()
        
        // Si hay una marca de tiempo y fue hace menos de 0.5 segundos => doble toque
        if let lastTap = lastTapTime, now.timeIntervalSince(lastTap) < 0.5 {
            guard let current = currentSong,
                  let index = songs.firstIndex(where: { $0.id == current.id }) else { return }
            
            let prevIndex = (index - 1 + songs.count) % songs.count
            let previous = songs[prevIndex]
            playSong(previous)
        } else {
            // Primer toque reinicia la canción
            audioPlayer?.currentTime = 0
            audioPlayer?.play()
            isPlaying = true
        }
        
        // Actualiza el tiempo del último toque
        lastTapTime = now
    }
}
