//
//  BusinessDetailView.swift
//  Citysights App
//
//  Created by Charles Yamamoto on 2024/11/19.
//

import SwiftUI

struct BusinessDetailView: View {
    
    var business: Business?
    
    var body: some View {
        Text(business?.name ?? "No name")
    }
}

#Preview {
    BusinessDetailView()
}
