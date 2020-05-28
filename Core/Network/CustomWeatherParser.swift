//
//  CustomWeatherParser.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 21.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import Foundation
import YALAPIClient

protocol SerializationRule {

  func serializationRule(for data: Any?) -> [String: Any]?

}

class CustomWeatherParser<T: Decodable>: ResponseParser {

  typealias Representation = T

  let decoder: JSONDecoder = defaultDecoder

  private let serializationRule: ((Any?) -> [String: Any]?)

  init(serializationRule: @escaping ((Any?) -> [String: Any]?)) {
    self.serializationRule = serializationRule
  }

  func parse(_ object: AnyObject) -> Result<Representation> {
      do {
        guard let value = serializationRule(object) else { throw ParserError.keyNotFound }
        let data = try JSONSerialization.data(withJSONObject: value)
        let decoded = try decoder.decode(Representation.self, from: data)
        return .success(decoded)
      } catch let error {
          return .failure(error)
      }
  }

}
