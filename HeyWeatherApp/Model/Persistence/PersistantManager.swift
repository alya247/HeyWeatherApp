//
//  PersistantManager.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 25.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import Foundation
import Realm
import DBClient
import RealmSwift

enum StoreType {
  case coreDataClient
  case realmClient
  case fileClient
}

protocol PersistenceHolder {

  var storeType: StoreType { get }
  func saveCurrent(weather: WeatherModel, fileName: String)
  func saveDays(weather: WeatherDaysModel, fileName: String)
  func getCurrentWeather(fileName: String) -> WeatherModel?
  func getPeriodWeather(fileName: String) -> WeatherDaysModel?

}

extension PersistenceHolder {

  var storeType: StoreType {
    return StoreType.fileClient
  }

  func saveCurrent(weather: WeatherModel, fileName: String) {
    switch storeType {
    case .coreDataClient:
      let client = CoreDataDBClient(forModel: "Model")
      client.insert(weather, completion: { _ in })

    case .realmClient: break

    case .fileClient:
      let client = FileManagerClient()
      client.preserve(weather, as: fileName)
    }
  }

  func saveDays(weather: WeatherDaysModel, fileName: String) {
    switch storeType {
    case .coreDataClient:
      let client = CoreDataDBClient(forModel: "Model")
      client.insert(weather, completion: { _ in })

    case .realmClient: break

    case .fileClient:
      let client = FileManagerClient()
      client.preserve(weather, as: fileName)
    }
  }

  func getCurrentWeather(fileName: String) -> WeatherModel? {
    switch storeType {
    case .coreDataClient:
      let client = CoreDataDBClient(forModel: "Model")
      let request = FetchRequest<WeatherModel>()
      let result = client.execute(request)
      return result.value?.first

    case .realmClient: return nil

    case .fileClient:
      let client = FileManagerClient()
      return client.read(fileName, as: WeatherModel.self)
    }
  }

  func getPeriodWeather(fileName: String) -> WeatherDaysModel? {
    switch storeType {
      case .coreDataClient:
        let client = CoreDataDBClient(forModel: "Model")
        let predicate = NSPredicate(format: "id == %@", IdetificatorsProvider.week.rawValue)
        let request = FetchRequest<WeatherDaysModel>(predicate: predicate)
        let result = client.execute(request)
        return result.value?.first

      case .realmClient: return nil

      case .fileClient:
        let client = FileManagerClient()
        return client.read(fileName, as: WeatherDaysModel.self)
      }
  }

}
