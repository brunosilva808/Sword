//
//  FavouriteView.swift
//  Sword
//
//  Created by Bruno Silva on 18/08/2024.
//

import SwiftUI

final class FavouriteViewModel: ObservableObject {
    let favouritesManager: FavouritesDataManagerProtocol
    
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
}

struct FavouriteView: View {
    @StateObject private var viewModel = FavouriteViewModel()
    var cat: Cat
    @State var isFavourite = false
    
    var body: some View {
        HStack {
            Button(action: {
                if viewModel.isFavourite(id: cat.id) {
                    isFavourite = !viewModel.removeFromFavourites(id: cat.id)
                } else {
                    isFavourite = viewModel.saveToFavourites(id: cat.id)
                }
            }) {
                Image(systemName: self.isFavourite == true ? "star.fill" : "star")
            }
        }
    }
}

struct FavouriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteView(cat: Cat(breeds: [], id: "xpto", url: "https://cdn2.thecatapi.com/images/Hb2N6tYTJ.jpg", width: 100, height: 100))
    }
}
