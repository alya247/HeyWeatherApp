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

public struct WeatherCondition: Codable {

  public var id: String = IdetificatorsProvider.condition.rawValue + "\(arc4random())"
  public var iconCode: String
  public var description: String

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

  public static var primaryKeyName: String? {
    return "id"
  }

  public var valueOfPrimaryKey: CVarArg? {
    return id
  }

}

// MARK: - CoreDataModelConvertible

extension WeatherCondition: CoreDataModelConvertible {

  public static func managedObjectClass() -> NSManagedObject.Type {
    return Condition.self
  }

  public static func from(_ managedObject: NSManagedObject) -> Stored {
    guard let condition = managedObject as? Condition else {
        fatalError("can't create Condition object from object \(managedObject)")
    }
    return WeatherCondition(entity: condition)
  }

  public func upsertManagedObject(in context: NSManagedObjectContext, existedInstance: NSManagedObject?) -> NSManagedObject {
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

  public static var entityName: String {
    return String(describing: Condition.self)
  }

  public func isPrimaryValueEqualTo(value: Any) -> Bool {
    if let value = value as? String {
        return value == id
    }
    return false
  }

}
