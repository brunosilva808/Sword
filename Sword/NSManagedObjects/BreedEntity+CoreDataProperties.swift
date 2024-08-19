//
//  BreedEntity+CoreDataProperties.swift
//  Sword
//
//  Created by Bruno Silva on 19/08/2024.
//
//

import Foundation
import CoreData


extension BreedEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BreedEntity> {
        return NSFetchRequest<BreedEntity>(entityName: "BreedEntity")
    }

    @NSManaged public var descriptionValue: String?
    @NSManaged public var id: String?
    @NSManaged public var origin: String?
    @NSManaged public var temperament: String?
    @NSManaged public var name: String?
    @NSManaged public var favouriteRelationship: FavouriteEntity?

}

extension BreedEntity : Identifiable {

}
