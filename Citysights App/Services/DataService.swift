//
//  DataService.swift
//  Citysights App
//
//  Created by Charles Yamamoto on 2024/11/18.
//

import Foundation

struct DataService {
    
    private let apiKey : String?
    private let urlText = "https://api.yelp.com/v3/businesses/search?latitude=35.665517&longitude=139.770398&categories=restaurants&limit=10"
    
    init(){
        self.apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String
    }
    
    func businessSearch() async throws -> [Business] {
        
        // Check if api key exists
        guard let apiKey = apiKey else {
            throw DataServiceError.missingAPIKey
        }
        
        // 1. Create url
        
        guard let url = URL(string: urlText) else {
            throw DataServiceError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "accept")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let res = response as? HTTPURLResponse, res.statusCode == 200 else {
            throw DataServiceError.invalidResponse
        }
        do{
            let decoder = JSONDecoder()
            let result = try decoder.decode(BusinessSearch.self, from: data)
            return result.businesses ?? []
        }
        catch{
            throw DataServiceError.decodingError(error)
        }
    }
}
