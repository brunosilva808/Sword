//
//  FavouriteView.swift
//  Sword
//
//  Created by Bruno Silva on 18/08/2024.
//

import SwiftUI

final class FavouriteViewModel: ObservableObject {
    private let favouritesManager: FavouritesDataManagerProtocol
    @Published var isFavourite = false
    
    init(persistenceManager: FavouritesDataManagerProtocol = CoreDataManager()) {
        self.favouritesManager = persistenceManager
    }
    
    func isFavourite(id: String) {
        do {
            isFavourite = try favouritesManager.isFavourite(id: id)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func toogleFavourite(cat: Cat) {
        do {
            if try favouritesManager.isFavourite(id: cat.id) {
                try favouritesManager.removeFavourite(id: cat.id)
                isFavourite = false
            } else {
                try favouritesManager.saveFavourite(cat: cat)
                isFavourite = true
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct FavouriteView: View {
    @StateObject private var viewModel = FavouriteViewModel()
    var cat: Cat
    
    var body: some View {
        HStack {
            Button(action: {
                viewModel.toogleFavourite(cat: cat)
            }) {
                Image(systemName: viewModel.isFavourite == true ? "star.fill" : "star")
            }
        }
        .onAppear {
            viewModel.isFavourite(id: cat.id)
        }
    }
}

struct FavouriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteView(cat: Cat(breeds: [Breed(id: "1", name: "American", temperament: "Soft", origin: "America", description: "It's a cat")], id: "1", url: "https://cdn2.thecatapi.com/images/Hb2N6tYTJ.jpg"))
    }
}
