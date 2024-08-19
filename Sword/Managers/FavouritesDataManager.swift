//
//  FavouritesDataManager.swift
//  Sword
//
//  Created by Bruno Silva on 18/08/2024.
//

import CoreData

protocol FavouritesDataManagerProtocol {
    func saveFavourite(id: String) throws
    func removeFavourite(id: String) throws
    func isFavourite(id: String) throws -> Bool
}

final class FavouritesDataManager {
    
    enum CoreDataError: Error {
        case save
        case read
    }
    
    static let shared = FavouritesDataManager()
    private var favouritesSet = Set<String>()
    private let container: NSPersistentContainer
    private (set) var favouritesEntities: [FavouritesEntity] = []
    
    private init() {
        container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("ERROR LOADING CORE DATA. \(error)")
            }
        }
    }
    
    // MARK: - Generic
    
    private func fetch<T: NSManagedObject>(_ type: T.Type, id: String = "") throws -> [T] {
        let request = T.fetchRequest()
        if !id.isEmpty {
            request.predicate = NSPredicate(format: "id = %@", id as String)
        }
        
        do {
            let entities = try container.viewContext.fetch(request)
            return entities as! [T]
        } catch  {
            return []
        }
    }
    
    private func save() throws {
        do {
            if container.viewContext.hasChanges {
                try container.viewContext.save()
            }
        } catch {
            throw CoreDataError.save
        }
    }
}

extension FavouritesDataManager: FavouritesDataManagerProtocol {
    
    func saveFavourite(id: String) throws {
        do {
            var favouritesEntity: FavouritesEntity
            
            let results = try fetch(FavouritesEntity.self, id: id)
            
            if results.count == 0 {
                // New Entity
                favouritesEntity = FavouritesEntity(context: container.viewContext)
                favouritesEntity.id = id
            }
        } catch {
            throw CoreDataError.read
        }
        
        do {
            _ = try save()
        } catch {
            throw CoreDataError.save
        }
    }
    
    func removeFavourite(id: String) throws {
        for entity in favouritesEntities {
            if entity.id == id {
                container.viewContext.delete(entity)
            }
        }
        
        do {
            _ = try save()
        } catch {
            throw CoreDataError.save
        }
    }
    
    func isFavourite(id: String) throws -> Bool {
        do {
            favouritesEntities = try fetch(FavouritesEntity.self)
        } catch {
            throw CoreDataError.read
        }
            
        for entity in favouritesEntities {
            if entity.id == id {
                return true
            }
        }
        
        return false
    }
}
