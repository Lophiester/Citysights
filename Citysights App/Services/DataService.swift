//
//  DataService.swift
//  Citysights App
//
//  Created by Charles Yamamoto on 2024/11/18.
//

import Foundation

struct DataService {
    
    let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String
    
    func businessSearch() async -> [Business] {
        
        // Check if api key exists
        guard apiKey != nil else {
            print("API key is missing.")
            return []
        }
        
        // 1. Create url
        if let url = URL(string: "https://api.yelp.com/v3/businesses/search?latitude=35.665517&longitude=139.770398&categories=restaurants&limit=10") {
            
            // 2. Create request
            var request = URLRequest(url: url)
            request.addValue("Bearer \(apiKey!)", forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "accept")
            
            // 3. Send request
            do {
                let (data, response) = try await URLSession.shared.data(for: request)
                
                // Optional: Validate the response status code
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                    print("HTTP Error: \(httpResponse.statusCode)")
                    return []
                }
                
                // 4. Parse the JSON
                let decoder = JSONDecoder()
                let result = try decoder.decode(BusinessSearch.self, from: data)
                return result.businesses ?? []
            } catch {
                print("Error during request or JSON decoding: \(error)")
                return [] // Return empty array if an error occurs
            }
        }
        
        print("Invalid URL.")
        return [] // Return empty array if the URL is invalid
    }
}
