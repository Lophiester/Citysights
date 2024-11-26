//
//  ListView.swift
//  Citysights App
//
//  Created by Charles Yamamoto on 2024/11/26.
//

import SwiftUI

struct ListView: View {
    @Environment(BusinessModel.self) var model
    
    
    var body: some View {
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

#Preview {
    ListView().environment(BusinessModel())
}
