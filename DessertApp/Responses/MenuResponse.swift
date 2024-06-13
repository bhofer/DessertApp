//
//  MenuResponse.swift
//  DessertApp
//
//  Created by Brandt Hofer on 6/12/24.
//

import Foundation
import Combine

class MenuViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    private var cancellables = Set<AnyCancellable>()
    
    func fetchMeals() {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: MenuResponse.self, decoder: JSONDecoder())
            .map { $0.meals.sorted { $0.name < $1.name } }
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .assign(to: &$meals)
    }
}
