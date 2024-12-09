//
//  BusinessDetailView.swift
//  Citysights App
//
//  Created by Charles Yamamoto on 2024/11/19.
//

import SwiftUI
import SDWebImageSwiftUI

struct BusinessDetailView: View {
    
    @Environment(BusinessViewModel.self) private var model
    
    var body: some View {
        let business = model.selected
        
        VStack(spacing:0){
            ZStack(alignment: .bottomTrailing) {
                if let imageURL = business?.imageUrl {
                    WebImage(url: URL(string: imageURL)) {
                        $0.resizable()
                            .scaledToFill()
                            .frame(height: 164)
                            .clipped()
                    } placeholder: {
                        ProgressView()
                    }

                }else{
                    Image("detail-placeholder-image")
                        .resizable()
                }
    
                VStack {
                    Spacer()
                    Image("yelp-attribution-image")
                        .frame(width: 72, height: 36)
                }
            }
            .frame(height: 164)
            
            if let isClosed = business?.isClosed {
                ZStack(alignment: .leading) {
                    Rectangle()
                        .foregroundStyle(isClosed ? .red : .green)
                    Text(isClosed ? "Closed" : "Open" )
                        .foregroundStyle(.white)
                        .font(.callout)
                        .padding(.horizontal)
                }
                .frame(height: 36)
                
            }
            ScrollView{
                VStack(alignment: .leading ,spacing: 0){
                    Text(business?.name ?? "No Name")
                        .font(Font.system(size: 21))
                        .bold()
                        .padding(.top,16)
                        .padding(.bottom, 10)
                    Text(
                        "\(business?.location?.address1 ?? "No Address"), \(business?.location?.city ?? "No City")")
                    Text(" \(business?.location?.state ?? "No State" ) \(business?.location?.zipCode ?? "No Zipcode"), \(business?.location?.country ?? "No Country ")")
                        .padding(.bottom,10)
                    Image("regular_\(round(business?.rating ?? 0))")
                        .padding(.bottom,16)
                    Divider()
                    HStack{
                        Image(systemName: "phone")
                        Text(business?.phone ?? "No Phone")
                        Spacer()
                        Image(systemName: "arrow.right")
                        
                    }.padding(.vertical,12)
                    Divider()
                    HStack{
                        Image(systemName: "globe")
                        Text(business?.url ?? "No URL")
                            .lineLimit(1)
                        Spacer()
                        Image(systemName: "arrow.right")
                    }.padding(.vertical,12)
                    Divider()
                    HStack{
                        Image(systemName: "bubble.left.and.bubble.right")
                        Text(TextHelper.reviewCountText(reviews: business?.reviewCount ?? 0))
                        Spacer()
                        Image(systemName: "arrow.right")
                        
                    }.padding(.vertical,12)
                    Spacer()
                   
                }
            }
            .padding(.horizontal)
            
        }
        .ignoresSafeArea()
    }
}

#Preview {
    BusinessDetailView().environment(BusinessViewModel())
}
