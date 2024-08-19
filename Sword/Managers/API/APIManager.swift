//
//  APIManager.swift
//  Sword
//
//  Created by Bruno Silva on 16/08/2024.
//

import Foundation


protocol APIManagerProtocol {
    func downloadAsyncAwait<T: Codable>(_ endpointEnum: EndpointEnum, type: T.Type) async throws -> T?
}

enum APIManagerError: Error {
    case httpStatus
    case decoding
}

final class APIManager: APIManagerProtocol {
    
    private var apiKey = "live_B9KDr9FSstkoz46NLyxZ1FoFhHKhUsXUxFTBZR2ZiO3lbZpoRjFxz6WEOLBERjLG"

    private let session: URLSession
    private let decoder = JSONDecoder()

    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func downloadAsyncAwait<T: Codable>(_ endpointEnum: EndpointEnum, type: T.Type) async throws -> T? {
        let request = NSMutableURLRequest(url: endpointEnum.url)
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
        request.httpMethod = "GET"
        
        do {
            let (data, response) = try await session.data(for: request as URLRequest,
                                                          delegate: nil)
            guard let response = response as? HTTPURLResponse,
                  response.statusCode >= 200 && response.statusCode < 300 else {

                print("*** APIManagerError.httpStatus ***")
                throw APIManagerError.httpStatus
            }
            
            let result = try decoder.decode(type, from: data)
            return result
        } catch  {
            throw APIManagerError.decoding
        }
    }
}
