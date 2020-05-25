//
//  RequestAPI.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 04.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import Foundation
import YALAPIClient

class RequestAPI {

  static let apiKey = "84bf41643cbb4aec8c4790cc6e3545e2"
  static private let apiURL = "https://api.weatherbit.io/"
  static private let version = "v2.0"

  static var apiClient: NetworkClient {
    let client = APIClient(requestExecutor: AlamofireRequestExecutor(baseURL: URL(string: apiURL + version)!), deserializer: JSONDeserializer())
    return client
  }

  static func requestCurrentWeather(completion: @escaping ((Result<WeatherModel>?) -> Void)) {
    let request = CurrentWeatherRequest()
    let parser = CustomWeatherParser<WeatherModel>(serializationRule: request.serializationRule)

    apiClient.execute(request: request, parser: parser, completion: { result in
      switch result {
      case .success(let data):
        print(data)
        completion(.success(data))
      case .failure(let error):
        completion(.failure(error))
      }
    })

  }

  static func requestWeatherInDays(daysCount: Int, completion: @escaping ((Result<WeatherDaysModel>?) -> Void)) {
    let request = WeatherInDaysRequest(days: daysCount)
    let parser = CustomWeatherParser<WeatherDaysModel>(serializationRule: request.serializationRule)

    apiClient.execute(request: request, parser: parser, completion: { result in
      switch result {
      case .success(let data):
        print(data)
        completion(.success(data))
      case .failure(let error):
        completion(.failure(error))
      }
    })

  }
  
}
