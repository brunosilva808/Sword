//
//  DescriptionView.swift
//  Sword
//
//  Created by Bruno Silva on 18/08/2024.
//

import SwiftUI

struct DescriptionView: View {
    var cat: Cat
    
    var body: some View {
        VStack {
            HStack {
                Text("Origin: ")
                Spacer()
                Text(cat.origin)
            }
            HStack {
                Text("Temperament: ")
                Spacer()
                Text(cat.temperament)
            }
            HStack {
                Text("Breed: ")
                Spacer()
                Text(cat.breedName)
            }
            HStack {
                Text("Description: ")
                Spacer()
                Text(cat.description)
            }
        }
    }
}

struct DescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        DescriptionView(cat: Cat(breeds: [Breed(id: "1", name: "American", temperament: "Soft", origin: "America", description: "It's a cat")], id: "1", url: "https://cdn2.thecatapi.com/images/Hb2N6tYTJ.jpg"))
    }
}
