//
//  EndpointEnum.swift
//  Sword
//
//  Created by Bruno Silva on 16/08/2024.
//

import Foundation

enum SizeImagesEnum: String {
    case thumb
}

enum EndpointEnum {
    private var baseURL: String { return "https://api.thecatapi.com/v1" }
    
    case catImage(SizeImagesEnum, Int)
    
    private var fullPath: String {
        var endpoint: String
        
        switch self {
        case .catImage(let size, let page):
            
            let queryItems = [
                URLQueryItem(name: "size", value: size.rawValue),
                URLQueryItem(name: "page", value: "\(page)")]
            var urlComps = URLComponents(string: baseURL)!
            urlComps.queryItems = queryItems
            let result = urlComps.url!
            
            endpoint = "/images/search"
        }
        
        return baseURL + endpoint
    }
    
    var url: URL {
        guard let url = URL(string: fullPath) else {
            preconditionFailure("The url used in \(EndpointEnum.self) is not valid")
        }
        return url
    }
}
