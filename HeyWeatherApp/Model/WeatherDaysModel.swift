//
//  WeatherDaysModel.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 04.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import UIKit
import DBClient
import CoreData

struct WeatherDaysModel: Codable {

  var id: String = IdetificatorsProvider.week.rawValue
  var city: String?
  var countryCode: String?
  var days: [WeatherDayModel] = []

  init(entity: DaysWeather) {
    self.id = entity.id
    self.city = entity.city
    self.countryCode = entity.countryCode
    if let days = entity.days?.allObjects as? [DayWeather] {
      self.days = days.compactMap { WeatherDayModel(entity: $0) }
    }
  }

  enum CodingKeys: String, CodingKey {
    case city = "cityName"
    case countryCode = "countryCode"
    case days = "data"
  }

}

// MARK: - Stored

extension WeatherDaysModel: Stored {

  static var primaryKeyName: String? {
    return "id"
  }

  var valueOfPrimaryKey: CVarArg? {
    return id
  }

}

// MARK: - CoreDataModelConvertible

extension WeatherDaysModel: CoreDataModelConvertible {

  static func managedObjectClass() -> NSManagedObject.Type {
    return DaysWeather.self
  }

  static func from(_ managedObject: NSManagedObject) -> Stored {
    guard let weather = managedObject as? DaysWeather else {
        fatalError("can't create Condition object from object \(managedObject)")
    }
    return WeatherDaysModel(entity: weather)
  }

  func upsertManagedObject(in context: NSManagedObjectContext, existedInstance: NSManagedObject?) -> NSManagedObject {
    var weather: DaysWeather
    var days: NSSet?
    var conditions: NSSet?

    if let result = existedInstance as? DaysWeather { 
      weather = result
      days = result.days
    } else {
      weather = NSEntityDescription.insertNewObject(forEntityName: WeatherDaysModel.entityName,
                                                    into: context) as! DaysWeather
      var entityDays = [DayWeather]()
      var entityConditions = [Condition]()
      for _ in 0..<self.days.count {
        let entityDay = NSEntityDescription.insertNewObject(forEntityName: WeatherDayModel.entityName,
                                                            into: context) as! DayWeather
        let entityCondition = NSEntityDescription.insertNewObject(forEntityName: WeatherCondition.entityName,
                                                                  into: context) as! Condition
        entityDays.append(entityDay)
        entityConditions.append(entityCondition)
      }
      days = NSSet(array: entityDays)
      conditions = NSSet(array: entityConditions)
    }

    weather.id = IdetificatorsProvider.week.rawValue 
    weather.city = city
    weather.countryCode = countryCode

    if let weatherDays = days?.allObjects as? [DayWeather], let weatherConditions = conditions?.allObjects as? [Condition], weatherDays.count == self.days.count {
      for (index, day) in weatherDays.enumerated() {
        let weatherDay = self.days[index]
        day.id = IdetificatorsProvider.day.rawValue + "\(arc4random())"
        day.minTemperature = weatherDay.minTemperature ?? 0
        day.maxTemperature = weatherDay.maxTemperature ?? 0
        day.windSpeed = weatherDay.windSpeed ?? 0

        weatherConditions[index].id = IdetificatorsProvider.condition.rawValue + "\(arc4random())"
        weatherConditions[index].iconCode = weatherDay.condition?.iconCode
        weatherConditions[index].weatherDescription = weatherDay.condition?.description

        day.condition = weatherConditions[index]
      }
      weather.days = NSSet(array: weatherDays)
    }
    return weather
  }

  static var entityName: String {
    return String(describing: DaysWeather.self)
  }

  func isPrimaryValueEqualTo(value: Any) -> Bool {
    if let value = value as? String {
        return value == id
    }
    return false
  }

}
