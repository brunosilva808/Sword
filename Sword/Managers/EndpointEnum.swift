//
//  EndpointEnum.swift
//  Sword
//
//  Created by Bruno Silva on 16/08/2024.
//

import Foundation

enum EndpointEnum {
    private var baseURL: String { return "https://api.thecatapi.com/v1" }
    
    case catImage
    
    private var fullPath: String {
        var endpoint:String
        switch self {
        case .catImage:
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
