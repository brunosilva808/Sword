//
//  DataController.swift
//  Sword
//
//  Created by Bruno Silva on 19/08/2024.
//

import CoreData
import Foundation

class CoreDataProvider {
    
    static let shared = CoreDataProvider()
    let persistenceContainer: NSPersistentContainer
    
    private init() {
        persistenceContainer = NSPersistentContainer(name: "DataModel")
        persistenceContainer.loadPersistentStores { description, error in
        if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
