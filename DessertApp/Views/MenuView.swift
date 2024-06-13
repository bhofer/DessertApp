//
//  ContentView.swift
//  DessertApp
//
//  Created by Brandt Hofer on 6/10/24.
//

import SwiftUI

struct MenuView: View {
    @StateObject private var viewModel = MenuViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.meals) { meal in
                NavigationLink(destination: MealDetailView(mealId: meal.id)) {
                    HStack {
                        AsyncImage(url: URL(string: meal.thumbnail)) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 50, height: 50)
                        .cornerRadius(8)
                        Text(meal.name)
                    }
                }
            }
            .navigationTitle("Dessert Menu")
            .onAppear {
                viewModel.fetchMeals()
            }
        }
    }
}
