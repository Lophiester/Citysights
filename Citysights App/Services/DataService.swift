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
    
    func businessSearch(userLocation: CLLocationCoordinate2D?, query: String?, options: String?, category:String?) async throws -> [Business] {
        // Check if api key exists
        guard let apiKey = apiKey else { throw DataServiceError.missingAPIKey}
        
        // Default lat long
        var lat = 35.665517
        var long = 139.770398
        
        // User lat long
        if let userLocation = userLocation {
            lat = userLocation.latitude
            long = userLocation.longitude
        }
        
        var urlString = "https://api.yelp.com/v3/businesses/search?latitude=\(lat)&longitude=\(long)&limit=10"
        
        // Add query
        if query != nil && query != "" {
            urlString.append("&term=\(query!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)")
        }
        
        // Add options
        if options != nil && options != "" {
            urlString.append("&attributes=\(options!)")
        }
        
        // Add category
        if let category = category {
            urlString.append("&category=\(category)")
        }
       
        // 1. Create url
        guard let url = URL(string: urlString )else { throw DataServiceError.invalidURL}
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "accept")
        
        let (data,response) = try await URLSession.shared.data(for: request)
        guard let res = response as? HTTPURLResponse, res.statusCode == 200 else {
            throw DataServiceError.invalidResponse}
        do{
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let result = try decoder.decode(BusinessSearch.self, from: data)
            return result.businesses}
        catch{throw DataServiceError.decodingError(error)}
    }
}
