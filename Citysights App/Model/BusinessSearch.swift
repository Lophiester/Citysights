//
//  BusinessSearch.swift
//  Citysights App
//
//  Created by Charles Yamamoto on 2024/11/18.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct BusinessSearch: Codable {
    let businesses: [Business]?
    let region: Region?
    let total: Int?
}

// MARK: - Business
struct Business: Codable {
    let alias: String?
    let categories: [Category]?
    let coordinates: Center?
    let displayPhone: String?
    let distance: Double?
    let id: String?
    let imageURL: String?
    let isClosed: Bool?
    let location: Location?
    let name, phone, price: String?
    let rating: Double?
    let reviewCount: Int?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case alias, categories, coordinates
        case displayPhone = "display_phone"
        case distance, id
        case imageURL = "image_url"
        case isClosed = "is_closed"
        case location, name, phone, price, rating
        case reviewCount = "review_count"
        case url
    }
}


// MARK: - Open
struct Open: Codable {
    let isOvernight: Bool?
    let start, end, day: Int?

    enum CodingKeys: String, CodingKey {
        case isOvernight = "is_overnight"
        case start, end, day
    }
}

// MARK: - Category
struct Category: Codable {
    let alias, title: String?
}

// MARK: - Center
struct Center: Codable {
    let latitude, longitude: Double?
}

// MARK: - Location
struct Location: Codable {
    let address1, address2, address3, city: String?
    let country: String?
    let displayAddress: [String]?
    let state, zipCode: String?

    enum CodingKeys: String, CodingKey {
        case address1, address2, address3, city, country
        case displayAddress = "display_address"
        case state
        case zipCode = "zip_code"
    }
}

// MARK: - Region
struct Region: Codable {
    let center: Center?
}
