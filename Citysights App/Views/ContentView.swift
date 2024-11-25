//
//  ContentView.swift
//  Citysights App
//
//  Created by Charles Yamamoto on 2024/11/16.
//

import SwiftUI

struct ContentView: View {
    @Environment(BusinessModel.self) private var model
    

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
                    List{
                        ForEach(model.businesses) { business in
                            VStack(spacing: 20) {
                                HStack(spacing: 0){
                                    Image("list-placeholder-image")
                                        .padding(.trailing,16)
                                    VStack(alignment: .leading, spacing: 5){
                                        Text(business.name ?? "No Name")
                                            .font(Font.system(size: 15))
                                            .fontWeight(.bold)
                                        Text(TextHelper.distanceAwaysText(meters: business.distance ?? 0))
                                            .font(Font.system(size: 16))
                                            .foregroundStyle(Color(red: 67/255, green: 71/255, blue: 76/255))
                                        
                                    }
                                    Spacer()
                                    Image("regular_\(round(business.rating ?? 0))")
                                    
                                }
                                Divider()
                            }
                            .onTapGesture {
                                model.selected = business
                                
                            }
                        }
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
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
    ContentView()
}
