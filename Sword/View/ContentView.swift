//
//  ContentView.swift
//  Sword
//
//  Created by Bruno Silva on 16/08/2024.
//

import SwiftUI

// Cache global para armazenar imagens já carregadas
class ImageCache {
    static let shared = NSCache<NSString, UIImage>()
}

final class ViewModel: ObservableObject {
    private let apiService: APIService
    private var page = 0
    @Published var catsArray: [Cat] = []
    @Published var searchTerm = ""
    
    var filteredCatsArray: [Cat] {
        guard !searchTerm.isEmpty else { return catsArray }
        return catsArray.filter { $0.breedName.localizedCaseInsensitiveContains(searchTerm) }
    }
    
    func isLastCat(id: String) -> Bool {
        return catsArray.last?.id == id
    }
    
    init(apiService: APIService = APIService()) {
        self.apiService = apiService
    }
    
    @MainActor
    func fetchCats() async {
        catsArray.append(contentsOf: await apiService.fetchImages(.thumb, page: page, limit: 25))
        page += 1
    }
}

struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()
    private let columns = [ GridItem(.adaptive(minimum: 100)) ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(viewModel.filteredCatsArray, id: \.id) { cat in
                        VStack {
                            CatImageView(url: cat.url) // Substituído pela nova CatImageView
                            Text(cat.breedName)
                        }
                        .onAppear {
                            if viewModel.isLastCat(id: cat.id) {
                                Task {
                                    await viewModel.fetchCats()
                                }
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Cats")
            .onAppear {
                Task {
                    await viewModel.fetchCats()
                }
            }
        }
    }
}

struct CatImageView: View {
    let url: String

    var body: some View {
        if let cachedImage = ImageCache.shared.object(forKey: url as NSString) {
            // Se a imagem estiver no cache, exiba-a diretamente
            Image(uiImage: cachedImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .clipped()
        } else {
            // Caso contrário, use AsyncImage para carregar e armazenar no cache
            AsyncImage(url: URL(string: url)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipped()
                        .onAppear {
                            // Armazene a imagem no cache ao carregá-la
                            ImageCache.shared.setObject(image.asUIImage(), forKey: url as NSString)
                        }
                } else if phase.error != nil {
                    Color.red.frame(width: 100, height: 100) // Error placeholder
                } else {
                    ProgressView().frame(width: 100, height: 100) // Loading placeholder
                }
            }
        }
    }
}

extension Image {
    // Função auxiliar para converter uma `Image` SwiftUI para `UIImage`
    func asUIImage() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view

        let targetSize = CGSize(width: 100, height: 100)
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: targetSize)
        return renderer.image { _ in
            view?.drawHierarchy(in: view!.bounds, afterScreenUpdates: true)
        }
    }
}
