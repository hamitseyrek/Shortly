//
//  ApiService.swift
//  Shortly
//
//  Created by Hamit Seyrek on 25.04.2022.
//

import Foundation
import Alamofire

protocol ApiServiceProtocol {
    func getInfo(shortenLink: String, completion: @escaping (Result<MainResult?,MyError>) -> Void)
}

class ApiService: ApiServiceProtocol {
    
    func getInfo(shortenLink: String, completion: @escaping (Result<MainResult?,MyError>) -> Void) {
        
        let urlString = "https://api.shrtco.de/v2/shorten?url=\(shortenLink)"
        
        AF.request(urlString)
          .validate()
          .responseDecodable(of: MainResult.self) { (response) in
              
              guard let data = response.data else {
                  return completion(.failure(.init("no data")))
              }
              
              do {
                  let decodeData = try JSONDecoder().decode(MainResult.self, from: data)
                  
                  if decodeData.error != nil {
                      return completion(.failure(.init(decodeData.error!)))
                  } else {
                      completion(.success(decodeData))
                  }
                  
              } catch {
                  print(response.error?.localizedDescription ?? "Something went wrong")
                  return
              }
          }
    }
}
