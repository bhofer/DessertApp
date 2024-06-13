//
//  ContentView.swift
//  DessertApp
//
//  Created by Brandt Hofer on 6/10/24.
//

import SwiftUI

struct ContentView: View {
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

struct MealDetailView: View {
    let mealId: String
    @StateObject private var viewModel = MealDetailViewModel()
    
    var body: some View {
        ScrollView {
            if let mealDetail = viewModel.mealDetail {
                VStack(alignment: .leading, spacing: 10) {
                    AsyncImage(url: URL(string: mealDetail.thumbnail)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(maxWidth: .infinity, maxHeight: 200)
                    .cornerRadius(8)
                    
                    Text(mealDetail.name)
                        .font(.largeTitle)
                        .bold()
                    if !mealDetail.youtubeLink.isEmpty {
                        Link("Watch on YouTube", destination: URL(string: mealDetail.youtubeLink)!)
                            .font(.title2)
                            .foregroundColor(.blue)
                            .padding(.vertical)
                    }
                    Text("Instructions")
                        .font(.title2)
                        .bold()
                    
                    Text(mealDetail.instructions)
                        .padding(.bottom)
                    
                    Text("Ingredients")
                        .font(.title2)
                        .bold()
                    
                    ForEach(Array(zip(mealDetail.ingredients, mealDetail.measurements)), id: \.0) { ingredient, measurement in
                        Text("\(ingredient): \(measurement)")
                    }
                }
                .padding()
            } else {
                ProgressView("Loading...")
            }
        }
        .navigationTitle("Dessert Recipe")
        .onAppear {
            viewModel.fetchMealDetail(id: mealId)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
