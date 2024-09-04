//
//  SwiftUIView.swift
//  Sword
//
//  Created by Bruno Silva on 28/08/2024.
//

import SwiftUI

struct CatRowView: View {
    
    var cat: Cat
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: cat.url)!) { image in
                image
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 100, height: 100)
            } placeholder: {
                ProgressView()
                    .frame(width: 100, height: 100)
            }
        }
    }
}

struct CatRowView_Previews: PreviewProvider {
    static var previews: some View {
        CatRowView(cat: Cat(breeds: [Breed(id: "1", name: "American", temperament: "Soft", origin: "America", description: "It's a cat")], id: "1", url: "https://cdn2.thecatapi.com/images/Hb2N6tYTJ.jpg"))
    }
}
