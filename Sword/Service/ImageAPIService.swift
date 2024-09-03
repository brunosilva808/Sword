//
//  ImageService.swift
//  Bliss
//
//  Created by Bruno Silva on 23/11/2023.
//

import SwiftUI

protocol ImageCatAPIServiceProtocol {
    func fetchImage(_ urlString: String) async throws -> UIImage?
//    func fetchEmojisImages(_ page: Int) async -> [UIImage]
//    func fetchRandomImage(_ type: ImageType) async -> UIImage?
}

final class ImageAPIService {
    
    private let imageManager: APIManager
    private let coreDataManager: CoreDataManager
    
    init(imageManager: APIManager = APIManager(),
         coreDataManager: CoreDataManager = CoreDataManager()) {
        self.imageManager = imageManager
        self.coreDataManager = coreDataManager
    }
}

extension ImageAPIService: ImageCatAPIServiceProtocol {
    
    func fetchImage(_ urlString: String) async throws -> UIImage? {
//        do {
//            if let image = coreDataManager.imageDataAvatar(username) {
//                return UIImage(data: image)
//            } else {
                    
        let imageTmp = try await imageManager.downloadImage(URL(string: urlString)!)
//                if let data = imageTmp?.pngData() {
//                    coreDataManager.addAvatar(username, data: data)
//                }
                    
                return imageTmp
//            }
//        } catch {
//            print("No user found")
//        }
        
        return nil
    }
    
//    func fetchRandomImage(_ type: ImageType) async -> UIImage? {
//
//        if let data = coreDataManager.randomImageData(type) {
//            return UIImage(data: data)
//        }
//
//        if let urlString = coreDataManager.randomImageURL(type), let url = URL(string: urlString) {
//            let image = await imageManager.downloadAsyncAwait(url)
//
//            if let data = image?.pngData() {
//                coreDataManager.addAvatar(url.absoluteString, data: data)
//            }
//
//
//            return image
//        }
//
//        return nil
//    }
    
//    func fetchEmojisImages(_ page: Int) async -> [UIImage] {
//        let emojisDictionary = coreDataManager.fetchEmojisDictionary(page)
//        var imagesArray: [UIImage] = []
//
//        for urlString in emojisDictionary.values {
//
//            guard !Task.isCancelled else { return [] }
//
//            if let data = coreDataManager.imageDataAvatar(urlString),
//               let image = UIImage(data: data) {
//
//                imagesArray.append(image)
//
//            } else if let url = URL(string: urlString),
//               let image = await imageManager.downloadAsyncAwait(url),
//               let data = image.pngData() {
//
//                print(urlString)
//
//                coreDataManager.addEmoji(urlString, data: data)
//                imagesArray.append(image)
//            }
//        }
//
//        print("END **********")
//        return imagesArray
//    }
}
