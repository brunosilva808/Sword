//
//  APIManager.swift
//  Sword
//
//  Created by Bruno Silva on 16/08/2024.
//

import Foundation
import SwiftUI

protocol APIManagerProtocol {
    func data(for request: URLRequest, delegate: (URLSessionTaskDelegate)?) async throws -> (Data, URLResponse)
}

extension URLSession: APIManagerProtocol {}

enum APIManagerError: Error {
    case httpStatus
    case decoding
    case image
}

final class APIManager {
    
    private var apiKey = "live_B9KDr9FSstkoz46NLyxZ1FoFhHKhUsXUxFTBZR2ZiO3lbZpoRjFxz6WEOLBERjLG"
    
    private let session: APIManagerProtocol
    private let decoder = JSONDecoder()
    
    init(session: APIManagerProtocol = URLSession.shared) {
        self.session = session
    }
}

extension APIManager {
    
    private func handleResponse(_ response: URLResponse) throws {
        guard let response = response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw APIManagerError.httpStatus
        }
    }
    
    func downloadAsyncAwait<T: Codable>(_ endpointEnum: EndpointEnum, type: T.Type) async throws -> T? {
        let request = NSMutableURLRequest(url: endpointEnum.url)
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
        request.httpMethod = "GET"
        
        do {
            let (data, response) = try await session.data(for: request as URLRequest, delegate: nil)
            try handleResponse(response)
            
            let result = try decoder.decode(type, from: data)
            return result
        } catch  {
            throw APIManagerError.decoding
        }
    }
    
    func downloadImage(_ url: URL) async throws -> UIImage? {
        
        let request = URLRequest(url: url)
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            try handleResponse(response)
            
            return UIImage(data: data)
        } catch  {
            throw APIManagerError.image
        }
    }
}
