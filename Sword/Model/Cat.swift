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
    let width, height: Int
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
//    let weight: Weight
    let id, name: String
//    let vetstreetURL: String?
    let temperament, origin, description: String
//    let countryCodes, countryCode: String
//    let lifeSpan: String
//    let indoor: Int
//    let altNames: AltNames?
//    let adaptability, affectionLevel, childFriendly, dogFriendly: Int
//    let energyLevel, grooming, healthIssues, intelligence: Int
//    let sheddingLevel, socialNeeds, strangerFriendly, vocalisation: Int
//    let experimental, hairless, natural, rare: Int
//    let rex, suppressedTail, shortLegs: Int
//    let wikipediaURL: String
//    let hypoallergenic: Int
//    let referenceImageID: String
//    let cfaURL: String?
//    let vcahospitalsURL: String?
//    let lap: Int?

//    enum CodingKeys: String, CodingKey {
//        case weight, id, name
//        case vetstreetURL = "vetstreet_url"
//        case temperament, origin
//        case countryCodes = "country_codes"
//        case countryCode = "country_code"
//        case description
//        case lifeSpan = "life_span"
//        case indoor
//        case altNames = "alt_names"
//        case adaptability
//        case affectionLevel = "affection_level"
//        case childFriendly = "child_friendly"
//        case dogFriendly = "dog_friendly"
//        case energyLevel = "energy_level"
//        case grooming
//        case healthIssues = "health_issues"
//        case intelligence
//        case sheddingLevel = "shedding_level"
//        case socialNeeds = "social_needs"
//        case strangerFriendly = "stranger_friendly"
//        case vocalisation, experimental, hairless, natural, rare, rex
//        case suppressedTail = "suppressed_tail"
//        case shortLegs = "short_legs"
//        case wikipediaURL = "wikipedia_url"
//        case hypoallergenic
//        case referenceImageID = "reference_image_id"
//        case cfaURL = "cfa_url"
//        case vcahospitalsURL = "vcahospitals_url"
//        case lap
//    }
}

enum AltNames: String, Codable {
    case empty = ""
    case moscowSemiLonghairHairSiberianForestCat = "Moscow Semi-longhair, HairSiberian Forest Cat"
    case turkishCatSwimmingCat = "Turkish Cat, Swimming cat"
    case york = "York"
}

// MARK: - Weight
struct Weight: Codable {
    let imperial: String
    let metric: Metric
}

enum Metric: String, Codable {
    case the35 = "3 - 5"
    case the39 = "3 - 9"
    case the47 = "4 - 7"
    case the58 = "5 - 8"
}
