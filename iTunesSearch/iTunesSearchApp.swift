//
//  iTunesSearchApp.swift
//  iTunesSearch
//
//  Created by Andrea Stevanato on 29/08/23.
//

import SwiftUI

@main
struct iTunesSearchApp: App {
    
    let container: DIContainer = DIContainer()
    
    var body: some Scene {
        WindowGroup {
            ContentView(container: container)
        }
    }
}
