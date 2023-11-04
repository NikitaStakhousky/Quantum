//
//  NetwofkService.swift
//  Quantum
//
//  Created by Nikita Stshovsky on 26.07.2023.
//

import Foundation

final class NetworkService {
  
  func getCurrencies(completion: @escaping ([Currency]) -> ()) {
    guard let url = URL(string: "http://65.108.243.149/1/currencies.json") else {return}
    let request = URLRequest(url: url)

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      guard let data = data, error == nil else {
        return
      }
      
      let responseJson = try? JSONDecoder().decode([Currency].self, from: data)
        if let responseJson = responseJson {
          completion(responseJson)
        }
    }
    task.resume()
  }
}
