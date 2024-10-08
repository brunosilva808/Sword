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

final class CoreDataManager {
    
    enum CoreDataError: Error {
        case save
        case read
    }
    
    private var favouritesSet = Set<String>()
    private var persistenceContainer: NSPersistentContainer
    private var favouritesEntities: [FavouriteEntity] = []
    
    init(persistenceContainer: NSPersistentContainer = CoreDataProvider.shared.persistenceContainer) {
        self.persistenceContainer = persistenceContainer
    }
    
    // MARK: - Generic
    
    private func fetch<T: NSManagedObject>(_ type: T.Type, id: String = "") throws -> [T] {
        let request = T.fetchRequest()
        if !id.isEmpty {
            request.predicate = NSPredicate(format: "id = %@", id as String)
        }
        
        do {
            let entities = try persistenceContainer.viewContext.fetch(request)
            return entities as! [T]
        } catch  {
            return []
        }
    }
    
    private func save() throws {
        do {
            if persistenceContainer.viewContext.hasChanges {
                try persistenceContainer.viewContext.save()
            }
        } catch {
            throw CoreDataError.save
        }
    }
}

extension CoreDataManager: FavouritesDataManagerProtocol {
  
    func saveFavourite(cat: Cat) throws {
        if let breed = cat.breeds.first {
            let breedEntity = BreedEntity(context: persistenceContainer.viewContext)
            breedEntity.id = breed.id
            breedEntity.name = breed.name
            breedEntity.origin = breed.origin
            breedEntity.descriptionValue = breed.description
            breedEntity.temperament = breed.temperament
            
            let favouriteEntity = FavouriteEntity(context: persistenceContainer.viewContext)
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
                persistenceContainer.viewContext.delete(entity)
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
