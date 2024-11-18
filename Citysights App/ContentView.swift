//
//  ContentView.swift
//  Citysights App
//
//  Created by Charles Yamamoto on 2024/11/16.
//

import SwiftUI

struct ContentView: View {
    @State var businesses = [Business]()
    @State var text: String = ""
    var service = DataService()
    var body: some View {
        VStack(alignment: .leading) {
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
          
 ForEach(businesses) { business in
     Text(business.name ?? "No Name")
            }
        }
        .padding()
        Spacer()
        .task {
         businesses = await service.businessSearch()
        }
    }
}

#Preview {
    ContentView()
}
