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
    let collectionName: String?
    let artistName: String
    let artworkURL: String

    enum CodingKeys: String, CodingKey {
        case trackName, collectionName, artistName
        case artworkURL = "artworkUrl100"
    }
    
    var albumUrl: String {
        return artworkURL.replacingOccurrences(of: "100x100", with: "1024x1024")
    }
    
    var thumbnailURL: String {
        return artworkURL.replacingOccurrences(of: "100x100", with: "320x320")
    }
    
    func toEntity() -> MusicEntity {
        MusicEntity(trackName: trackName,
                    collectionName: collectionName,
                    artistName: artistName,
                    albumUrl: albumUrl,
                    thumbnailURL: thumbnailURL)
    }
}

struct PodcastResponse: Decodable {
    let resultCount: Int
    let results: [PodcastDTO]
}

struct PodcastDTO: Decodable {
    let trackName: String
    let collectionName: String
    let artistName: String
    let artworkURL: String
    
    enum CodingKeys: String, CodingKey {
        case trackName, collectionName, artistName
        case artworkURL = "artworkUrl100"
    }
    
    var albumUrl: String {
        return artworkURL.replacingOccurrences(of: "100x100", with: "1024x1024")
    }
    
    func toEntity() -> PodcastEntity {
        PodcastEntity(trackName: trackName,
                      collectionName: collectionName,
                      artistName: artistName,
                      albumUrl: albumUrl,
                      recommedComment: RecommendEmoji.podcastRecommendations.randomElement())
    }
}

struct MovieResponse: Decodable {
    let resultCount: Int
    let results: [MovieDTO]
}

struct MovieDTO: Decodable {
    let trackName: String
    let collectionName: String
    let primaryGenreName: String
    let artistName: String
    let artworkURL: String
    
    enum CodingKeys: String, CodingKey {
        case trackName, collectionName, primaryGenreName, artistName
        case artworkURL = "artworkUrl100"
    }
    
    var albumUrl: String {
        return artworkURL.replacingOccurrences(of: "100x100", with: "1024x1024")
    }
    
    func toEntity() -> MovieEntity {
        MovieEntity(trackName: trackName,
                    collectionName: collectionName,
                    primaryGenreName: primaryGenreName,
                    artistName: artistName,
                    albumUrl: albumUrl)
    }
}
