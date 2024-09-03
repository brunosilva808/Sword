//
//  ImageManager.swift
//  Bliss
//
//  Created by Bruno Silva on 30/10/2023.
//

import SwiftUI

protocol ImageManagerProtocol {
    func downloadAsyncAwait(_ url: URL) async -> UIImage?
}

class ImageManager: ImageManagerProtocol {
    
    private func handleData(data: Data?, response: URLResponse?) -> UIImage? {
        guard let data = data,
              let image = UIImage(data: data) else {
            
            return nil
        }
        
        return image
    }
    
    func downloadAsyncAwait(_ url: URL) async -> UIImage? {
        
        let request = URLRequest(url: url)
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            return handleData(data: data, response: response)
        } catch  {
            print("Error downloading image: \(error)")
        }
        
        return nil
    }
}
