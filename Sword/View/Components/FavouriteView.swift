//
//  FavouriteView.swift
//  Sword
//
//  Created by Bruno Silva on 18/08/2024.
//

import SwiftUI

final class FavouriteViewModel: ObservableObject {
    var coreDataManager: CoreDataManager?
    @Published var isFavourite = false
    
    func setup(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }
    
    func isFavourite(id: String) {
        do {
            isFavourite = try coreDataManager?.isFavourite(id: id) ?? false
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func toogleFavourite(cat: Cat) {
        do {
            guard let coreDataManager = coreDataManager  else { return }
            
            if try coreDataManager.isFavourite(id: cat.id) {
                try coreDataManager.removeFavourite(id: cat.id)
                isFavourite = false
            } else {
                try coreDataManager.saveFavourite(cat: cat)
                isFavourite = true
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct FavouriteView: View {
    @StateObject private var viewModel = FavouriteViewModel()
    @EnvironmentObject var coreDataManager: CoreDataManager
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
            viewModel.setup(coreDataManager: coreDataManager)
            viewModel.isFavourite(id: cat.id)
        }
    }
}

struct FavouriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteView(
            cat: Cat(breeds: [Breed(id: "1", name: "American", temperament: "Soft", origin: "America", description: "It's a cat")], id: "1", url: "https://cdn2.thecatapi.com/images/Hb2N6tYTJ.jpg"))
    }
}
