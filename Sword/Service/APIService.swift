//
//  APIService.swift
//  Sword
//
//  Created by Bruno Silva on 16/08/2024.
//

import Foundation

protocol ImageAPIServiceProtocol {
    func fetchImages(_ size: SizeImagesEnum, page: Int) async
}

// MARK: - APIService

final class APIService {
    
    private let apiManager: APIManagerProtocol
    
    init(apiManager: APIManagerProtocol) {
        self.apiManager = apiManager
    }
}

extension APIService: ImageAPIServiceProtocol {
    
    func fetchImages(_ size: SizeImagesEnum, page: Int) async {
        do {
            _ = try await apiManager.downloadAsyncAwait(.catImage(size, page),
                                                        type: [Cat].self)
        } catch {
            print(error.localizedDescription)
        }
    }
}
