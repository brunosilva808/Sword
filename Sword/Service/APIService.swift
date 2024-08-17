//
//  APIService.swift
//  Sword
//
//  Created by Bruno Silva on 16/08/2024.
//

import Foundation

protocol ImageAPIServiceProtocol {
    func fetchImages(_ size: SizeImagesEnum, page: Int, limit: Int) async -> [Cat]
}

// MARK: - APIService

final class APIService {
    
    private let apiManager: APIManagerProtocol
    
    init(apiManager: APIManagerProtocol = APIManager()) {
        self.apiManager = apiManager
    }
}

extension APIService: ImageAPIServiceProtocol {
    
    func fetchImages(_ size: SizeImagesEnum, page: Int, limit: Int) async -> [Cat] {
        do {
            return try await apiManager.downloadAsyncAwait(.catImage(size, page, true, limit),
                                                           type: [Cat].self) ?? []
        } catch {
            print(error.localizedDescription)
        }
        
        return []
    }
}
