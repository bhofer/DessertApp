//
//  MenuData.swift
//  DessertApp
//
//  Created by Brandt Hofer on 6/12/24.
//

import Foundation

struct Meal: Identifiable, Codable {
    let id: String
    let name: String
    let thumbnail: String
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case thumbnail = "strMealThumb"
    }
}

struct MenuResponse: Codable {
    let meals: [Meal]
}
