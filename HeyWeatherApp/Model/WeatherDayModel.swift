//
//  WeatherDayModel.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 05.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import UIKit
import DBClient
import CoreData

struct WeatherDayModel: Codable {

  var id: String = IdetificatorsProvider.day.rawValue + "\(arc4random())"
  var minTemperature: Double?
  var maxTemperature: Double?
  var windSpeed: Double?
  var condition: WeatherCondition?

  init(entity: DayWeather) {
    self.id = entity.id
    self.minTemperature = entity.minTemperature
    self.maxTemperature = entity.maxTemperature
    self.windSpeed = entity.windSpeed
    self.condition = WeatherCondition(entity: entity.condition)
  }

  enum CodingKeys: String, CodingKey {
    case minTemperature = "minTemp"
    case maxTemperature = "maxTemp"
    case windSpeed = "windSpd"
    case condition = "weather"
  }

}

// MARK: - Stored

extension WeatherDayModel: Stored {

  static var primaryKeyName: String? {
    return "id"
  }

  var valueOfPrimaryKey: CVarArg? {
    return id
  }

}

// MARK: - CoreDataModelConvertible

extension WeatherDayModel: CoreDataModelConvertible {

  static func managedObjectClass() -> NSManagedObject.Type {
    return DayWeather.self
  }

  static func from(_ managedObject: NSManagedObject) -> Stored {
    guard let weather = managedObject as? DayWeather else {
        fatalError("can't create Condition object from object \(managedObject)")
    }
    return WeatherDayModel(entity: weather)
  }

  func upsertManagedObject(in context: NSManagedObjectContext, existedInstance: NSManagedObject?) -> NSManagedObject {
    var weather: DayWeather
    var condition: Condition?
    if let result = existedInstance as? DayWeather, let conditionResult = result.condition {
      weather = result
      condition = conditionResult
    } else {
      weather = NSEntityDescription.insertNewObject(forEntityName: WeatherDayModel.entityName,
                                                    into: context) as! DayWeather
      condition = NSEntityDescription.insertNewObject(forEntityName: WeatherCondition.entityName,
                                                      into: context) as! Condition
    }
    weather.id = IdetificatorsProvider.day.rawValue + "\(arc4random())"
    weather.minTemperature = minTemperature ?? 0
    weather.maxTemperature = maxTemperature ?? 0
    weather.windSpeed = windSpeed ?? 0

    condition?.id = IdetificatorsProvider.condition.rawValue + "\(arc4random())"
    condition?.iconCode = self.condition?.iconCode
    condition?.weatherDescription = self.condition?.description
    weather.condition = condition

    return weather
  }

  static var entityName: String {
    return String(describing: DayWeather.self)
  }

  func isPrimaryValueEqualTo(value: Any) -> Bool {
    if let value = value as? String {
        return value == id
    }
    return false
  }

}
