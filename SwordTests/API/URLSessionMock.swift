//
//  URLSessionMock.swift
//  SwordTests
//
//  Created by Bruno Silva on 19/08/2024.
//

import XCTest

@testable import Sword

class URLSessionMock: APIManagerProtocol {
    
    var data: Data?
    var response: URLResponse?
    var myError: Error?
    
    func data(for request: URLRequest, delegate: (URLSessionTaskDelegate)?) async throws -> (Data, URLResponse) {
        if let data = data, let response = response {
            return (data, response)
        }
        
        return (Data(), URLResponse())
    }
}
