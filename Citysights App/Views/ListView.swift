//
//  ListView.swift
//  Citysights App
//
//  Created by Charles Yamamoto on 2024/11/26.
//

import SwiftUI

struct ListView: View {
    
    @Environment(BusinessViewModel.self) var model
    
    var body: some View {
        
        List {
            ForEach(model.businesses) { b in
                
                VStack (spacing: 20) {
                    HStack (spacing: 0) {
                        
                        if let imageUrl = b.imageUrl {
                            // Display the business image
                            AsyncImage(url: URL(string: imageUrl)!) {
                                $0.resizable()
                                    .frame(width: 50, height: 50)
                                    .scaledToFill()
                                    .clipShape(.rect(cornerRadius: 6))
                                    .padding(.trailing, 16)
                            } placeholder: {
                                ProgressView()
                                    .frame(width: 50, height: 50)
                            }

                        }
                        else {
                            Image("list-placeholder-image")
                                .padding(.trailing, 16)
                        }
                        
                        VStack (alignment: .leading) {
                            Text(b.name ?? "Restaurant")
                                .font(Font.system(size: 15))
                                .bold()
                            Text(TextHelper.distanceAwayText(meters: b.distance ?? 0))
                                .font(Font.system(size: 16))
                                .foregroundStyle(Color(red: 67/255, green: 71/255, blue: 76/255))
                        }
                        Spacer()
                        Image("regular_\(round(b.rating ?? 0))")
                    }
                    Divider()
                }
                .onTapGesture {
                    model.selected = b
                }
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
    }
}

#Preview {
    ListView()
        .environment(BusinessViewModel())
}
