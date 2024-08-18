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
    
    func isFavourite(id: String) {
        do {
            isFavourite = try favouritesManager.isFavourite(id: id)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func toogleFavourite(id: String) {
        do {
            if try favouritesManager.isFavourite(id: id) {
                try favouritesManager.removeFavourite(id: id)
                isFavourite = false
            } else {
                try favouritesManager.saveFavourite(id: id)
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
                viewModel.toogleFavourite(id: cat.id)
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
        FavouriteView(cat: Cat(breeds: [], id: "xpto", url: "https://cdn2.thecatapi.com/images/Hb2N6tYTJ.jpg", width: 100, height: 100))
    }
}
