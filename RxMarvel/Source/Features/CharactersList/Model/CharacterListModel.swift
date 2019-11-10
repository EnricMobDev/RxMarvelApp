//
//  CharacterListModel.swift
//  RxMarvel
//
//  Created by Enric Pou Villanueva on 05/11/2019.
//  Copyright © 2019 Enric Pou Villanueva. All rights reserved.
//

import Foundation

// MARK: - MarvelAPI
struct MarvelAPI: Codable {
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let results: [Result]
}

// MARK: - Result
struct Result: Codable {
    let name: String
    let thumbnail: Thumbnail
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let path: String
    let thumbnailExtension: Extension
    
    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
    
    func imageURL(with size: Imagesize = .large) -> String {
        let url = "\(path)/\(size.rawValue).\(thumbnailExtension.rawValue)"
        print(url)
        return url
    }
}

// MARK: - Extension
enum Extension: String, Codable {
    case gif = "gif"
    case jpg = "jpg"
}

// MARK: - ImageSizes
enum Imagesize: String {
    case large = "portrait_xlarge"
    case medium = "portrait_medium"
}

