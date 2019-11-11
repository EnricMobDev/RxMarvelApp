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
    let comics, series: Comics
    let stories: Stories
    let events: Comics
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let path: String
    let thumbnailExtension: Extension
    
    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
    
    func imageURL(with size: Imagesize = .large) -> URL? {
        let stringURL = "\(path)/\(size.rawValue).\(thumbnailExtension.rawValue)"
        return URL(string: stringURL)
    }
}

// MARK: - Comics
struct Comics: Codable {
    let available: Int
}

// MARK: - Stories
struct Stories: Codable {
    let available: Int
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

