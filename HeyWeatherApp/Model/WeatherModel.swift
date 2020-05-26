//
//  WeatherModel.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 04.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import UIKit
import DBClient
import CoreData

struct WeatherModel: Codable {

  var id: String = IdetificatorsProvider.current.rawValue
  var sunrise: String?
  var sunset: String?
  var city: String?
  var countryCode: String?
  var windSpeed: Double?
  var temperature: Double?
  var feelTemperature: Double?
  var humidity: Double?
  var condition: WeatherCondition?

  init(entity: Weather) {
    self.id = entity.id
    self.sunrise = entity.sunrise
    self.sunset = entity.sunset
    self.city = entity.city
    self.countryCode = entity.countryCode
    self.windSpeed = entity.windSpeed
    self.temperature = entity.temperature
    self.feelTemperature = entity.feelTemperature
    self.humidity = entity.humidity
    self.condition = WeatherCondition(entity: entity.condition)
  }

  enum CodingKeys: String, CodingKey {
    case sunrise
    case sunset
    case city = "cityName"
    case countryCode = "countryCode"
    case windSpeed = "windSpd"
    case temperature = "temp"
    case feelTemperature = "appTemp"
    case humidity = "rh"
    case condition = "weather"
  }

}

// MARK: - Stored

extension WeatherModel: Stored {

  static var primaryKeyName: String? {
    return "id"
  }

  var valueOfPrimaryKey: CVarArg? {
    return id
  }

}

// MARK: - CoreDataModelConvertible

extension WeatherModel: CoreDataModelConvertible {

  static func managedObjectClass() -> NSManagedObject.Type {
    return Weather.self
  }

  static func from(_ managedObject: NSManagedObject) -> Stored {
    guard let weather = managedObject as? Weather else {
        fatalError("can't create Condition object from object \(managedObject)")
    }
    return WeatherModel(entity: weather)
  }

  func upsertManagedObject(in context: NSManagedObjectContext, existedInstance: NSManagedObject?) -> NSManagedObject {
    var weather: Weather
    var condition: Condition?
    if let result = existedInstance as? Weather, let conditionResult = result.condition {
      weather = result
      condition = conditionResult
    } else {
      weather = NSEntityDescription.insertNewObject(forEntityName: WeatherModel.entityName,
                                                    into: context) as! Weather
      condition = NSEntityDescription.insertNewObject(forEntityName: WeatherCondition.entityName,
                                                      into: context) as! Condition
    }
    weather.id = IdetificatorsProvider.current.rawValue
    weather.sunrise = sunrise
    weather.sunset = sunset
    weather.city = city
    weather.countryCode = countryCode
    weather.windSpeed = windSpeed ?? 0
    weather.temperature = temperature ?? 0
    weather.feelTemperature = feelTemperature ?? 0
    weather.humidity = humidity ?? 0

    condition?.id = IdetificatorsProvider.condition.rawValue + "\(arc4random())"
    condition?.iconCode = self.condition?.iconCode
    condition?.weatherDescription = self.condition?.description
    weather.condition = condition

    return weather
  }

  static var entityName: String {
    return String(describing: Weather.self)
  }

  func isPrimaryValueEqualTo(value: Any) -> Bool {
    if let value = value as? String {
        return value == id
    }
    return false
  }

}
