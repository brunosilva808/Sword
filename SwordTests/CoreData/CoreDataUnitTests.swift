//
//  CoreDataUnitTests.swift
//  SwordTests
//
//  Created by Bruno Silva on 19/08/2024.
//

import XCTest

@testable import Sword

final class CoreDataUnitTests: XCTestCase {

    func testFetchFavouritesEmpty() throws {
        let persistentContainer = CoreDataMock().persistentContainer
        let coreDataManager = CoreDataManager(persistenceContainer: persistentContainer)
        
        let result = try! coreDataManager.fetchFavourites()
        XCTAssertEqual(result, [])
    }
    
    func testSaveAndFetchFavourites() throws {
        let persistentContainer = CoreDataMock().persistentContainer
        let coreDataManager = CoreDataManager(persistenceContainer: persistentContainer)
        
        for cat in Cat.mockCats {
            try! coreDataManager.saveFavourite(cat: cat)
        }
        
        let result = try! coreDataManager.fetchFavourites()
        XCTAssertEqual(result.count, Cat.mockCats.count)
    }
    
    func testSaveFetchAndDeleteFavourites() throws {
        let persistentContainer = CoreDataMock().persistentContainer
        let coreDataManager = CoreDataManager(persistenceContainer: persistentContainer)
        
        for cat in Cat.mockCats {
            try! coreDataManager.saveFavourite(cat: cat)
        }
        
        let result1 = try! coreDataManager.fetchFavourites()
        XCTAssertEqual(result1.count, Cat.mockCats.count)
        
        for cat in Cat.mockCats {
            try! coreDataManager.removeFavourite(id: cat.id)
        }
        
        let result2 = try! coreDataManager.fetchFavourites()
        XCTAssertEqual(result2, [])
    }
}
