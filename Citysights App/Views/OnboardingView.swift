//
//  OnboardingView.swift
//  Citysights App
//
//  Created by Charles Yamamoto on 2024/12/03.
//

import SwiftUI

struct OnboardingView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var selectedTab: Int = 0
    
    
    var body: some View {
        
        ZStack{
            if selectedTab == 0 {
                Color(red: 111/255, green: 154/255, blue: 189/255)
             } else{
                 Color(red: 139/255, green: 166/255, blue: 65/255)
             }
            
            TabView(selection: $selectedTab){
                OnbordingViewDetails(bgColor: Color(red: 111/255, green: 154/255, blue: 189/255), headLine: "Welcome to Citysights!", subHeadLine: "City Sights helps you find the best of the city!", buttonAction: {
                    withAnimation {
                        selectedTab = 1
                    }
                   
                })
                .tag(0)
                OnbordingViewDetails(bgColor: Color(red: 139/255, green: 166/255, blue: 65/255), headLine: "Discover your city", subHeadLine: "We'll help you find the best of the restaurants, venues based on your location.!", buttonAction: {
                    dismiss()
                })
                .tag(1)
               
            }
            // hidden dots
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            VStack{
                Spacer()
                HStack(spacing: 16){
                    Spacer()
                    Circle()
                        .frame(width: 10)
                        .foregroundStyle(selectedTab == 0 ? .white : .gray)
                    Circle()
                        .frame(width: 10)
                        .foregroundStyle(selectedTab == 1 ? .white : .gray)
                    Spacer()
                }
                .padding(.bottom,220)
            }
           
            
        }
        .ignoresSafeArea()
      
        
       
    }
}

#Preview {
    OnboardingView()
}

