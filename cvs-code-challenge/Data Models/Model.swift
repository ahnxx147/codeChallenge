//
//  Model.swift
//  cvs-code-challenge
//
//  Created by Jacob Ahn on 7/26/24.
//

import Foundation

struct FlickerImageResponse: Codable {
    let title: String
    let link: String
    let media: [String: String]
    let description: String
    
    var imageUrl: URL? {
        return URL(string: media["m"] ?? "")
    }
    
    enum CodingKeys: String, CodingKey {
        case title
        case link
        case media
        case description
    }
}

struct FlickrItem: Codable {
    let items: [FlickerImageResponse]
}
