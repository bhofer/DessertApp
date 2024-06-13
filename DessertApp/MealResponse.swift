//
//  MealResponse.swift
//  DessertApp
//
//  Created by Brandt Hofer on 6/12/24.
//

import Foundation
import Combine

class MealDetailViewModel: ObservableObject {
    @Published var mealDetail: MealDetail?
    private var cancellables = Set<AnyCancellable>()
    
    func fetchMealDetail(id: String) {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(id)") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: MealDetailResponse.self, decoder: JSONDecoder())
            .map { $0.meals.first }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: &$mealDetail)
    }
}

