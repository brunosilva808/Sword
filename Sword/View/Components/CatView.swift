//
//  CatView.swift
//  Sword
//
//  Created by Bruno Silva on 16/08/2024.
//

import SwiftUI

final class CatViewModel: ObservableObject {
    
    var imageAPIService: ImageAPIService
    @Published var image: UIImage
    
    init(imageAPIService: ImageAPIService = ImageAPIService()) {
        self.imageAPIService = imageAPIService
        self.image = UIImage()
    }
    
    func setup(_ coreData: CoreDataManager) {
        
    }
    
    @MainActor
    func loadImage(_ urlString: String) async {
        do {
            if let imageTmp = try await imageAPIService.fetchImage(urlString) {
                image = imageTmp
            } else {
                image = UIImage(systemName: "photo")!
            }
        } catch {
            image = UIImage(systemName: "photo")!
        }
    }
}

struct CatView: View {
    
    @StateObject var viewModel = CatViewModel()
    @EnvironmentObject var coreDataManager: CoreDataManager
    var cat: Cat
    
    var body: some View {
            VStack {
//                AsyncImage(url: URL(string: cat.url)) { phase in
//                    switch phase {
//                    case .empty:
//                        ProgressView()
//                    case .success(let image):
//                        image.resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .frame(maxWidth: 300, maxHeight: 100)
//                    case .failure:
//                        Image(systemName: "photo")
//                    @unknown default:
//                        EmptyView()
//                    }
//                }
                Image(uiImage: viewModel.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 300, maxHeight: 300)
                HStack {
                    Text(cat.breedName)
                    FavouriteView(cat: cat)
                        .environmentObject(coreDataManager)
                }
            }.onAppear {
                viewModel.setup(coreDataManager)
                Task {
                    await viewModel.loadImage(cat.url)
                }
            }
        }
}

struct CatView_Previews: PreviewProvider {
    static var previews: some View {
        CatView(cat: Cat(breeds: [Breed(id: "1", name: "American", temperament: "Soft", origin: "America", description: "It's a cat")], id: "1", url: "https://cdn2.thecatapi.com/images/Hb2N6tYTJ.jpg"))
    }
}
