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
    @AppStorage("onboarding") var needsOnboarding: Bool = true
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(model)
                .fullScreenCover(isPresented: $needsOnboarding) {
                    // on dismiss
                    needsOnboarding = false}content: { OnboardingView().environment(model)}
                .onAppear{
                    // if no onboarding is needed, still get location
                    if needsOnboarding == false {
                        model.getUserLocation()}}
        }
    }
}
