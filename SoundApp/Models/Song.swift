//
//  Song.swift
//  SoundApp
//
//  Created by Marcos Tito on 6/11/25.
//

import Foundation

struct Song : Identifiable {
    let id = UUID()
    let title: String
    let artist : String
    let fileName: String
    let imageName: String
    var isFavorite: Bool
}
