//
//  WordsApp.swift
//  Words
//
//  Created by Huang Runhua on 5/13/23.
//

import SwiftUI

@main
struct WordsApp: App {
    
    @StateObject private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
