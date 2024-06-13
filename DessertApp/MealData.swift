//
//  MealData.swift
//  DessertApp
//
//  Created by Brandt Hofer on 6/12/24.
//

struct MealDetailResponse: Codable {
    let meals: [MealDetail]
}

struct MealDetail: Identifiable, Codable {
    let id: String
    let name: String
    let instructions: String
    let thumbnail: String
    let youtubeLink: String
    let ingredients: [String]
    let measurements: [String]
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case instructions = "strInstructions"
        case thumbnail = "strMealThumb"
        case youtubeLink = "strYoutube"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        instructions = try container.decode(String.self, forKey: .instructions)
        thumbnail = try container.decode(String.self, forKey: .thumbnail)
        youtubeLink = try container.decode(String.self, forKey: .youtubeLink)
        
        // Decode ingredients and measurements
        let data = try decoder.singleValueContainer().decode([String: String?].self)
        var ingredients: [String] = []
        var measurements: [String] = []
        
        for index in 1...20 {
            if let ingredient = data["strIngredient\(index)"] as? String, !ingredient.isEmpty {
                ingredients.append(ingredient)
            }
            if let measurement = data["strMeasure\(index)"] as? String, !measurement.isEmpty {
                measurements.append(measurement)
            }
        }
        
        self.ingredients = ingredients
        self.measurements = measurements
    }
}



