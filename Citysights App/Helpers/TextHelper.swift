//
//  TextHelper.swift
//  Citysights App
//
//  Created by Charles Yamamoto on 2024/11/19.
//

import Foundation

struct TextHelper{
    
    static func distanceAwayText(meters: Double) -> String {
        if meters > 1000 {
            return "\(Int(round(meters/1000))) km away"
        }
        else {
            return "\(Int(round(meters))) m away"
        }
    }
    
    static func reviewCountText(reviews: Int)-> String{
        
        if reviews > 1 {
            return ("\(reviews) reviews")
        }
        else {
            return ("\(reviews) review")
        }
    }
}


