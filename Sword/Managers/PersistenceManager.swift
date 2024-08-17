//
//  PersistenceManager.swift
//  Sword
//
//  Created by Bruno Silva on 17/08/2024.
//

import Foundation

protocol PersistenceManagerProtocol {
    func saveFavourite(id: String) throws
    func removeFavourite(id: String) throws
}

final class PersistenceManager {
    
    enum PersistenceErrorEnum: Error {
        case writeError
        case readError
    }
    
    let shared = PersistenceManager()
    private var favouritesArray = [String]()
    private var fileURL: URL = {
        let docDir = try! FileManager.default.url(for: .documentDirectory,
                                                  in: .userDomainMask,
                                                  appropriateFor: nil,
                                                  create: true)
        return docDir.appendingPathComponent("Favourites.plist")
    }()
    
    private init() {
        try? favouritesArray = loadFavourites()
    }
}

extension PersistenceManager: PersistenceManagerProtocol {
    
    func saveFavourite(id: String) throws {
        
        favouritesArray.append(id)
        
        do {
            try saveFavourites()
        } catch {
            throw PersistenceErrorEnum.writeError
        }
    }
    
    func removeFavourite(id: String) throws {
        do {
            if let index = favouritesArray.firstIndex(of: id) {
                favouritesArray.remove(at: index)
                
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
}

extension PersistenceManager {
    
    private func saveFavourites() throws {
        let data = try PropertyListEncoder().encode(favouritesArray)
        do {
            try data.write(to: self.fileURL, options: [.atomic])
        } catch {
            throw PersistenceErrorEnum.writeError
        }
    }
    
    private func loadFavourites() throws -> [String] {
        do {
            let data = try Data(contentsOf: self.fileURL)
            favouritesArray = try PropertyListDecoder().decode(Array<String>.self, from: data)
            return favouritesArray
        } catch {
            throw PersistenceErrorEnum.readError
        }
    }
}
