//
//  Condition+CoreDataProperties.swift
//  
//
//  Created by Alya Filon  on 25.05.2020.
//
//

import Foundation
import CoreData


extension Condition {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Condition> {
        return NSFetchRequest<Condition>(entityName: "Condition")
    }

    @NSManaged public var id: String
    @NSManaged public var iconCode: String?
    @NSManaged public var weatherDescription: String?
    @NSManaged public var weather: Weather?
    @NSManaged public var dayWeather: DayWeather?

}
