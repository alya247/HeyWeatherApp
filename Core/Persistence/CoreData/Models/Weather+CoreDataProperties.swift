//
//  Weather+CoreDataProperties.swift
//  
//
//  Created by Alya Filon  on 25.05.2020.
//
//

import Foundation
import CoreData


extension Weather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Weather> {
        return NSFetchRequest<Weather>(entityName: "Weather")
    }

    @NSManaged public var id: String
    @NSManaged public var sunrise: String?
    @NSManaged public var sunset: String?
    @NSManaged public var city: String?
    @NSManaged public var countryCode: String?
    @NSManaged public var windSpeed: Double
    @NSManaged public var temperature: Double
    @NSManaged public var feelTemperature: Double
    @NSManaged public var humidity: Double
    @NSManaged public var condition: Condition?

}
