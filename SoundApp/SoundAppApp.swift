//
//  SoundAppApp.swift
//  SoundApp
//
//  Created by Marcos Tito on 6/11/25.
//

import SwiftUI

@main
struct SoundAppApp: App {
    @StateObject private var musicVM = MusicViewModel()

    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
    }
}


