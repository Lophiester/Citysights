//
//  BusinessModel.swift
//  Citysights App
//
//  Created by Charles Yamamoto on 2024/11/25.
//

import Foundation
import CoreLocation

@Observable
class BusinessViewModel: NSObject,CLLocationManagerDelegate{
    
    var businesses = [Business]()
    var text: String = ""
    var selected: Business?
    var service = DataService()
    
    var locationManager = CLLocationManager()
    var showAlert = false
    var errorMessage = ""
    var isLoading = false
    var currentUserLocation: CLLocationCoordinate2D?
    
    
    override init() {
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.delegate = self
    }
    
    func getBusinesses(){
        Task{
            do{
                isLoading = true
                businesses = try await service.businessSearch(userLocation: currentUserLocation)
                isLoading = false}
            catch{
                showAlert = true
                errorMessage = error.localizedDescription}
        }
    }
    
    func getUserLocation(){
        
        // Check if we have permission
        if  locationManager.authorizationStatus == .authorizedWhenInUse{
            currentUserLocation = nil
            locationManager.requestLocation()}
        else { locationManager.requestWhenInUseAuthorization()}
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse {
            currentUserLocation = nil
        manager.requestLocation()}
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if currentUserLocation == nil{
            currentUserLocation = locations.last?.coordinate
            getBusinesses()}
        manager.stopUpdatingLocation()
    }
}
