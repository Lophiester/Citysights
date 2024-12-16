//
//  BusinessSearch.swift
//  CitySights App
//
//  Created by Chris Ching on 2023-09-21.
//

import Foundation

struct BusinessSearchModel: Decodable {
    var businesses = [BusinessModel]()
    var region = Region()
    var total = 0
}

struct Region: Decodable {
    var center: Coordinate?
}

struct Coordinate: Decodable {
    var latitude: Double?
    var longitude: Double?
}
