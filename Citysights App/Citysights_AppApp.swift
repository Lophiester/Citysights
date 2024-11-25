//
//  Citysights_AppApp.swift
//  Citysights App
//
//  Created by Charles Yamamoto on 2024/11/16.
//

import SwiftUI

@main
struct Citysights_AppApp: App {
    @State var model = BusinessModel()
    var body: some Scene {
        WindowGroup {
            ContentView().environment(model)
        }
    }
}
