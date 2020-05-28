//
//  DaysWeather+CoreDataProperties.swift
//  
//
//  Created by Alya Filon  on 25.05.2020.
//
//

import Foundation
import CoreData


extension DaysWeather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DaysWeather> {
        return NSFetchRequest<DaysWeather>(entityName: "DaysWeather")
    }

    @NSManaged public var id: String
    @NSManaged public var city: String?
    @NSManaged public var countryCode: String?
    @NSManaged public var days: NSSet?

}

// MARK: Generated accessors for days
extension DaysWeather {

    @objc(addDaysObject:)
    @NSManaged public func addToDays(_ value: DayWeather)

    @objc(removeDaysObject:)
    @NSManaged public func removeFromDays(_ value: DayWeather)

    @objc(addDays:)
    @NSManaged public func addToDays(_ values: NSSet)

    @objc(removeDays:)
    @NSManaged public func removeFromDays(_ values: NSSet)

}
