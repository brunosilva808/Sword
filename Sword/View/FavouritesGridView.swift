//
//  FavouritesGridView.swift
//  Sword
//
//  Created by Bruno Silva on 19/08/2024.
//

import SwiftUI

final class FavouritesGridViewModel: ObservableObject {
    
    private let favouritesManager: FavouritesDataManagerProtocol
    @Published var favouritesArray: [Cat] = []
    
    init(favouritesManager: FavouritesDataManagerProtocol = CoreDataManager()) {
        self.favouritesManager = favouritesManager
    }
    
    func fetchFavourites() {
        var favouristeTmpArray: [Cat] = []
        
        do {
            let entities = try favouritesManager.fetchFavourites()
            entities.forEach { favouriteEntity in
                var favourite = Cat(breeds: [],
                                    id: favouriteEntity.id ?? "",
                                    url: favouriteEntity.url ?? "")
                let set = favouriteEntity.breedsRelationship!
                var array: [Breed] = []

                for item in set {
                    if let item = item as? BreedEntity {
                        if let id = item.id,
                           let name = item.name,
                           let temperament = item.temperament,
                           let origin = item.origin,
                           let description = item.descriptionValue {

                            let breed = Breed(id: id,
                                              name: name,
                                              temperament: temperament,
                                              origin: origin,
                                              description: description)
                            array.append(breed)
                        }
                    }
                    
                    break
                }
                
                favourite.breeds = array
                favouristeTmpArray.append(favourite)
            }
        } catch {
            print(error.localizedDescription)
        }
        
        favouritesArray = favouristeTmpArray
    }
}

struct FavouritesGridView: View {
    
    @StateObject var viewModel = FavouritesGridViewModel()
    private let columns = [ GridItem(.adaptive(minimum: 100)) ]
    
    var body: some View {
        NavigationStack{
                ScrollView{
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(viewModel.favouritesArray, id: \.id) { cat in
                            NavigationLink(destination: DetailView(cat: cat)) {
                                CatView(cat: cat)
                            }
                        }
                    }
                } .padding()
            .onAppear {
                viewModel.fetchFavourites()
            }
        }
    }
}

struct FavouritesGridView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesGridView()
    }
}
