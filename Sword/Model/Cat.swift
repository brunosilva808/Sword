//
//  Cat.swift
//  Sword
//
//  Created by Bruno Silva on 16/08/2024.
//

import Foundation

struct Cat: Codable {
    let breeds: [Breed]
    let id: String
    let url: String
}

extension Cat {
    var breedName: String {
        if let breed = breeds.first {
            return breed.name
        } else {
            return ""
        }
    }
    
    var temperament: String {
        if let breed = breeds.first {
            return breed.temperament
        } else {
            return ""
        }
    }
    
    var origin: String {
        if let breed = breeds.first {
            return breed.origin
        } else {
            return ""
        }
    }
    
    var description: String {
        if let breed = breeds.first {
            return breed.description
        } else {
            return ""
        }
    }
}

// MARK: - Breed
struct Breed: Codable {
    let id: String
    let name: String
    let temperament: String
    let origin: String
    let description: String
}
