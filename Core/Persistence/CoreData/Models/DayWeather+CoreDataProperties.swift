//
//  DayWeather+CoreDataProperties.swift
//  
//
//  Created by Alya Filon  on 25.05.2020.
//
//

import Foundation
import CoreData

extension DayWeather {

    @nonobjc
    public class func fetchRequest() -> NSFetchRequest<DayWeather> {
        return NSFetchRequest<DayWeather>(entityName: "DayWeather")
    }

    @NSManaged public var id: String
    @NSManaged public var minTemperature: Double
    @NSManaged public var maxTemperature: Double
    @NSManaged public var windSpeed: Double
    @NSManaged public var condition: Condition?
    @NSManaged public var weather: DaysWeather?

}
