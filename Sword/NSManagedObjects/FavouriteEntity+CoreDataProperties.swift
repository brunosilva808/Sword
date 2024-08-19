//
//  FavouriteEntity+CoreDataProperties.swift
//  Sword
//
//  Created by Bruno Silva on 19/08/2024.
//
//

import Foundation
import CoreData


extension FavouriteEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavouriteEntity> {
        return NSFetchRequest<FavouriteEntity>(entityName: "FavouriteEntity")
    }

    @NSManaged public var id: String?
    @NSManaged public var url: String?
    @NSManaged public var breedsRelationship: NSSet?

}

// MARK: Generated accessors for breedsRelationship
extension FavouriteEntity {

    @objc(addBreedsRelationshipObject:)
    @NSManaged public func addToBreedsRelationship(_ value: BreedEntity)

    @objc(removeBreedsRelationshipObject:)
    @NSManaged public func removeFromBreedsRelationship(_ value: BreedEntity)

    @objc(addBreedsRelationship:)
    @NSManaged public func addToBreedsRelationship(_ values: NSSet)

    @objc(removeBreedsRelationship:)
    @NSManaged public func removeFromBreedsRelationship(_ values: NSSet)

}

extension FavouriteEntity : Identifiable {

}
