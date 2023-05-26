//
//  Searches+CoreDataProperties.swift
//  MoviesAPI
//
//  Created by user232105 on 2023-04-19.
//
//

import Foundation
import CoreData


extension Searches {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Searches> {
        return NSFetchRequest<Searches>(entityName: "Searches")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var search: String?
    @NSManaged public var date: Date?
    @NSManaged public var result: Int64

}

extension Searches : Identifiable {

}
