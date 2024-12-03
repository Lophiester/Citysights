//
//  MapView.swift
//  Citysights App
//
//  Created by Charles Yamamoto on 2024/11/26.
//

import SwiftUI
import MapKit

struct MapView: View {
    @Environment(BusinessModel.self) private var model
    @State var selectedBusinessId: String?
    var body: some View {
        Map(selection: $selectedBusinessId){
            ForEach(model.businesses){ business in
                Marker(business.name ?? "Restaurant", coordinate: CLLocationCoordinate2D(latitude: business.coordinates?.latitude ?? 0, longitude: business.coordinates?.longitude ?? 0))
                    .tag(business.id)
            }
        }
        .onChange(of: selectedBusinessId) { oldValue, newValue in
            // Find the business which matches this id
            let business = model.businesses.first(where: { $0.id == selectedBusinessId })
            // If the business is found, set it as the selected one
            if let business = business {
                model.selected = business
            }
            
            
        }
    }
    
    
}

#Preview {
    MapView().environment(BusinessModel())
}
