//
//  APIManagerUnitTests.swift
//  SwordTests
//
//  Created by Bruno Silva on 19/08/2024.
//

import XCTest

@testable import Sword

final class APIManagerUnitTests: XCTestCase {
    
    func testAPIManagerResponse200() async throws {
        let responseMock = HTTPURLResponse(url: URL(string: "http://www.apple.com")!,
                                           statusCode: 200,
                                           httpVersion: "1.1",
                                           headerFields: nil)!
        
        let catMock = Cat.mockCats
        let encoder = JSONEncoder()
        
        if let data = try? encoder.encode(catMock) {
            let urlSessionMock = URLSessionMock()
            urlSessionMock.data = data
            urlSessionMock.response = responseMock
            let sut = APIManager(session: urlSessionMock)
            let cats = try! await sut.downloadAsyncAwait(EndpointEnum.catImage(.thumb, 1, true, 25), type: [Cat].self)
            XCTAssertEqual(cats, catMock)
        } else {
            XCTFail()
        }
    }
    
    func testAPIManagerResponse400() async throws {

        let responseMock = HTTPURLResponse(url: URL(string: "http://www.apple.com")!,
                                           statusCode: 400,
                                           httpVersion: "1.1",
                                           headerFields: nil)!
        
        let catMock = Cat.mockCats
        let encoder = JSONEncoder()
        
        if let data = try? encoder.encode(catMock) {
            let urlSessionMock = URLSessionMock()
            urlSessionMock.data = data
            urlSessionMock.response = responseMock
            let sut = APIManager(session: urlSessionMock)
            do {
                _ = try await sut.downloadAsyncAwait(EndpointEnum.catImage(.thumb, 1, true, 25), type: Cat.self)
            } catch {
                XCTAssertEqual(400, responseMock.statusCode)
            }
        } else {
            XCTFail()
        }
    }
}
