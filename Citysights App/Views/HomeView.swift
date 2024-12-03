//
//  ContentView.swift
//  Citysights App
//
//  Created by Charles Yamamoto on 2024/11/16.
//

import SwiftUI

struct HomeView: View {
    @Environment(BusinessViewModel.self) private var model
    @State var selectedTab = 0
    

    var body: some View {
        @Bindable var model = model
        VStack{
            HStack {
                TextField("What are you looking for?", text: $model.text)
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
            Spacer()
            VStack{
                if model.isLoading{
                    ProgressView()
                        .progressViewStyle(.circular)
                } else{
                    Picker("", selection: $selectedTab) {
                        Text("List")
                            .tag(0)
                        
                        Text("Map")
                            .tag(1)
                    }
                    .pickerStyle(.segmented)
                    if selectedTab == 1{
                        MapView()
                    } else {
                        ListView()
                    }
                }
            }
            Spacer()
        }
        Spacer()
            .onAppear{
                model.getBusinesses()
            }
            .sheet(item: $model.selected) { item in
                BusinessDetailView()
            }
           
    }

    
}

#Preview {
    HomeView().environment(BusinessViewModel())
}
