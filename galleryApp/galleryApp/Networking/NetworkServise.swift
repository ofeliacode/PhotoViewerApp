//
//  NetworkServise.swift
//  galleryApp
//
//  Created by Офелия Баширова on 05.12.2020.
//

import Foundation

class NetworkService {
    
   // MARK: - Create session
    func request(url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                completion(.success(data))
            }
        }.resume()
    }
}
