//
//  ContentView.swift
//  Citysights App
//
//  Created by Charles Yamamoto on 2024/11/16.
//

import SwiftUI

struct ContentView: View {
    
    @State var text: String = ""
    var body: some View {
        VStack {
            HStack {
                TextField("What are you looking for?", text: $text)
                    .textFieldStyle(.roundedBorder)
                Button {
                    // TODO: implement some action
                } label: {
                    Text("Search")
                        .foregroundStyle(.white)
                        .padding()
                        .background(Color.blue)
                        .clipShape(.buttonBorder)
                }
                
            }
            .padding()
            HStack {
                TextField("What are you looking for?", text: $text)
                    .textFieldStyle(.roundedBorder)
                Button {
                    // TODO: implement some action
                } label: {
                    Text("Search")
                        .foregroundStyle(.white)
                        .padding()
                        .background(Color.blue)
                        .clipShape(.buttonBorder)
                }
                
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
