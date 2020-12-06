//
//  GalleryModel.swift
//  galleryApp
//
//  Created by Офелия Баширова on 05.12.2020.
//

import Foundation

struct GalleryModel: Codable {
   var hits: [Hitsdata]
}

struct Hitsdata: Codable {
  var img: String?
  var avatar: String?
  var likes: Int?
  var comments: Int?
  var user: String?
    
    private enum CodingKeys: String, CodingKey {
        case likes, comments, user
        case img = "webformatURL"
        case avatar = "userImageURL"
    }
}


