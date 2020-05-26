//
//  FileManagerClient.swift
//  HeyWeatherApp
//
//  Created by Alya Filon  on 25.05.2020.
//  Copyright © 2020 AlyaFilon. All rights reserved.
//

import Foundation
import DBClient

class FileManagerClient {

  private var documentsDirectory: URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
  }

  func preserve<T: Encodable>(_ object: T, as fileName: String) {
    let url = documentsDirectory.appendingPathComponent(fileName, isDirectory: false)

    let encoder = JSONEncoder()
    do {
      let data = try encoder.encode(object)
      if FileManager.default.fileExists(atPath: url.path) {
        try FileManager.default.removeItem(at: url)
      }
      FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
    } catch {
      fatalError(error.localizedDescription)
    }
  }

  func read<T: Decodable>(_ fileName: String, as type: T.Type) -> T? {
    let url = documentsDirectory.appendingPathComponent(fileName, isDirectory: false)

    if !FileManager.default.fileExists(atPath: url.path) {
      return nil
    }
    if let data = FileManager.default.contents(atPath: url.path) {
      let decoder = JSONDecoder()
      do {
        let model = try decoder.decode(type, from: data)
        return model
      } catch {
        return nil
      }
    } else {
      return nil
    }
  }

}
