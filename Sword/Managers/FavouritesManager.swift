//
//  PersistenceManager.swift
//  Sword
//
//  Created by Bruno Silva on 17/08/2024.
//

import Foundation

protocol FavouritesManagerProtocol {
    func saveFavourite(id: String) throws
    func removeFavourite(id: String) throws
    func isFavourite(id: String) -> Bool
}

final class FavouritesManager {
    
    enum PersistenceErrorEnum: Error {
        case writeError
        case readError
    }
    
    static let shared = FavouritesManager()
    private var favouritesSet = Set<String>()
    private var fileURL: URL = {
        let docDir = try! FileManager.default.url(for: .documentDirectory,
                                                  in: .userDomainMask,
                                                  appropriateFor: nil,
                                                  create: true)
        return docDir.appendingPathComponent("Favourites.plist")
    }()
    
    private init() {
        try? favouritesSet = loadFavourites()
    }
}

extension FavouritesManager: FavouritesManagerProtocol {
    
    func saveFavourite(id: String) throws {
        
        favouritesSet.insert(id)
        
        do {
            try saveFavourites()
        } catch {
            throw PersistenceErrorEnum.writeError
        }
    }
    
    func removeFavourite(id: String) throws {
        do {
            if let index = favouritesSet.firstIndex(of: id) {
                favouritesSet.remove(at: index)
                
                do {
                    try saveFavourites()
                } catch {
                    throw PersistenceErrorEnum.writeError
                }
            }
        } catch {
            throw PersistenceErrorEnum.readError
        }
    }
    
    func isFavourite(id: String) -> Bool {
        return favouritesSet.contains(id)
    }
}

extension FavouritesManager {
    
    private func saveFavourites() throws {
        let data = try PropertyListEncoder().encode(favouritesSet)
        do {
            try data.write(to: self.fileURL, options: [.atomic])
        } catch {
            throw PersistenceErrorEnum.writeError
        }
    }
    
    private func loadFavourites() throws -> Set<String> {
        do {
            let data = try Data(contentsOf: self.fileURL)
            favouritesSet = try PropertyListDecoder().decode(Set<String>.self, from: data)
            return favouritesSet
        } catch {
            throw PersistenceErrorEnum.readError
        }
    }
}
