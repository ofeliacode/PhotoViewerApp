//
//  NetworkDataFetcher.swift
//  galleryApp
//
//  Created by Офелия Баширова on 05.12.2020.
//

import Foundation

class NetworkDataFetcher {
    var networkService = NetworkService()    
    private let urlScheme = "https"
    private let urlHost = "pixabay.com"
    
    func fetchPics(pageNumber: Int, completion: @escaping (GalleryModel?) -> Void) {
        var components = URLComponents()
            components.scheme = urlScheme
            components.host = urlHost
            components.path = "/api/"
            components.queryItems = [URLQueryItem(name: "key", value: "19398453-c46f698d9d49f2f2ce491d45e"),
                                         URLQueryItem(name: "q", value: "ocean"),
                                         URLQueryItem(name: "image_type", value: "all"),
                                         URLQueryItem(name: "page", value: "\(pageNumber)"),
                                         
                                         
            ]
            guard let url = components.url else { return }
            networkService.request(url: url) { (result) in
            switch result {
            case .success(let data):
                do {
                    let movie = try JSONDecoder().decode(GalleryModel.self, from: data)
                    completion(movie)
                    print("moviee 35 string \(movie)")
                } catch let jsonError {
                    print("Failed to decode JSON (fetchResultOfSearch)", jsonError)
                    completion(nil)
                }
            case .failure(let error):
                print("Error received requesting data: \(error.localizedDescription)")
                completion(nil)
            }
        }
        
    }
    
}

