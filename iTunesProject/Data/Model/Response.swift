//
//  Response.swift
//  iTunesProject
//
//  Created by 백래훈 on 5/13/25.
//

import Foundation

struct MusicResponse: Decodable {
    let resultCount: Int
    let results: [MusicDTO]
}

struct MusicDTO: Decodable {
    let trackName: String
    let artistName: String
    let artworkURL: String
    let collectionName: String

    enum CodingKeys: String, CodingKey {
        case trackName
        case artistName
        case artworkURL = "artworkUrl100"
        case collectionName
    }
    
    func toEntity() -> MusicEntity {
        MusicEntity(trackName: trackName,
                    artistName: artistName,
                    artworkURL: artworkURL,
                    collectionName: collectionName)
    }
}
