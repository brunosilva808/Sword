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
    
    init(persistenceManager: FavouritesDataManagerProtocol = FavouritesDataManager.shared) {
        self.favouritesManager = persistenceManager
    }
    
    func saveToFavourites(id: String) -> Bool {
        do {
            try favouritesManager.saveFavourite(id: id)
            return true
        } catch {
            return false
        }
    }
    
    func removeFromFavourites(id: String) -> Bool {
        do {
        try favouritesManager.removeFavourite(id: id)
            return true
        } catch {
            return false
        }
    }
    
    func isFavourite(id: String) -> Bool {
        do {
            let result = try favouritesManager.isFavourite(id: id)
            return result
        } catch {
            return false
        }
    }
    
    func checkIfItsFavourite(id: String) {
        print(isFavourite)
        isFavourite = isFavourite(id: id)
        print(isFavourite)
    }
}

struct FavouriteView: View {
    @StateObject private var viewModel = FavouriteViewModel()
    var cat: Cat
    
    var body: some View {
        HStack {
            Button(action: {
                if viewModel.isFavourite(id: cat.id) {
                    viewModel.isFavourite = !viewModel.removeFromFavourites(id: cat.id)
                } else {
                    viewModel.isFavourite = viewModel.saveToFavourites(id: cat.id)
                }
            }) {
                Image(systemName: viewModel.isFavourite == true ? "star.fill" : "star")
            }
        }
        .onAppear {
            viewModel.checkIfItsFavourite(id: cat.id)
            print(cat.breedName)
        }
    }
}

struct FavouriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteView(cat: Cat(breeds: [], id: "xpto", url: "https://cdn2.thecatapi.com/images/Hb2N6tYTJ.jpg", width: 100, height: 100))
    }
}
