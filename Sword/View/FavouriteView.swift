//
//  FavouriteView.swift
//  Sword
//
//  Created by Bruno Silva on 18/08/2024.
//

import SwiftUI

final class FavouriteViewModel: ObservableObject {
    let favouritesManager: FavouritesManagerProtocol
    
    init(persistenceManager: FavouritesManagerProtocol = FavouritesManager()) {
        self.favouritesManager = persistenceManager
    }
    
    func saveToFavourites(id: String) {
        try? favouritesManager.saveFavourite(id: id)
    }
    
    func removeFromFavourites(id: String) {
        try? favouritesManager.removeFavourite(id: id)
    }
    
    func isFavourite(id: String) -> Bool {
        favouritesManager.isFavourite(id: id)
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
                    isFavourite = false
                    viewModel.removeFromFavourites(id: cat.id)
                } else {
                    isFavourite = true
                    viewModel.saveToFavourites(id: cat.id)
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
