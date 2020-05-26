//
//  WeatherCondition.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 04.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import Foundation
import DBClient
import CoreData

struct WeatherCondition: Codable {

  var id: String = IdetificatorsProvider.condition.rawValue + "\(arc4random())"
  var iconCode: String
  var description: String

  init(entity: Condition?) {
    self.id = entity?.id ?? ""
    self.iconCode = entity?.iconCode ?? ""
    self.description = entity?.weatherDescription ?? ""
  }

  enum CodingKeys: String, CodingKey {
    case iconCode = "icon"
    case description
  }

}

// MARK: - Stored

extension WeatherCondition: Stored {

  static var primaryKeyName: String? {
    return "id"
  }

  var valueOfPrimaryKey: CVarArg? {
    return id
  }

}

// MARK: - CoreDataModelConvertible

extension WeatherCondition: CoreDataModelConvertible {

  static func managedObjectClass() -> NSManagedObject.Type {
    return Condition.self
  }

  static func from(_ managedObject: NSManagedObject) -> Stored {
    guard let condition = managedObject as? Condition else {
        fatalError("can't create Condition object from object \(managedObject)")
    }
    return WeatherCondition(entity: condition)
  }

  func upsertManagedObject(in context: NSManagedObjectContext, existedInstance: NSManagedObject?) -> NSManagedObject {
    var condition: Condition
    if let result = existedInstance as? Condition {
        condition = result
    } else {
        condition = NSEntityDescription.insertNewObject(forEntityName: WeatherCondition.entityName,
                                                        into: context) as! Condition
    }
    condition.id = IdetificatorsProvider.condition.rawValue + "\(arc4random())"
    condition.iconCode = iconCode
    condition.weatherDescription = description

    return condition
  }

  static var entityName: String {
    return String(describing: Condition.self)
  }

  func isPrimaryValueEqualTo(value: Any) -> Bool {
    if let value = value as? String {
        return value == id
    }
    return false
  }

}
