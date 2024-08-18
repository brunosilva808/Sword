//
//  CatView.swift
//  Sword
//
//  Created by Bruno Silva on 16/08/2024.
//

import SwiftUI

struct CatView: View {
    
    var cat: Cat
    @State var isFavourite = false
    
    var body: some View {
            VStack {
                AsyncImage(url: URL(string: cat.url)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 300, maxHeight: 100)
                    case .failure:
                        Image(systemName: "photo")
                    @unknown default:
                        EmptyView()
                    }
                }
                HStack {
                    Text(cat.breedName)
                    FavouriteView(cat: cat)
                }
            }
        }
}

struct CatView_Previews: PreviewProvider {
    static var previews: some View {
        CatView(cat: Cat(breeds: [], id: "xpto", url: "https://cdn2.thecatapi.com/images/Hb2N6tYTJ.jpg", width: 100, height: 100))
    }
}
