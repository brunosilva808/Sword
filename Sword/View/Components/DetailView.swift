//
//  DetailView.swift
//  Sword
//
//  Created by Bruno Silva on 18/08/2024.
//

import SwiftUI

struct DetailView: View {

    @EnvironmentObject var coreDataManager: CoreDataManager
    var cat: Cat
    
    var body: some View {
        ScrollView {
            VStack (alignment: .leading) {
                HStack {
                    Text(cat.breedName)
                        .font(.title)
                    Spacer()
                    FavouriteView(cat: cat)
                        .environmentObject(coreDataManager)
                }
                .padding(20)
                
                DescriptionView(cat: cat)
                .padding(20)
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(cat: Cat(breeds: [Breed(id: "1", name: "American", temperament: "Soft", origin: "America", description: "It's a cat")], id: "1", url: "https://cdn2.thecatapi.com/images/Hb2N6tYTJ.jpg"))
    }
}
