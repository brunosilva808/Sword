//
//  FavouritesDataManager.swift
//  Sword
//
//  Created by Bruno Silva on 18/08/2024.
//

import CoreData

protocol FavouritesDataManagerProtocol {
    func saveFavourite(cat: Cat) throws
    func removeFavourite(id: String) throws
    func isFavourite(id: String) throws -> Bool
    func fetchFavourites() throws -> [FavouriteEntity]
}

final class FavouritesDataManager {
    
    enum CoreDataError: Error {
        case save
        case read
    }
    
    static let shared = FavouritesDataManager()
    private var favouritesSet = Set<String>()
    private let container: NSPersistentContainer
    private var favouritesEntities: [FavouriteEntity] = []
    
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
  
    func saveFavourite(cat: Cat) throws {
        if let breed = cat.breeds.first {
            let breedEntity = BreedEntity(context: container.viewContext)
            breedEntity.id = breed.id
            breedEntity.name = breed.name
            breedEntity.origin = breed.origin
            breedEntity.descriptionValue = breed.description
            breedEntity.temperament = breed.temperament
            
            let favouriteEntity = FavouriteEntity(context: container.viewContext)
            favouriteEntity.id = cat.id
            favouriteEntity.url = cat.url
            
            favouriteEntity.addToBreedsRelationship(breedEntity)
            
            do {
                _ = try save()
            } catch {
                throw CoreDataError.save
            }
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
            favouritesEntities = try fetch(FavouriteEntity.self)
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
    
    func fetchFavourites() throws -> [FavouriteEntity] {
        do {
            favouritesEntities = try fetch(FavouriteEntity.self)
            return favouritesEntities
        } catch {
            throw CoreDataError.read
        }
    }
}
