//
//  UnitTestCoreDataStack.swift
//  SwordTests
//
//  Created by Bruno Silva on 19/08/2024.
//

import CoreData
import XCTest

@testable import Sword

class CoreDataMock: NSObject {
    
    lazy var persistentContainer: NSPersistentContainer = {
        let description = NSPersistentStoreDescription()
        description.url = URL(fileURLWithPath: "dev/null")
        
        let persistentContainer = NSPersistentContainer(name: "DataModel")
        persistentContainer.persistentStoreDescriptions = [description]
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unresolved error \(error.localizedDescription)")
            }
        }
        
        return persistentContainer
    }()
}

