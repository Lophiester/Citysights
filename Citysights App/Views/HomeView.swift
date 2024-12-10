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
    @State var isPopularOn: Bool = false
    @State var isDealsOn: Bool = false
    @State var categorySearch: String = "restaurants"
    
    @State var query: String = ""
    @FocusState var isQueryBoxFocused: Bool
    
    
    var body: some View {
        @Bindable var model = model
        VStack{
            HStack {
                TextField("What are you looking for?", text: $query)
                    .textFieldStyle(.roundedBorder)
                    .focused($isQueryBoxFocused)
                Button {
                    withAnimation{
                        isQueryBoxFocused = false}
                    model.getBusinesses(query: query, options: getOptionsString(), category: categorySearch)
                    
                } label: {
                    Text("Go")
                        .foregroundStyle(.white)
                        .padding(.horizontal)
                        .frame(height: 32)
                        .background(Color.blue)
                        .clipShape(.buttonBorder)
                }
            }
            .padding(.horizontal)
            
            //Query options. Show if textbox is focused
            if isQueryBoxFocused{
            VStack{
                Toggle("Popular", isOn: $isPopularOn)
                Toggle("Deals", isOn: $isDealsOn)
                HStack {
                    Text("Category")
                    Spacer()
                    Picker("Category", selection: $categorySearch) {
                        Text("Restaurants")
                            .tag("restaurants")
                        Text("Arts")
                            .tag("arts")
                    }
                }
                
            }
            .padding(.horizontal,40)
            .transition(.scale)
                
        }
             
            // Show picker
            Picker("", selection: $selectedTab) {
                Text("List")
                    .tag(0)
                
                Text("Map")
                    .tag(1)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            // Show map or List
            if selectedTab == 1{
                MapView().onTapGesture {
                    withAnimation{
                        isQueryBoxFocused = false}
                }
            } else {
                ListView().onTapGesture {
                    withAnimation{
                        isQueryBoxFocused = false}
                }
                    }
            
        }
        .onAppear{
            model.getBusinesses(query: nil, options: nil, category: nil)
        }
        .sheet(item: $model.selected) { item in
            BusinessDetailView()
        }
        
    }
    
    private func getOptionsString() -> String {
        var optionsString = [String]()
        if isPopularOn { optionsString.append("hot_and_new") }
        if isDealsOn { optionsString.append("deals") }
        return optionsString.joined(separator: ",")
    
    
    }
    
    
}

#Preview {
    HomeView().environment(BusinessViewModel())
}
