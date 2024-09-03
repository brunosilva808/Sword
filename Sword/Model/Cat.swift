//
//  Cat.swift
//  Sword
//
//  Created by Bruno Silva on 16/08/2024.
//

import Foundation

struct Cat: Identifiable, Codable, Equatable {
    var breeds: [Breed]
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
struct Breed: Codable, Equatable {
    let id: String
    let name: String
    let temperament: String
    let origin: String
    let description: String
}

extension Cat {
    static let mockCats = [
        Cat(breeds: [Breed(id: "1", name: "American", temperament: "Soft", origin: "America", description: "It's a cat")], id: "1", url: "https://cdn2.thecatapi.com/images/Hb2N6tYTJ.jpg"),
        Cat(breeds: [Breed(id: "2", name: "Abyssinian", temperament: "Medium", origin: "Abyssinian", description: "It's a cat")], id: "2", url: "https://cdn2.thecatapi.com/images/Hb2N6tYTJ.jpg"),
        Cat(breeds: [Breed(id: "3", name: "Balinese", temperament: "Hard", origin: "Balinese", description: "It's a cat")], id: "3", url: "https://cdn2.thecatapi.com/images/Hb2N6tYTJ.jpg")]
}
