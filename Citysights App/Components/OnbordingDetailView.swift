//
//  OnbordingViewDetails.swift
//  Citysights App
//
//  Created by Charles Yamamoto on 2024/12/03.
//

import SwiftUI

struct OnbordingDetailView: View {
    var bgColor: Color
    var headLine: String
    var subHeadLine: String
    var buttonAction: ()-> Void
    
    var body: some View {
        ZStack{
            Color(bgColor)
            VStack(){
                Spacer()
                Spacer()
                Image("onboarding")
                Text(headLine)
                    .font(.title)
                    .bold()
                    .padding(.top,32)
                Text(subHeadLine)
                    .font(.subheadline)
                    .padding(.top,4)
                Spacer()
                Button {
                    buttonAction()
                } label: {
                    Text("Next")
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.white)
                        .clipShape(.rect(cornerRadius: 15))
                }
                .padding(.horizontal)
                .padding(.bottom,115)
                
            }
            .foregroundStyle(.white)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    OnbordingDetailView(bgColor: Color(red: 111/255, green: 154/255, blue: 189/255), headLine: "Welcome to Citysights!", subHeadLine: "City Sights helps you find the best of the city!", buttonAction:{} )
}
