//
//  fdsfsApp.swift
//  fdsfs
//
//  Created by student on 14/11/2023.
//

import SwiftUI

@main
struct fdsfsApp: App {
    @StateObject var game = MemoGameViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
