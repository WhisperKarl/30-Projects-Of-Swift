//
//  Album.swift
//  Project18-BlueLibrarySwift
//
//  Created by Life's a struggle on 2018/8/4.
//  Copyright © 2018年 Karl. All rights reserved.
//

import UIKit

//Decodable & Encodable = Codable
struct Album: Codable {
    var title: String
    var artist: String
    var genre: String
    var coverUrl: String
    var year: String
}


extension Album: CustomStringConvertible {
    // CustomStringConvertible: 自定义 description
    var description: String {
        return "title: \(title)" +
            "artist: \(artist)" +
            "genre: \(genre)" +
            "coverUrl: \(coverUrl)" +
        "year: \(year)"
    }
}

typealias AlbumData = (title: String, value: String)

extension Album {
    var tableRepresentation: [AlbumData] {
        return [
        ("Artist", artist),
        ("Album", title),
        ("Genre", genre),
        ("Year", year)
        ]
    }
}
