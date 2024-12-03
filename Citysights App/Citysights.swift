//
//  Citysights_AppApp.swift
//  Citysights App
//
//  Created by Charles Yamamoto on 2024/11/16.
//

import SwiftUI

@main
struct Citysights: App {
    @State var model = BusinessViewModel()
    var body: some Scene {
        WindowGroup {
            HomeView().environment(model)
        }
    }
}
