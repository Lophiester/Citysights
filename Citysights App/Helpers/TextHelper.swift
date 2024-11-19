//
//  TextHelper.swift
//  Citysights App
//
//  Created by Charles Yamamoto on 2024/11/19.
//

import Foundation

struct TextHelper{
    
    static func distanceAwaysText(meters: Double) -> String {
        if meters > 1000 {
            return "\(Int(round(meters/1000))) km away"
        }
        else {
            return "\(Int(round(meters))) m away"
        }
    }
}
