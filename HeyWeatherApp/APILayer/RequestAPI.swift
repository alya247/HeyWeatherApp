//
//  RequestAPI.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 04.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import Foundation
import Alamofire

class RequestAPI {

  static let apiKey = "84bf41643cbb4aec8c4790cc6e3545e2"
  static private let apiURL = "https://api.weatherbit.io/"

  static func requestData<T: Request>(_ request: T, completion: @escaping ((T.ResponseModel?) -> Void)) {

    let url = RequestAPI.apiURL + request.version + request.path

    AF.request(url,
               parameters: request.parameters,
               encoder: URLEncodedFormParameterEncoder.default).responseJSON { r in

                guard let serializedData = request.serializationRule(for: r.value) else {
                  completion(nil)
                  return
                }

                if let weather = try? JSONDecoder().decode(T.ResponseModel.self, from: JSONSerialization.data(withJSONObject: serializedData)) {
                  completion(weather)
                }
    }
  }
  
}
