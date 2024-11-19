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
    @State var selected: Business?
    var service = DataService()
    var body: some View {
        VStack{
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
            List{
                ForEach(businesses) { business in
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
                        selected = business
                    }
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
        }
        Spacer()
            .task {
                businesses = await service.businessSearch()
            }
            .sheet(item: $selected) { item in
                BusinessDetailView(business: item)
            }
           
    }
}

#Preview {
    ContentView()
}
