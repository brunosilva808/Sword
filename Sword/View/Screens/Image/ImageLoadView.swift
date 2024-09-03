//
//  ImageView.swift
//  AsyncImageAPI
//
//  Created by Bruno Silva on 28/08/2024.
//

import SwiftUI

final class ImageLoadViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading = true
    let urlString: String
    let dataService = APIManager()
    
    init(image: UIImage? = nil, urlString: String) {
        self.image = image
        self.urlString = urlString
    }
    
    @MainActor
    func fetchImage() async {
        do {
            image = try await dataService.downloadImage(URL(string: urlString)!)
            isLoading = false
        } catch {
            print(error.localizedDescription)
        }
        
    }
}

struct ImageLoadView: View {
    
    @StateObject var loader: ImageLoadViewModel
    
    init(urlString: String) {
        _loader = StateObject(wrappedValue: ImageLoadViewModel(urlString: urlString))
    }
    
    var body: some View {
        ZStack {
            if loader.isLoading {
                ProgressView()
            } else if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .clipShape(Circle())
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 300, maxHeight: 300)
            }
        }.task {
            await loader.fetchImage()
        }
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageLoadView(urlString: "https://via.placeholder.com/150/d32776")
            .frame(width: 75, height: 75)
            .previewLayout(.sizeThatFits)
    }
}
