//
//  DataService.swift
//  Citysights App
//
//  Created by Charles Yamamoto on 2024/11/18.
//

import Foundation
import CoreLocation

struct DataService {
    
    private let apiKey : String?

    init(){
        self.apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String
    }
    
    func businessSearch(userLocation: CLLocationCoordinate2D?) async throws -> [Business] {
        // Check if api key exists
        guard let apiKey = apiKey else { throw DataServiceError.missingAPIKey}
        
        // Default lat long
        var latitude = 39.770398
        var longitude = 139.770398
        
        // User lat long
        if let userLocation {
            latitude = userLocation.latitude
            longitude = userLocation.longitude
        }
        // 1. Create url
        guard let url = URL(
            string: "https://api.yelp.com/v3/businesses/search?latitude=\(latitude)&longitude=\(longitude)&categories=restaurants&limit=10")
        else { throw DataServiceError.invalidURL}
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "accept")
        
        let (data,response) = try await URLSession.shared.data(for: request)
        guard let res = response as? HTTPURLResponse, res.statusCode == 200 else {
            throw DataServiceError.invalidResponse}
        do{
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let result = try decoder.decode(BusinessSearchModel.self, from: data)
            return result.businesses ?? []}
        catch{throw DataServiceError.decodingError(error)}
    }
}
